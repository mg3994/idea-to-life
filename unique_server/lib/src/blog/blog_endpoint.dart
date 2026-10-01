import 'package:serverpod/serverpod.dart';

/// Serverpod endpoint for serving Schema.org JSON-LD content payloads.
class BlogEndpoint extends Endpoint {
  /// Fetches the Schema.org JSON-LD payload for a given [blogId] and [postId].
  Future<String> getBlogPost(
    Session session,
    String blogId,
    String postId,
  ) async {
    // Generate appropriate Schema.org payload depending on postId or mock context
    if (postId.contains('prod') || postId.contains('item')) {
      return '''
      {
        "@context": "https://schema.org",
        "@type": "Product",
        "@id": "$blogId:$postId",
        "name": "Serverpod Commerce Item $postId",
        "description": "Native Serverpod backed product listing under shop $blogId.",
        "brand": "Vendor $blogId",
        "offers": {
          "@type": "Offer",
          "price": 149.99,
          "priceCurrency": "USD",
          "availability": "https://schema.org/InStock"
        },
        "variants": ["Standard", "Pro", "Enterprise"]
      }
      ''';
    }

    if (postId.contains('service') || postId.contains('book')) {
      return '''
      {
        "@context": "https://schema.org",
        "@type": "Service",
        "@id": "$blogId:$postId",
        "name": "Professional Consulting Service",
        "description": "1-on-1 strategy & implementation session with provider $blogId.",
        "serviceType": "Consulting",
        "provider": "Provider $blogId",
        "price": 199.00,
        "priceCurrency": "USD",
        "offers": ["30 Minute Intro", "60 Minute Full Strategy", "Monthly Retainer"]
      }
      ''';
    }

    if (postId.contains('biz') || postId.contains('local')) {
      return '''
      {
        "@context": "https://schema.org",
        "@type": "LocalBusiness",
        "@id": "$blogId:$postId",
        "name": "Local Storefront ($blogId)",
        "description": "Interactive local business listing for provider $blogId.",
        "telephone": "+1-800-555-0199",
        "address": "789 Commerce Way, Suite 100",
        "geo": {
          "@type": "GeoCoordinates",
          "latitude": 37.7749,
          "longitude": -122.4194
        },
        "openingHours": "Mo-Sa 09:00-20:00",
        "priceRange": "\$\$"
      }
      ''';
    }

    // Default: BlogPosting
    return '''
    {
      "@context": "https://schema.org",
      "@type": "BlogPosting",
      "@id": "$blogId:$postId",
      "headline": "Welcome to Provider $blogId Post $postId",
      "articleBody": "This content article is dynamically delivered via Serverpod Identity & JSON-LD payload endpoints.",
      "author": {
        "@type": "Person",
        "name": "Creator $blogId"
      },
      "datePublished": "2025-01-01T12:00:00Z",
      "commentCount": 8,
      "readingTimeMinutes": 4
    }
    ''';
  }
}
