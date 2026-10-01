import 'dart:convert';
import 'schema_ld_ast.dart';
import 'schema_ld_keywords.dart';
import 'schema_ld_override.dart';
import 'schema_ld_reference.dart';

/// Central parser and factory for Schema.org JSON-LD payloads.
class SchemaLdParser {
  final SchemaLdReferenceRegistry registry;

  SchemaLdParser({SchemaLdReferenceRegistry? registry})
      : registry = registry ?? SchemaLdReferenceRegistry();

  /// Parse a JSON string into a [SchemaLdNode].
  SchemaLdNode parseJsonString(String rawJson) {
    final decoded = json.decode(rawJson);
    return parse(decoded);
  }

  /// Parse any dynamic object (Map, List, or Primitive) into a [SchemaLdNode].
  SchemaLdNode parse(Object? input) {
    if (input == null) {
      return const SchemaLdPrimitive(null);
    }
    if (input is bool || input is num || input is String) {
      return SchemaLdPrimitive(input);
    }
    if (input is List) {
      final elements = input.map((item) => parse(item)).toList();
      return SchemaLdArray(elements);
    }
    if (input is Map) {
      final mapInput = Map<String, dynamic>.from(input);

      // 1. Check for @value language-tagged primitive node
      if (mapInput.containsKey(SchemaLdKeywords.value)) {
        return SchemaLdValueNode(
          value: mapInput[SchemaLdKeywords.value],
          language: mapInput[SchemaLdKeywords.language]?.toString(),
          valueType: mapInput[SchemaLdKeywords.type]?.toString(),
        );
      }

      // 2. Check for @graph node container
      if (mapInput.containsKey(SchemaLdKeywords.graph)) {
        final graphData = mapInput[SchemaLdKeywords.graph];
        final context = mapInput[SchemaLdKeywords.context]?.toString();
        if (graphData is List) {
          final nodes = graphData
              .map((item) => parse(item))
              .whereType<SchemaLdObject>()
              .toList();
          return SchemaLdGraph(nodes: nodes, context: context);
        }
      }

      return parseObjectMap(mapInput);
    }

    return SchemaLdPrimitive(input.toString());
  }

  /// Parse a Map into a specialized [SchemaLdObject].
  SchemaLdObject parseObjectMap(Map<String, dynamic> mapInput) {
    Map<String, dynamic> rawMap = Map<String, dynamic>.from(mapInput);

    // 1. Handle Reference (@ref) and Overrides (@overrides) resolution
    final refVal = rawMap[SchemaLdKeywords.ref]?.toString();
    if (refVal != null && refVal.isNotEmpty) {
      final baseReferencedObj = registry.resolve(refVal);
      if (baseReferencedObj != null) {
        final baseJson = baseReferencedObj.toJson();
        final overrides = rawMap[SchemaLdKeywords.overrides] is Map
            ? Map<String, dynamic>.from(rawMap[SchemaLdKeywords.overrides] as Map)
            : rawMap;

        rawMap = SchemaLdOverrideEngine.mergeRawMaps(baseJson, overrides);
      }
    }

    // 2. Extract standard keywords
    final context = rawMap[SchemaLdKeywords.context]?.toString();
    final typeVal = rawMap[SchemaLdKeywords.type]?.toString();
    final idVal = rawMap[SchemaLdKeywords.id]?.toString();

    // 3. Build rawFields AST map
    final rawFields = <String, SchemaLdNode>{};
    for (final entry in rawMap.entries) {
      if (entry.key == SchemaLdKeywords.context ||
          entry.key == SchemaLdKeywords.type ||
          entry.key == SchemaLdKeywords.id) {
        continue;
      }
      rawFields[entry.key] = parse(entry.value);
    }

    // 4. Construct specialized AST object based on @type
    final normalizedType = _normalizeType(typeVal);

    final SchemaLdObject parsedObject;
    switch (normalizedType) {
      case SchemaLdKeywords.blogPosting:
      case SchemaLdKeywords.article:
      case SchemaLdKeywords.newsArticle:
        parsedObject = _buildBlogPosting(idVal, typeVal, context, rawFields);
        break;

      case SchemaLdKeywords.product:
        parsedObject = _buildProduct(idVal, typeVal, context, rawFields);
        break;

      case SchemaLdKeywords.service:
        parsedObject = _buildService(idVal, typeVal, context, rawFields);
        break;

      case SchemaLdKeywords.localBusiness:
      case SchemaLdKeywords.restaurant:
      case SchemaLdKeywords.store:
        parsedObject = _buildLocalBusiness(idVal, typeVal, context, rawFields);
        break;

      case SchemaLdKeywords.organization:
      case SchemaLdKeywords.corporation:
        parsedObject = _buildOrganization(idVal, typeVal, context, rawFields);
        break;

      case SchemaLdKeywords.event:
        parsedObject = _buildEvent(idVal, typeVal, context, rawFields);
        break;

      case SchemaLdKeywords.recipe:
        parsedObject = _buildRecipe(idVal, typeVal, context, rawFields);
        break;

      case SchemaLdKeywords.review:
      case SchemaLdKeywords.aggregateRating:
        parsedObject = _buildReview(idVal, typeVal, context, rawFields);
        break;

      default:
        parsedObject = GenericSchemaLd(
          id: idVal,
          type: typeVal,
          context: context,
          rawFields: rawFields,
        );
        break;
    }

    // 5. Register in registry if idVal is present
    if (idVal != null && idVal.isNotEmpty) {
      registry.register(idVal, parsedObject);
    }

    return parsedObject;
  }

