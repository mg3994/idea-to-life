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
      // Default sample payload for blogId and postId demonstration
      final sampleJson = '''
      {
        "@context": "https://schema.org",
        "@type": "Product",
        "@id": "${widget.blogId}:${widget.postId}",
        "name": "Featured Listing (${widget.blogId} - ${widget.postId})",
        "description": "Dynamic Schema.org Linked Data listing provided by store/provider ${widget.blogId}.",
        "brand": "Provider ${widget.blogId}",
        "offers": {
          "@type": "Offer",
          "price": 89.99,
          "priceCurrency": "USD",
          "availability": "https://schema.org/InStock"
        },
        "variants": ["Option A", "Option B", "Option C"]
      }
      ''';
      final parser = SchemaLdParser();
      _parsedNode = parser.parseJsonString(sampleJson);
    }
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
