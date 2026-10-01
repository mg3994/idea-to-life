import 'package:flutter/material.dart';
import '../../../../../core/schema_ld/schema_ld.dart';

/// UI component for rendering Schema.org `@type: "Recipe"`.
class RecipeCardView extends StatelessWidget {
  final RecipeLd recipe;

  const RecipeCardView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Chip(
                  avatar: const Icon(Icons.restaurant_menu, size: 16),
                  label: const Text('Recipe'),
                  backgroundColor: theme.colorScheme.secondaryContainer,
                ),
                const Spacer(),
                if (recipe.prepTime != null || recipe.cookTime != null)
                  Text(
                    'Prep: ${recipe.prepTime ?? '-'} | Cook: ${recipe.cookTime ?? '-'}',
                    style: theme.textTheme.bodySmall,
                  ),
              ],
            ),
            const SizedBox(height: 12),

            Text(
              recipe.name,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            if (recipe.description != null) ...[
              Text(recipe.description!, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 16),
            ],

            if (recipe.recipeIngredients.isNotEmpty) ...[
              Text('Ingredients:', style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              ...recipe.recipeIngredients.map((ing) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        Icon(Icons.fiber_manual_record,
                            size: 8, color: theme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Expanded(child: Text(ing)),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}
