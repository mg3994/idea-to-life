import 'package:flutter_test/flutter_test.dart';
import 'package:unique_flutter/core/schema_ld/schema_ld.dart';

void main() {
  group('AppStackCodec Deep Linking Tests', () {
    test('RefKeys parse blogId and postId correctly', () {
      final key1 = SchemaLdRefKey.tryParse('blog123:post456');
      expect(key1, isNotNull);
      expect(key1!.blogId, 'blog123');
      expect(key1.postId, 'post456');

      final key2 = SchemaLdRefKey.tryParse('/blog/store99/post/prod11');
      expect(key2, isNotNull);
      expect(key2!.blogId, 'store99');
      expect(key2.postId, 'prod11');
    });
  });
}
