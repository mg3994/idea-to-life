import 'package:flutter/foundation.dart';
import 'schema_ld_keywords.dart';

/// Sealed base class for all Schema.org JSON-LD AST nodes.
@immutable
sealed class SchemaLdNode {
  const SchemaLdNode();

  /// Converts the AST node back to a standard JSON object/primitive.
  Object? toJson();
}

/// Primitive JSON-LD node (String, num, bool, or null).
final class SchemaLdPrimitive extends SchemaLdNode {
  final Object? value;

  const SchemaLdPrimitive(this.value);

  @override
  Object? toJson() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchemaLdPrimitive &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'SchemaLdPrimitive($value)';
}

/// JSON-LD Value object node holding `@value`, optional `@language` and `@type`.
final class SchemaLdValueNode extends SchemaLdNode {
  final Object? value;
  final String? language;
  final String? valueType;

  const SchemaLdValueNode({
    required this.value,
    this.language,
    this.valueType,
  });

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{SchemaLdKeywords.value: value};
    if (language != null) map[SchemaLdKeywords.language] = language;
    if (valueType != null) map[SchemaLdKeywords.type] = valueType;
    return map;
  }

  @override
  String toString() =>
      'SchemaLdValueNode(value: $value, lang: $language, type: $valueType)';
}

/// Array node in JSON-LD.
final class SchemaLdArray extends SchemaLdNode {
  final List<SchemaLdNode> elements;

  const SchemaLdArray(this.elements);

  @override
  List<Object?> toJson() => elements.map((e) => e.toJson()).toList();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchemaLdArray &&
          runtimeType == other.runtimeType &&
          listEquals(elements, other.elements);

  @override
  int get hashCode => Object.hashAll(elements);

  @override
  String toString() => 'SchemaLdArray($elements)';
}

/// JSON-LD `@graph` container holding multiple top-level nodes.
final class SchemaLdGraph extends SchemaLdNode {
  final List<SchemaLdObject> nodes;
  final String? context;

  const SchemaLdGraph({
    required this.nodes,
    this.context,
  });

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (context != null) map[SchemaLdKeywords.context] = context;
    map[SchemaLdKeywords.graph] = nodes.map((n) => n.toJson()).toList();
    return map;
  }

  @override
  String toString() => 'SchemaLdGraph(nodesCount: ${nodes.length})';
}

/// Abstract base class for Schema.org Object nodes with JSON-LD metadata.
sealed class SchemaLdObject extends SchemaLdNode {
  final String? id;
  final String? type;
  final String? context;
  final Map<String, SchemaLdNode> rawFields;

  const SchemaLdObject({
    this.id,
    this.type,
    this.context,
    required this.rawFields,
  });

  /// Helper to extract string value from primitive or language-tagged value node.
  String? getString(String key) {
    final node = rawFields[key];
    if (node is SchemaLdPrimitive && node.value is String) {
      return node.value as String;
    }
    if (node is SchemaLdValueNode && node.value != null) {
      return node.value.toString();
    }
    return null;
  }

  /// Helper to extract double value.
  double? getDouble(String key) {
    final node = rawFields[key];
    if (node is SchemaLdPrimitive) {
      if (node.value is num) {
        return (node.value as num).toDouble();
      } else if (node.value is String) {
        return double.tryParse(node.value as String);
      }
    }
    if (node is SchemaLdValueNode && node.value != null) {
      return double.tryParse(node.value.toString());
    }
    return null;
  }

  /// Helper to extract int value.
  int? getInt(String key) {
    final node = rawFields[key];
    if (node is SchemaLdPrimitive) {
      if (node.value is num) {
        return (node.value as num).toInt();
      } else if (node.value is String) {
        return int.tryParse(node.value as String);
      }
    }
    if (node is SchemaLdValueNode && node.value != null) {
      return int.tryParse(node.value.toString());
    }
    return null;
  }

  /// Helper to extract list of strings.
  List<String> getStringList(String key) {
    final node = rawFields[key];
    if (node is SchemaLdArray) {
      return node.elements
          .map((e) {
            if (e is SchemaLdPrimitive) return e.value?.toString();
            if (e is SchemaLdValueNode) return e.value?.toString();
            return null;
          })
          .whereType<String>()
          .toList();
    } else if (node is SchemaLdPrimitive && node.value != null) {
      return [node.value.toString()];
    } else if (node is SchemaLdValueNode && node.value != null) {
      return [node.value.toString()];
    }
    return const [];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (context != null) map[SchemaLdKeywords.context] = context;
    if (type != null) map[SchemaLdKeywords.type] = type;
    if (id != null) map[SchemaLdKeywords.id] = id;
    for (final entry in rawFields.entries) {
      map[entry.key] = entry.value.toJson();
    }
    return map;
  }
}

/// Fallback Schema.org object representation for unspecialized `@type`s.
final class GenericSchemaLd extends SchemaLdObject {
  const GenericSchemaLd({
    super.id,
    super.type,
    super.context,
    required super.rawFields,
  });

  @override
  String toString() => 'GenericSchemaLd(type: $type, id: $id)';
}

