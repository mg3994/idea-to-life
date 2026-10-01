import 'package:flutter/material.dart';
import '../../../../../core/schema_ld/schema_ld.dart';
import 'blog_posting_view.dart';
import 'event_card_view.dart';
import 'local_business_view.dart';
import 'product_card_view.dart';
import 'recipe_card_view.dart';
import 'review_rating_view.dart';
import 'service_catalog_view.dart';

/// Dynamic polymorphic UI Resolver for Schema.org JSON-LD nodes.
class SchemaLdUiResolver extends StatelessWidget {
  final SchemaLdNode node;
  final VoidCallback? onCommentTap;
  final ValueChanged<int>? onAddToCart;
  final VoidCallback? onBookAppointment;
  final VoidCallback? onDirectionsTap;
  final VoidCallback? onCallTap;

  const SchemaLdUiResolver({
    super.key,
    required this.node,
    this.onCommentTap,
    this.onAddToCart,
    this.onBookAppointment,
    this.onDirectionsTap,
    this.onCallTap,
  });

  factory SchemaLdUiResolver.fromJsonString(
    String jsonStr, {
    Key? key,
    SchemaLdReferenceRegistry? registry,
    VoidCallback? onCommentTap,
    ValueChanged<int>? onAddToCart,
    VoidCallback? onBookAppointment,
    VoidCallback? onDirectionsTap,
    VoidCallback? onCallTap,
  }) {
    final parser = SchemaLdParser(registry: registry);
    final parsedNode = parser.parseJsonString(jsonStr);
    return SchemaLdUiResolver(
      key: key,
      node: parsedNode,
      onCommentTap: onCommentTap,
      onAddToCart: onAddToCart,
      onBookAppointment: onBookAppointment,
      onDirectionsTap: onDirectionsTap,
      onCallTap: onCallTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentNode = node;

    if (currentNode is BlogPostingLd) {
      return BlogPostingView(
        article: currentNode,
        onCommentTap: onCommentTap,
      );
    }

    if (currentNode is ProductLd) {
      return ProductCardView(
        product: currentNode,
        onAddToCart: onAddToCart,
      );
    }

    if (currentNode is ServiceLd) {
      return ServiceCatalogView(
        service: currentNode,
        onBookAppointment: onBookAppointment,
      );
    }

    if (currentNode is LocalBusinessLd) {
      return LocalBusinessView(
        business: currentNode,
        onDirectionsTap: onDirectionsTap,
        onCallTap: onCallTap,
      );
    }

    if (currentNode is EventLd) {
      return EventCardView(
        event: currentNode,
      );
    }

    if (currentNode is RecipeLd) {
      return RecipeCardView(
        recipe: currentNode,
      );
    }

    if (currentNode is ReviewLd) {
      return ReviewRatingView(
        review: currentNode,
      );
    }

    if (currentNode is SchemaLdGraph) {
      return Column(
        children: currentNode.nodes
            .map((subNode) => SchemaLdUiResolver(
                  node: subNode,
                  onCommentTap: onCommentTap,
                  onAddToCart: onAddToCart,
                  onBookAppointment: onBookAppointment,
                  onDirectionsTap: onDirectionsTap,
                  onCallTap: onCallTap,
                ))
            .toList(),
      );
    }

    if (currentNode is SchemaLdArray) {
      return Column(
        children: currentNode.elements
            .map((elem) => SchemaLdUiResolver(
                  node: elem,
                  onCommentTap: onCommentTap,
                  onAddToCart: onAddToCart,
                  onBookAppointment: onBookAppointment,
                  onDirectionsTap: onDirectionsTap,
                  onCallTap: onCallTap,
                ))
            .toList(),
      );
    }

    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Chip(
              avatar: const Icon(Icons.code, size: 16),
              label: Text(
                currentNode is SchemaLdObject
                    ? (currentNode.type ?? 'Schema.org Object')
                    : 'Schema.org Node',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              currentNode.toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
