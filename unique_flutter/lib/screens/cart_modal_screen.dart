import 'package:flutter/material.dart';

/// Commerce cart drawer/modal for managing orders and checkout.
class CartModalScreen extends StatefulWidget {
  const CartModalScreen({super.key});

  @override
  State<CartModalScreen> createState() => _CartModalScreenState();
}

class _CartModalScreenState extends State<CartModalScreen> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      'title': 'E-Commerce Widget Product',
      'price': 49.99,
      'quantity': 1,
      'variant': 'Blue'
    },
    {
      'title': 'Consulting Service Package',
      'price': 99.00,
      'quantity': 1,
      'variant': 'Standard'
    },
  ];

  double get _totalPrice => _cartItems.fold(
        0.0,
        (sum, item) =>
            sum + ((item['price'] as double) * (item['quantity'] as int)),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart & Order'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _cartItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined,
                              size: 64, color: theme.colorScheme.outline),
                          const SizedBox(height: 16),
                          Text('Your cart is empty',
                              style: theme.textTheme.titleMedium),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _cartItems.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = _cartItems[index];
                        return ListTile(
                          title: Text(
                            item['title'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Variant: ${item['variant']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    color: Colors.red),
                                onPressed: () {
                                  setState(() => _cartItems.removeAt(index));
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Amount:', style: theme.textTheme.titleMedium),
                      Text(
                        '\$${_totalPrice.toStringAsFixed(2)}',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _cartItems.isEmpty
                          ? null
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Order placed successfully! Thank you.'),
                                ),
                              );
                              Navigator.of(context).pop(true);
                            },
                      icon: const Icon(Icons.payment),
                      label: const Text('Proceed to Checkout'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
