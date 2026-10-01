import 'package:flutter_test/flutter_test.dart';
import 'package:unique_flutter/core/schema_ld/schema_ld.dart';

void main() {
  group('Schema JSON-LD Engine Tests', () {
    late SchemaLdParser parser;

    setUp(() {
      parser = SchemaLdParser();
    });

    test('Parses BlogPosting JSON-LD payload into BlogPostingLd AST node', () {
      final jsonStr = '''
      {
        "@context": "https://schema.org",
        "@type": "BlogPosting",
        "@id": "blog1:post101",
        "headline": "Serverpod + Flutter Dynamic LD Architecture",
        "articleBody": "This post explains dynamic JSON-LD rendering.",
        "author": {
          "@type": "Person",
          "name": "Jane Doe"
        },
        "datePublished": "2025-01-01T00:00:00Z",
        "commentCount": 12,
        "readingTimeMinutes": 5
      }
      ''';

      final node = parser.parseJsonString(jsonStr);
      expect(node, isA<BlogPostingLd>());

      final blogPost = node as BlogPostingLd;
      expect(blogPost.headline, 'Serverpod + Flutter Dynamic LD Architecture');
      expect(blogPost.authorName, 'Jane Doe');
      expect(blogPost.commentCount, 12);
      expect(blogPost.readingTimeMinutes, 5);
      expect(blogPost.id, 'blog1:post101');
    });

    test('Parses Product JSON-LD payload with nested offer details', () {
      final jsonStr = '''
      {
        "@context": "https://schema.org",
        "@type": "Product",
        "@id": "storeA:prod202",
        "name": "E-Commerce Widget",
        "description": "High performance widget",
        "brand": "TechCorp",
        "offers": {
          "@type": "Offer",
          "price": 49.99,
          "priceCurrency": "USD",
          "availability": "https://schema.org/InStock"
        },
        "variants": ["Red", "Blue", "Green"]
      }
      ''';

      final node = parser.parseJsonString(jsonStr);
      expect(node, isA<ProductLd>());

      final product = node as ProductLd;
      expect(product.name, 'E-Commerce Widget');
      expect(product.price, 49.99);
      expect(product.priceCurrency, 'USD');
      expect(product.brand, 'TechCorp');
      expect(product.variants, containsAll(['Red', 'Blue', 'Green']));
    });

    test('Parses @graph payload containing multiple JSON-LD nodes', () {
      final jsonStr = '''
      {
        "@context": "https://schema.org",
        "@graph": [
          {
            "@type": "LocalBusiness",
            "name": "Downtown Bakery",
            "telephone": "+1-555-0100"
          },
          {
            "@type": "Recipe",
            "name": "Chocolate Cake",
            "prepTime": "PT20M",
            "cookTime": "PT40M"
          }
        ]
      }
      ''';

      final node = parser.parseJsonString(jsonStr);
      expect(node, isA<SchemaLdGraph>());

      final graph = node as SchemaLdGraph;
      expect(graph.nodes.length, 2);
      expect(graph.nodes[0], isA<LocalBusinessLd>());
      expect(graph.nodes[1], isA<RecipeLd>());
    });

    test('Parses language-tagged @value nodes', () {
      final jsonStr = '''
      {
        "@context": "https://schema.org",
        "@type": "BlogPosting",
        "headline": {
          "@value": "Hola Mundo",
          "@language": "es"
        }
      }
      ''';

      final node = parser.parseJsonString(jsonStr) as BlogPostingLd;
      expect(node.headline, 'Hola Mundo');
    });

    test('Supports @ref referencing and @overrides field modification', () {
      final baseProductJson = '''
      {
        "@context": "https://schema.org",
        "@type": "Product",
        "@id": "baseBlog:item001",
        "name": "Base Leather Jacket",
        "description": "Genuine leather jacket",
        "offers": {
          "price": 199.99,
          "priceCurrency": "USD"
        }
      }
      ''';
      final baseObj = parser.parseJsonString(baseProductJson) as SchemaLdObject;
      parser.registry.register('baseBlog:item001', baseObj);

      final overridePayloadStr = '''
      {
        "@context": "https://schema.org",
        "@type": "Product",
        "@ref": "baseBlog:item001",
        "@overrides": {
          "name": "Discounted Base Leather Jacket",
          "offers": {
            "price": 149.99
          }
        }
      }
      ''';

      final overriddenNode = parser.parseJsonString(overridePayloadStr);
      expect(overriddenNode, isA<ProductLd>());

      final product = overriddenNode as ProductLd;
      expect(product.name, 'Discounted Base Leather Jacket');
      expect(product.description, 'Genuine leather jacket');
      expect(product.price, 149.99);
      expect(product.priceCurrency, 'USD');
    });
  });
}