  String? _normalizeType(String? rawType) {
    if (rawType == null) return null;
    final lower = rawType.toLowerCase();
    if (lower.contains('blogposting') || lower.contains('article')) {
      return SchemaLdKeywords.blogPosting;
    }
    if (lower.contains('product')) {
      return SchemaLdKeywords.product;
    }
    if (lower.contains('service')) {
      return SchemaLdKeywords.service;
    }
    if (lower.contains('localbusiness') ||
        lower.contains('store') ||
        lower.contains('restaurant') ||
        lower.contains('shop')) {
      return SchemaLdKeywords.localBusiness;
    }
    if (lower.contains('organization') || lower.contains('corporation')) {
      return SchemaLdKeywords.organization;
    }
    if (lower.contains('event')) {
      return SchemaLdKeywords.event;
    }
    if (lower.contains('recipe')) {
      return SchemaLdKeywords.recipe;
    }
    if (lower.contains('review') || lower.contains('rating')) {
      return SchemaLdKeywords.review;
    }
    return rawType;
  }

  BlogPostingLd _buildBlogPosting(
    String? id,
    String? type,
    String? context,
    Map<String, SchemaLdNode> rawFields,
  ) {
    final temp = GenericSchemaLd(
      id: id,
      type: type,
      context: context,
      rawFields: rawFields,
    );

    return BlogPostingLd(
      id: id,
      type: type ?? SchemaLdKeywords.blogPosting,
      context: context,
      rawFields: rawFields,
      headline: temp.getString('headline') ?? temp.getString('name') ?? 'Untitled Post',
      articleBody: temp.getString('articleBody') ?? temp.getString('description'),
      authorName: _extractAuthorName(rawFields['author']),
      datePublished: temp.getString('datePublished'),
      dateModified: temp.getString('dateModified'),
      image: _extractImageUrl(rawFields['image']),
      commentCount: temp.getInt('commentCount') ?? 0,
      readingTimeMinutes: temp.getInt('readingTimeMinutes') ?? 3,
    );
  }

  ProductLd _buildProduct(
    String? id,
    String? type,
    String? context,
    Map<String, SchemaLdNode> rawFields,
  ) {
    final temp = GenericSchemaLd(
      id: id,
      type: type,
      context: context,
      rawFields: rawFields,
    );

    double price = 0.0;
    String currency = 'USD';
    String availability = 'InStock';

    final offersNode = rawFields['offers'];
    if (offersNode is SchemaLdObject) {
      price = offersNode.getDouble('price') ?? 0.0;
      currency = offersNode.getString('priceCurrency') ?? 'USD';
      availability = offersNode.getString('availability') ?? 'InStock';
    } else {
      price = temp.getDouble('price') ?? 0.0;
      currency = temp.getString('priceCurrency') ?? 'USD';
    }

    return ProductLd(
      id: id,
      type: type ?? SchemaLdKeywords.product,
      context: context,
      rawFields: rawFields,
      name: temp.getString('name') ?? temp.getString('headline') ?? 'Untitled Product',
      description: temp.getString('description'),
      image: _extractImageUrl(rawFields['image']),
      price: price,
      priceCurrency: currency,
      availability: availability,
      sku: temp.getString('sku'),
      brand: temp.getString('brand'),
      variants: temp.getStringList('variants'),
    );
  }

  ServiceLd _buildService(
    String? id,
    String? type,
    String? context,
    Map<String, SchemaLdNode> rawFields,
  ) {
    final temp = GenericSchemaLd(
      id: id,
      type: type,
      context: context,
      rawFields: rawFields,
    );

    return ServiceLd(
      id: id,
      type: type ?? SchemaLdKeywords.service,
      context: context,
      rawFields: rawFields,
      name: temp.getString('name') ?? 'Untitled Service',
      description: temp.getString('description'),
      serviceType: temp.getString('serviceType'),
      providerName: temp.getString('provider') ?? temp.getString('providerName'),
      areaServed: temp.getString('areaServed'),
      price: temp.getDouble('price') ?? 0.0,
      priceCurrency: temp.getString('priceCurrency') ?? 'USD',
      offerPackages: temp.getStringList('offers'),
    );
  }

