/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class UserAppearanceSettings
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
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

  static final t = UserAppearanceSettingsTable();

  static const db = UserAppearanceSettingsRepository._();

  @override
  int? id;

  int userId;

  String themeMode;

  int seedColor;

  String locale;

  DateTime updatedAt;

  @override
  _i1.Table<int> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'themeMode': themeMode,
      'seedColor': seedColor,
      'locale': locale,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static UserAppearanceSettingsInclude include() {
    return UserAppearanceSettingsInclude._();
  }

  static UserAppearanceSettingsIncludeList includeList({
    _i1.WhereExpressionBuilder<UserAppearanceSettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserAppearanceSettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserAppearanceSettingsTable>? orderByList,
    UserAppearanceSettingsInclude? include,
  }) {
    return UserAppearanceSettingsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserAppearanceSettings.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserAppearanceSettings.t),
      include: include,
    );
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

class UserAppearanceSettingsTable extends _i1.Table<int> {
  UserAppearanceSettingsTable({super.tableAlias})
      : super(tableName: 'user_appearance_settings') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    themeMode = _i1.ColumnString(
      'themeMode',
      this,
    );
    seedColor = _i1.ColumnInt(
      'seedColor',
      this,
    );
    locale = _i1.ColumnString(
      'locale',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString themeMode;

  late final _i1.ColumnInt seedColor;

  late final _i1.ColumnString locale;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        themeMode,
        seedColor,
        locale,
        updatedAt,
      ];
}

class UserAppearanceSettingsInclude extends _i1.IncludeObject {
  UserAppearanceSettingsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => UserAppearanceSettings.t;
}

class UserAppearanceSettingsIncludeList extends _i1.IncludeList {
  UserAppearanceSettingsIncludeList._({
    super.where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.table = UserAppearanceSettings.t;
  }

  @override
  _i1.Table<int> get table => UserAppearanceSettings.t;
}

class UserAppearanceSettingsRepository {
  const UserAppearanceSettingsRepository._();

  Future<List<UserAppearanceSettings>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserAppearanceSettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserAppearanceSettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserAppearanceSettingsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserAppearanceSettings>(
      where: where?.call(UserAppearanceSettings.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserAppearanceSettings.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserAppearanceSettings.t),
      transaction: transaction,
    );
  }

  Future<UserAppearanceSettings?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserAppearanceSettingsTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserAppearanceSettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserAppearanceSettingsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UserAppearanceSettings>(
      where: where?.call(UserAppearanceSettings.t),
      offset: offset,
      orderBy: orderBy?.call(UserAppearanceSettings.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserAppearanceSettings.t),
      transaction: transaction,
    );
  }

  Future<UserAppearanceSettings?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UserAppearanceSettings>(id, transaction: transaction);
  }

  Future<List<UserAppearanceSettings>> insert(
    _i1.Session session,
    List<UserAppearanceSettings> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserAppearanceSettings>(rows, transaction: transaction);
  }

  Future<UserAppearanceSettings> insertRow(
    _i1.Session session,
    UserAppearanceSettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserAppearanceSettings>(row, transaction: transaction);
  }

  Future<List<UserAppearanceSettings>> update(
    _i1.Session session,
    List<UserAppearanceSettings> rows, {
    _i1.ColumnSet<UserAppearanceSettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserAppearanceSettings>(
      rows,
      columns: columns?.call(UserAppearanceSettings.t),
      transaction: transaction,
    );
  }

  Future<UserAppearanceSettings> updateRow(
    _i1.Session session,
    UserAppearanceSettings row, {
    _i1.ColumnSet<UserAppearanceSettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserAppearanceSettings>(
      row,
      columns: columns?.call(UserAppearanceSettings.t),
      transaction: transaction,
    );
  }

  Future<List<UserAppearanceSettings>> delete(
    _i1.Session session,
    List<UserAppearanceSettings> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserAppearanceSettings>(rows, transaction: transaction);
  }

  Future<UserAppearanceSettings> deleteRow(
    _i1.Session session,
    UserAppearanceSettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserAppearanceSettings>(row, transaction: transaction);
  }

  Future<List<UserAppearanceSettings>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserAppearanceSettingsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserAppearanceSettings>(
      where: where(UserAppearanceSettings.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserAppearanceSettingsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserAppearanceSettings>(
      where: where?.call(UserAppearanceSettings.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
