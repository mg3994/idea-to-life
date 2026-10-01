/// Standard JSON-LD 1.1 Keywords and Schema.org vocabulary constants.
abstract final class SchemaLdKeywords {
  // Official JSON-LD 1.1 Keywords
  static const String context = '@context';
  static const String type = '@type';
  static const String id = '@id';
  static const String graph = '@graph';
  static const String value = '@value';
  static const String language = '@language';
  static const String set = '@set';
  static const String list = '@list';
  static const String reverse = '@reverse';
  static const String base = '@base';
  static const String index = '@index';
  static const String container = '@container';
  static const String direction = '@direction';
  static const String importKeyword = '@import';

  /// Custom override keyword for linking and field overriding
  static const String ref = '@ref';
  static const String overrides = '@overrides';

  /// Known Schema.org @type constants
  static const String blogPosting = 'BlogPosting';
  static const String article = 'Article';
  static const String newsArticle = 'NewsArticle';
  static const String product = 'Product';
  static const String service = 'Service';
  static const String localBusiness = 'LocalBusiness';
  static const String restaurant = 'Restaurant';
  static const String store = 'Store';
  static const String organization = 'Organization';
  static const String corporation = 'Corporation';
  static const String event = 'Event';
  static const String offer = 'Offer';
  static const String offerCatalog = 'OfferCatalog';
  static const String geoCoordinates = 'GeoCoordinates';
  static const String postalAddress = 'PostalAddress';
  static const String person = 'Person';
  static const String place = 'Place';
  static const String recipe = 'Recipe';
  static const String review = 'Review';
  static const String aggregateRating = 'AggregateRating';
  static const String creativeWork = 'CreativeWork';
  static const String webPage = 'WebPage';
  static const String medicalEntity = 'MedicalEntity';

  /// Standard Schema.org Context URL
  static const String schemaOrgContext = 'https://schema.org';
}
