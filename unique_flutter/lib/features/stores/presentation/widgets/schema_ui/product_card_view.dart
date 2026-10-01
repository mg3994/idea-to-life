import 'package:flutter/material.dart';
import '../../../../../core/schema_ld/schema_ld.dart';

/// UI component for rendering Schema.org `@type: "Product"`.
class ProductCardView extends StatefulWidget {
  final ProductLd product;
  final ValueChanged<int>? onAddToCart;

  const ProductCardView({
    super.key,
    required this.product,
    this.onAddToCart,
  });

  @override
  State<ProductCardView> createState() => _ProductCardViewState();
}

class _ProductCardViewState extends State<ProductCardView> {
  String? selectedVariant;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    if (widget.product.variants.isNotEmpty) {
      selectedVariant = widget.product.variants.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = widget.product;
    final isInStock = product.availability.contains('InStock');

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
                  avatar: const Icon(Icons.shopping_bag, size: 16),
                  label: const Text('Product'),
                  backgroundColor: theme.colorScheme.tertiaryContainer,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isInStock
                        ? Colors.green.withValues(alpha: 0.15)
                        : Colors.red.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isInStock ? 'In Stock' : 'Out of Stock',
                    style: TextStyle(
                      color: isInStock ? Colors.green.shade800 : Colors.red.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Text(
              product.name,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (product.brand != null) ...[
              const SizedBox(height: 4),
              Text(
                'By ${product.brand}',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
            const SizedBox(height: 16),

            if (product.image != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.image!,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 140,
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: const Center(
                      child: Icon(Icons.storefront_outlined, size: 48),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            if (product.description != null) ...[
              Text(
                product.description!,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
            ],

            Row(
              children: [
                Text(
                  '${product.priceCurrency} \$${product.price.toStringAsFixed(2)}',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.primary,
                  ),
                ),
                if (product.sku != null) ...[
                  const Spacer(),
                  Text(
                    'SKU: ${product.sku}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),

            if (product.variants.isNotEmpty) ...[
              Text(
                'Select Variant:',
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: product.variants.map((v) {
                  final isSelected = selectedVariant == v;
                  return ChoiceChip(
                    label: Text(v),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => selectedVariant = v);
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],

            Row(
              children: [
                Row(
                  children: [
                    IconButton.outlined(
                      icon: const Icon(Icons.remove, size: 18),
                      onPressed: quantity > 1
                          ? () => setState(() => quantity--)
                          : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '$quantity',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    IconButton.outlined(
                      icon: const Icon(Icons.add, size: 18),
                      onPressed: () => setState(() => quantity++),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: isInStock
                        ? () {
                            widget.onAddToCart?.call(quantity);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Added $quantity x ${product.name} to Cart',
                                ),
                              ),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text('Add to Cart'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
