import 'package:flutter/material.dart';
import '../../../../../core/schema_ld/schema_ld.dart';

/// UI component for rendering Schema.org `@type: "Review"` or `"AggregateRating"`.
class ReviewRatingView extends StatelessWidget {
  final ReviewLd review;

  const ReviewRatingView({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ...List.generate(5, (index) {
                  final starVal = index + 1;
                  return Icon(
                    starVal <= review.ratingValue
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber,
                    size: 20,
                  );
                }),
                const SizedBox(width: 8),
                Text(
                  '${review.ratingValue} / ${review.bestRating}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            if (review.itemReviewedName != null) ...[
              Text(
                'Review for: ${review.itemReviewedName}',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
            ],

            if (review.reviewBody != null) ...[
              Text(review.reviewBody!, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 8),
            ],

            if (review.authorName != null)
              Text(
                '- ${review.authorName}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