  LocalBusinessLd _buildLocalBusiness(
    String? id,
    String? type,
    String? context,
    Map<String, SchemaLdNode> rawFields,
  ) {
    final temp = GenericSchemaLd(
      id: id,
      type: type,
      context: context,
      rawFields: rawFields,
    );

    double? lat;
    double? lng;
    final geoNode = rawFields['geo'];
    if (geoNode is SchemaLdObject) {
      lat = geoNode.getDouble('latitude');
      lng = geoNode.getDouble('longitude');
    } else {
      lat = temp.getDouble('latitude');
      lng = temp.getDouble('longitude');
    }

    return LocalBusinessLd(
      id: id,
      type: type ?? SchemaLdKeywords.localBusiness,
      context: context,
      rawFields: rawFields,
      name: temp.getString('name') ?? 'Local Business',
      description: temp.getString('description'),
      image: _extractImageUrl(rawFields['image']),
      telephone: temp.getString('telephone') ?? temp.getString('phone'),
      address: temp.getString('address'),
      latitude: lat,
      longitude: lng,
      openingHours: temp.getString('openingHours'),
      priceRange: temp.getString('priceRange'),
      servesCuisine: temp.getString('servesCuisine'),
    );
  }

  OrganizationLd _buildOrganization(
    String? id,
    String? type,
    String? context,
    Map<String, SchemaLdNode> rawFields,
  ) {
    final temp = GenericSchemaLd(
      id: id,
      type: type,
      context: context,
      rawFields: rawFields,
    );

    return OrganizationLd(
      id: id,
      type: type ?? SchemaLdKeywords.organization,
      context: context,
      rawFields: rawFields,
      name: temp.getString('name') ?? 'Organization',
      url: temp.getString('url'),
      logo: temp.getString('logo'),
      email: temp.getString('email'),
      telephone: temp.getString('telephone'),
      address: temp.getString('address'),
    );
  }

  EventLd _buildEvent(
    String? id,
    String? type,
    String? context,
    Map<String, SchemaLdNode> rawFields,
  ) {
    final temp = GenericSchemaLd(
      id: id,
      type: type,
      context: context,
      rawFields: rawFields,
    );

    return EventLd(
      id: id,
      type: type ?? SchemaLdKeywords.event,
      context: context,
      rawFields: rawFields,
      name: temp.getString('name') ?? 'Upcoming Event',
      description: temp.getString('description'),
      startDate: temp.getString('startDate'),
      endDate: temp.getString('endDate'),
      locationName: temp.getString('location'),
      price: temp.getDouble('price') ?? 0.0,
      priceCurrency: temp.getString('priceCurrency') ?? 'USD',
    );
  }

  RecipeLd _buildRecipe(
    String? id,
    String? type,
    String? context,
    Map<String, SchemaLdNode> rawFields,
  ) {
    final temp = GenericSchemaLd(
      id: id,
      type: type,
      context: context,
      rawFields: rawFields,
    );

    return RecipeLd(
      id: id,
      type: type ?? SchemaLdKeywords.recipe,
      context: context,
      rawFields: rawFields,
      name: temp.getString('name') ?? 'Recipe',
      description: temp.getString('description'),
      image: _extractImageUrl(rawFields['image']),
      authorName: _extractAuthorName(rawFields['author']),
      prepTime: temp.getString('prepTime'),
      cookTime: temp.getString('cookTime'),
      recipeIngredients: temp.getStringList('recipeIngredient'),
      recipeInstructions: temp.getStringList('recipeInstructions'),
    );
  }

  ReviewLd _buildReview(
    String? id,
    String? type,
    String? context,
    Map<String, SchemaLdNode> rawFields,
  ) {
    final temp = GenericSchemaLd(
      id: id,
      type: type,
      context: context,
      rawFields: rawFields,
    );

    double rating = 5.0;
    double best = 5.0;
    final ratingNode = rawFields['reviewRating'];
    if (ratingNode is SchemaLdObject) {
      rating = ratingNode.getDouble('ratingValue') ?? 5.0;
      best = ratingNode.getDouble('bestRating') ?? 5.0;
    } else {
      rating = temp.getDouble('ratingValue') ?? 5.0;
      best = temp.getDouble('bestRating') ?? 5.0;
    }

    return ReviewLd(
      id: id,
      type: type ?? SchemaLdKeywords.review,
      context: context,
      rawFields: rawFields,
      itemReviewedName: temp.getString('itemReviewed'),
      authorName: _extractAuthorName(rawFields['author']),
      ratingValue: rating,
      bestRating: best,
      reviewBody: temp.getString('reviewBody'),
    );
  }

  String? _extractAuthorName(SchemaLdNode? authorNode) {
    if (authorNode is SchemaLdPrimitive && authorNode.value is String) {
      return authorNode.value as String;
    }
    if (authorNode is SchemaLdObject) {
      return authorNode.getString('name');
    }
    return null;
  }

  String? _extractImageUrl(SchemaLdNode? imageNode) {
    if (imageNode is SchemaLdPrimitive && imageNode.value is String) {
      return imageNode.value as String;
    }
    if (imageNode is SchemaLdObject) {
      return imageNode.getString('url');
    }
    if (imageNode is SchemaLdArray && imageNode.elements.isNotEmpty) {
      final first = imageNode.elements.first;
      if (first is SchemaLdPrimitive && first.value is String) {
        return first.value as String;
      }
    }
    return null;
  }
}
