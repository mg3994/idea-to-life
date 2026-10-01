import 'package:flutter/material.dart';
import '../../../../core/schema_ld/schema_ld.dart';
import '../widgets/schema_ui/schema_ui.dart';

/// Screen for rendering any `/blog/:blogId/post/:postId` content powered by Schema.org JSON-LD.
class BlogPostScreen extends StatefulWidget {
  final String blogId;
  final String postId;
  final String? initialJsonLdPayload;

  const BlogPostScreen({
    super.key,
    required this.blogId,
    required this.postId,
    this.initialJsonLdPayload,
  });

  @override
  State<BlogPostScreen> createState() => _BlogPostScreenState();
}

class _BlogPostScreenState extends State<BlogPostScreen> {
  late SchemaLdNode _parsedNode;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSchemaData();
  }

  void _loadSchemaData() {
    if (widget.initialJsonLdPayload != null) {
      final parser = SchemaLdParser();
      _parsedNode = parser.parseJsonString(widget.initialJsonLdPayload!);
    } else {
      final sampleJson = _generateDynamicSampleJson(
        widget.blogId,
        widget.postId,
      );
      final parser = SchemaLdParser();
      _parsedNode = parser.parseJsonString(sampleJson);
    }
  }

  String _generateDynamicSampleJson(String blogId, String postId) {
    if (postId.contains('prod') || postId.contains('item')) {
      return '''
      {
        "@context": "https://schema.org",
        "@type": "Product",
        "@id": "$blogId:$postId",
        "name": "Featured Product ($blogId - $postId)",
        "description": "Dynamic Schema.org Product listing provided by vendor $blogId.",
        "brand": "Vendor $blogId",
        "offers": {
          "@type": "Offer",
          "price": 89.99,
          "priceCurrency": "USD",
          "availability": "https://schema.org/InStock"
        },
        "variants": ["Option A", "Option B", "Option C"]
      }
      ''';
    }

    if (postId.contains('service') || postId.contains('book')) {
      return '''
      {
        "@context": "https://schema.org",
        "@type": "Service",
        "@id": "$blogId:$postId",
        "name": "Strategy Session ($blogId - $postId)",
        "description": "Dedicated appointment & consultation package by $blogId.",
        "serviceType": "Consulting",
        "provider": "Provider $blogId",
        "price": 120.00,
        "priceCurrency": "USD",
        "offers": ["Basic Session", "Premium Session"]
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
        "description": "Interactive local business view for $blogId.",
        "telephone": "+1-800-555-0199",
        "address": "789 Commerce Way, Suite 100",
        "geo": {
          "@type": "GeoCoordinates",
          "latitude": 37.7749,
          "longitude": -122.4194
        },
        "openingHours": "Mo-Sa 09:00-20:00"
      }
      ''';
    }

    return '''
    {
      "@context": "https://schema.org",
      "@type": "BlogPosting",
      "@id": "$blogId:$postId",
      "headline": "Listing Headline ($blogId / $postId)",
      "articleBody": "This article demonstrates structured content storage and rendering using Schema.org JSON-LD.",
      "author": {
        "@type": "Person",
        "name": "Author $blogId"
      },
      "datePublished": "2025-01-01T00:00:00Z",
      "commentCount": 5,
      "readingTimeMinutes": 3
    }
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post ${widget.postId} (${widget.blogId})'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Link: /blog/${widget.blogId}/post/${widget.postId}',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SchemaLdUiResolver(
                node: _parsedNode,
                onAddToCart: (qty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added $qty item(s) to Cart!'),
                    ),
                  );
                },
                onBookAppointment: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booked appointment successfully!'),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
