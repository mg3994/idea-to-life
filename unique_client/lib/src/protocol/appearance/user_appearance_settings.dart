/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class UserAppearanceSettings implements _i1.SerializableModel {
  UserAppearanceSettings._({
    this.id,
    required this.userId,
    required this.themeMode,
    required this.seedColor,
    required this.locale,
    required this.updatedAt,
  });

  factory UserAppearanceSettings({
    int? id,
    required int userId,
    required String themeMode,
    required int seedColor,
    required String locale,
    required DateTime updatedAt,
  }) = _UserAppearanceSettingsImpl;

  factory UserAppearanceSettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserAppearanceSettings(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      themeMode: jsonSerialization['themeMode'] as String,
      seedColor: jsonSerialization['seedColor'] as int,
      locale: jsonSerialization['locale'] as String,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  int? id;

  int userId;

  String themeMode;

  int seedColor;

  String locale;

  DateTime updatedAt;

  UserAppearanceSettings copyWith({
    int? id,
    int? userId,
    String? themeMode,
    int? seedColor,
    String? locale,
    DateTime? updatedAt,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'themeMode': themeMode,
      'seedColor': seedColor,
      'locale': locale,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserAppearanceSettingsImpl extends UserAppearanceSettings {
  _UserAppearanceSettingsImpl({
    int? id,
    required int userId,
    required String themeMode,
    required int seedColor,
    required String locale,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          themeMode: themeMode,
          seedColor: seedColor,
          locale: locale,
          updatedAt: updatedAt,
        );

  @override
  UserAppearanceSettings copyWith({
    Object? id = _Undefined,
    int? userId,
    String? themeMode,
    int? seedColor,
    String? locale,
    DateTime? updatedAt,
  }) {
    return UserAppearanceSettings(
      id: id == _Undefined ? this.id : id as int?,
      userId: userId ?? this.userId,
      themeMode: themeMode ?? this.themeMode,
      seedColor: seedColor ?? this.seedColor,
      locale: locale ?? this.locale,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
