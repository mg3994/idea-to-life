import 'schema_ld_ast.dart';
import 'schema_ld_keywords.dart';

/// Engine for applying field overrides and merging Linked Data objects.
class SchemaLdOverrideEngine {
  /// Deep-merges an [overrides] map on top of a [base] map.
  static Map<String, dynamic> mergeRawMaps(
    Map<String, dynamic> base,
    Map<String, dynamic> overrides,
  ) {
    final result = Map<String, dynamic>.from(base);

    for (final entry in overrides.entries) {
      final key = entry.key;
      final value = entry.value;

      if (key == SchemaLdKeywords.ref) {
        continue;
      }

      final existing = result[key];
      if (existing is Map<String, dynamic> && value is Map<String, dynamic>) {
        result[key] = mergeRawMaps(existing, value);
      } else {
        result[key] = value;
      }
    }

    return result;
  }

  /// Merges two AST fields map.
  static Map<String, SchemaLdNode> mergeAstFields(
    Map<String, SchemaLdNode> baseFields,
    Map<String, SchemaLdNode> overrideFields,
  ) {
    final result = Map<String, SchemaLdNode>.from(baseFields);

    for (final entry in overrideFields.entries) {
      final key = entry.key;
      final overrideNode = entry.value;

      if (key == SchemaLdKeywords.ref || key == SchemaLdKeywords.overrides) {
        continue;
      }

      final baseNode = result[key];
      if (baseNode is SchemaLdObject && overrideNode is SchemaLdObject) {
        final mergedFields = mergeAstFields(
          baseNode.rawFields,
          overrideNode.rawFields,
        );
        result[key] = GenericSchemaLd(
          id: overrideNode.id ?? baseNode.id,
          type: overrideNode.type ?? baseNode.type,
          context: overrideNode.context ?? baseNode.context,
          rawFields: mergedFields,
        );
      } else {
        result[key] = overrideNode;
      }
    }

    return result;
  }
}
