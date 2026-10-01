import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unique_flutter/features/stores/presentation/widgets/schema_ui/schema_ui.dart';

void main() {
  group('Schema.org Dynamic UI Resolver Widget Tests', () {
    testWidgets('Renders BlogPostingView when payload @type is BlogPosting',
        (WidgetTester tester) async {
      final jsonStr = '''
      {
        "@context": "https://schema.org",
        "@type": "BlogPosting",
        "headline": "Testing Dynamic UI Resolver",
        "articleBody": "This is a test article body.",
        "author": "John Smith"
      }
      ''';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SchemaLdUiResolver.fromJsonString(jsonStr),
          ),
        ),
      );

      expect(find.text('Testing Dynamic UI Resolver'), findsOneWidget);
      expect(find.text('This is a test article body.'), findsOneWidget);
      expect(find.text('John Smith'), findsOneWidget);
      expect(find.byType(BlogPostingView), findsOneWidget);
    });

    testWidgets('Renders ProductCardView when payload @type is Product',
        (WidgetTester tester) async {
      final jsonStr = '''
      {
        "@context": "https://schema.org",
        "@type": "Product",
        "name": "Smart Watch",
        "brand": "TechBand",
        "offers": {
          "price": 129.99,
          "priceCurrency": "USD"
        }
      }
      ''';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SchemaLdUiResolver.fromJsonString(jsonStr),
          ),
        ),
      );

      expect(find.text('Smart Watch'), findsOneWidget);
      expect(find.text('By TechBand'), findsOneWidget);
      expect(find.text('USD \$129.99'), findsOneWidget);
      expect(find.byType(ProductCardView), findsOneWidget);
    });

    testWidgets('Renders LocalBusinessView when payload @type is LocalBusiness',
        (WidgetTester tester) async {
      final jsonStr = '''
      {
        "@context": "https://schema.org",
        "@type": "LocalBusiness",
        "name": "Downtown Bakery",
        "telephone": "+1-555-0100",
        "address": "456 Market St"
      }
      ''';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SchemaLdUiResolver.fromJsonString(jsonStr),
          ),
        ),
      );

      expect(find.text('Downtown Bakery'), findsOneWidget);
      expect(find.text('+1-555-0100'), findsOneWidget);
      expect(find.text('456 Market St'), findsOneWidget);
      expect(find.byType(LocalBusinessView), findsOneWidget);
    });

    testWidgets('Renders RecipeCardView when payload @type is Recipe',
        (WidgetTester tester) async {
      final jsonStr = '''
      {
        "@context": "https://schema.org",
        "@type": "Recipe",
        "name": "Pan Seared Salmon",
        "description": "Delicious salmon dish",
        "recipeIngredient": ["Salmon Filet", "Lemon", "Olive Oil"]
      }
      ''';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SchemaLdUiResolver.fromJsonString(jsonStr),
          ),
        ),
      );

      expect(find.text('Pan Seared Salmon'), findsOneWidget);
      expect(find.text('Salmon Filet'), findsOneWidget);
      expect(find.byType(RecipeCardView), findsOneWidget);
    });
  });
}