/// Schema.org `@type: "BlogPosting"`, `"Article"`, or `"NewsArticle"`.
final class BlogPostingLd extends SchemaLdObject {
  final String headline;
  final String? articleBody;
  final String? authorName;
  final String? datePublished;
  final String? dateModified;
  final String? image;
  final int commentCount;
  final int readingTimeMinutes;

  BlogPostingLd({
    super.id,
    super.type = SchemaLdKeywords.blogPosting,
    super.context,
    required super.rawFields,
    required this.headline,
    this.articleBody,
    this.authorName,
    this.datePublished,
    this.dateModified,
    this.image,
    this.commentCount = 0,
    this.readingTimeMinutes = 3,
  });

  @override
  String toString() => 'BlogPostingLd(headline: $headline, author: $authorName)';
}

/// Schema.org `@type: "Product"`.
final class ProductLd extends SchemaLdObject {
  final String name;
  final String? description;
  final String? image;
  final double price;
  final String priceCurrency;
  final String availability;
  final String? sku;
  final String? brand;
  final List<String> variants;

  ProductLd({
    super.id,
    super.type = SchemaLdKeywords.product,
    super.context,
    required super.rawFields,
    required this.name,
    this.description,
    this.image,
    this.price = 0.0,
    this.priceCurrency = 'USD',
    this.availability = 'https://schema.org/InStock',
    this.sku,
    this.brand,
    this.variants = const [],
  });

  @override
  String toString() => 'ProductLd(name: $name, price: $price $priceCurrency)';
}

/// Schema.org `@type: "Service"`.
final class ServiceLd extends SchemaLdObject {
  final String name;
  final String? description;
  final String? serviceType;
  final String? providerName;
  final String? areaServed;
  final double price;
  final String priceCurrency;
  final List<String> offerPackages;

  ServiceLd({
    super.id,
    super.type = SchemaLdKeywords.service,
    super.context,
    required super.rawFields,
    required this.name,
    this.description,
    this.serviceType,
    this.providerName,
    this.areaServed,
    this.price = 0.0,
    this.priceCurrency = 'USD',
    this.offerPackages = const [],
  });

  @override
  String toString() => 'ServiceLd(name: $name, serviceType: $serviceType)';
}

/// Schema.org `@type: "LocalBusiness"`, `"Restaurant"`, or `"Store"`.
final class LocalBusinessLd extends SchemaLdObject {
  final String name;
  final String? description;
  final String? image;
  final String? telephone;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? openingHours;
  final String? priceRange;
  final String? servesCuisine;

  LocalBusinessLd({
    super.id,
    super.type = SchemaLdKeywords.localBusiness,
    super.context,
    required super.rawFields,
    required this.name,
    this.description,
    this.image,
    this.telephone,
    this.address,
    this.latitude,
    this.longitude,
    this.openingHours,
    this.priceRange,
    this.servesCuisine,
  });

  @override
  String toString() => 'LocalBusinessLd(name: $name, address: $address)';
}

/// Schema.org `@type: "Organization"`.
final class OrganizationLd extends SchemaLdObject {
  final String name;
  final String? url;
  final String? logo;
  final String? email;
  final String? telephone;
  final String? address;

  OrganizationLd({
    super.id,
    super.type = SchemaLdKeywords.organization,
    super.context,
    required super.rawFields,
    required this.name,
    this.url,
    this.logo,
    this.email,
    this.telephone,
    this.address,
  });

  @override
  String toString() => 'OrganizationLd(name: $name, email: $email)';
}

/// Schema.org `@type: "Event"`.
final class EventLd extends SchemaLdObject {
  final String name;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? locationName;
  final double price;
  final String priceCurrency;

  EventLd({
    super.id,
    super.type = SchemaLdKeywords.event,
    super.context,
    required super.rawFields,
    required this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.locationName,
    this.price = 0.0,
    this.priceCurrency = 'USD',
  });

  @override
  String toString() => 'EventLd(name: $name, startDate: $startDate)';
}

/// Schema.org `@type: "Recipe"`.
final class RecipeLd extends SchemaLdObject {
  final String name;
  final String? description;
  final String? image;
  final String? authorName;
  final String? prepTime;
  final String? cookTime;
  final List<String> recipeIngredients;
  final List<String> recipeInstructions;

  RecipeLd({
    super.id,
    super.type = SchemaLdKeywords.recipe,
    super.context,
    required super.rawFields,
    required this.name,
    this.description,
    this.image,
    this.authorName,
    this.prepTime,
    this.cookTime,
    this.recipeIngredients = const [],
    this.recipeInstructions = const [],
  });

  @override
  String toString() => 'RecipeLd(name: $name, prepTime: $prepTime)';
}

/// Schema.org `@type: "Review"` or `"AggregateRating"`.
final class ReviewLd extends SchemaLdObject {
  final String? itemReviewedName;
  final String? authorName;
  final double ratingValue;
  final double bestRating;
  final String? reviewBody;

  ReviewLd({
    super.id,
    super.type = SchemaLdKeywords.review,
    super.context,
    required super.rawFields,
    this.itemReviewedName,
    this.authorName,
    this.ratingValue = 5.0,
    this.bestRating = 5.0,
    this.reviewBody,
  });

  @override
  String toString() =>
      'ReviewLd(rating: $ratingValue/$bestRating, item: $itemReviewedName)';
}
