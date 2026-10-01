import 'schema_ld_ast.dart';

/// Uniquely identifies a Schema JSON-LD resource by [blogId] and [postId].
class SchemaLdRefKey {
  final String blogId;
  final String postId;

  const SchemaLdRefKey({required this.blogId, required this.postId});

  /// Parse from string formats like "blogId:postId", "ref://blog/blogId/post/postId", or "/blog/blogId/post/postId".
  static SchemaLdRefKey? tryParse(String refStr) {
    if (refStr.isEmpty) return null;

    if (refStr.contains(':') && !refStr.contains('/')) {
      final parts = refStr.split(':');
      if (parts.length == 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
        return SchemaLdRefKey(blogId: parts[0], postId: parts[1]);
      }
    }

    final Uri? uri = Uri.tryParse(refStr);
    if (uri != null) {
      final segments = uri.pathSegments;
      for (var i = 0; i < segments.length - 3; i++) {
        if (segments[i] == 'blog' && segments[i + 2] == 'post') {
          return SchemaLdRefKey(
            blogId: segments[i + 1],
            postId: segments[i + 3],
          );
        }
      }
    }

    return null;
  }

  String toStorageKey() => '$blogId:$postId';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchemaLdRefKey &&
          runtimeType == other.runtimeType &&
          blogId == other.blogId &&
          postId == other.postId;

  @override
  int get hashCode => Object.hash(blogId, postId);

  @override
  String toString() => 'SchemaLdRefKey($blogId:$postId)';
}

/// Registry for caching and resolving linked data cross-references.
class SchemaLdReferenceRegistry {
  final Map<String, SchemaLdObject> _cache = {};

  void register(String key, SchemaLdObject object) {
    _cache[key] = object;
    if (object.id != null) {
      _cache[object.id!] = object;
    }
  }

  void registerRef(String blogId, String postId, SchemaLdObject object) {
    final key = SchemaLdRefKey(blogId: blogId, postId: postId).toStorageKey();
    register(key, object);
  }

  SchemaLdObject? resolve(String keyOrRef) {
    final parsedKey = SchemaLdRefKey.tryParse(keyOrRef);
    if (parsedKey != null) {
      final cached = _cache[parsedKey.toStorageKey()];
      if (cached != null) return cached;
    }
    return _cache[keyOrRef];
  }

  void clear() => _cache.clear();
}
