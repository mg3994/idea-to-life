import 'package:flutter/material.dart';
import '../../../../../core/schema_ld/schema_ld.dart';

/// UI component for rendering Schema.org `@type: "BlogPosting"` or `"Article"`.
class BlogPostingView extends StatelessWidget {
  final BlogPostingLd article;
  final VoidCallback? onCommentTap;

  const BlogPostingView({
    super.key,
    required this.article,
    this.onCommentTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Chip(
                  avatar: const Icon(Icons.article, size: 16),
                  label: Text(article.type ?? 'BlogPosting'),
                  backgroundColor: theme.colorScheme.primaryContainer,
                ),
                const Spacer(),
                Icon(Icons.timer_outlined, size: 16, color: theme.colorScheme.secondary),
                const SizedBox(width: 4),
                Text(
                  '${article.readingTimeMinutes} min read',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Text(
              article.headline,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            if (article.authorName != null || article.datePublished != null)
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: theme.colorScheme.primary,
                    child: Text(
                      (article.authorName ?? 'A')[0].toUpperCase(),
                      style: TextStyle(color: theme.colorScheme.onPrimary),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (article.authorName != null)
                        Text(
                          article.authorName!,
                          style: theme.textTheme.titleSmall,
                        ),
                      if (article.datePublished != null)
                        Text(
                          article.datePublished!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 16),

            if (article.image != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  article.image!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 120,
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: const Center(
                      child: Icon(Icons.image_not_supported_outlined, size: 48),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            Text(
              article.articleBody ?? 'No content provided.',
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 20),

            const Divider(),
            Row(
              children: [
                TextButton.icon(
                  onPressed: onCommentTap,
                  icon: const Icon(Icons.comment_outlined),
                  label: Text('${article.commentCount} Comments'),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sharing: ${article.headline}')),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
