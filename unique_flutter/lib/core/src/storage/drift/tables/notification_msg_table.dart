import 'package:drift/drift.dart';

import '../app_database.dart';

part 'notification_msg_table.g.dart';

class NotificationMessages extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// FCM message ID.
  TextColumn get messageId => text().nullable().unique()();

  /// FCM sender ID.
  TextColumn get senderId => text().nullable()();

  /// FCM `from` field.
  TextColumn get from => text().nullable()();

  /// Message type supplied by FCM.
  TextColumn get messageType => text().nullable()();

  /// Collapse key supplied by FCM.
  TextColumn get collapseKey => text().nullable()();

  /// iOS category.
  TextColumn get category => text().nullable()();

  /// iOS action identifier.
  TextColumn get actionIdentifier => text().nullable()();

  /// Whether this was a content-available/background message.
  BoolColumn get contentAvailable =>
      boolean().withDefault(const Constant(false))();

  /// Whether APNs mutable-content was enabled.
  BoolColumn get mutableContent =>
      boolean().withDefault(const Constant(false))();

  /// FCM message TTL in seconds.
  IntColumn get ttl => integer().nullable()();

  /// Time at which FCM reports that the message was sent.
  DateTimeColumn get sentTime => dateTime().nullable()();

  /// Notification title.
  TextColumn get title => text().nullable()();

  /// Notification body.
  TextColumn get body => text().nullable()();

  /// Android/iOS/Web image URL.
  TextColumn get imageUrl => text().nullable()();

  /// Notification link.
  TextColumn get link => text().nullable()();

  /// Custom FCM data payload encoded as JSON.
  TextColumn get data => text().nullable()();

  /// Whether the notification has been opened by the user.
  BoolColumn get isOpened => boolean().withDefault(const Constant(false))();

  /// Time at which this application stored the message.
  DateTimeColumn get receivedAt => dateTime()();
}

@DriftAccessor(tables: [NotificationMessages])
class NotificationMsgDao extends DatabaseAccessor<AppDatabase>
    with _$NotificationMsgDaoMixin {
  NotificationMsgDao(super.db);

  /// Helper expression to identify expired messages:
  /// (sent_time + ttl seconds < current_time)
  Expression<bool> get _isNotExpired {
    return notificationMessages.sentTime.isNull() |
        notificationMessages.ttl.isNull() |
        const CustomExpression<bool>(
          // FIX: Changed to single quotes for SQLite string literals
          "strftime('%s', sent_time) + ttl >= strftime('%s', 'now')",
        );
  }

  /// Deletes all messages where the TTL duration has elapsed since sentTime.
  Future<int> deleteExpiredMessages() {
    return (delete(notificationMessages)..where(
          (table) =>
              table.sentTime.isNotNull() &
              table.ttl.isNotNull() &
              const CustomExpression<bool>(
                // FIX: Changed to single quotes for SQLite string literals
                "strftime('%s', sent_time) + ttl < strftime('%s', 'now')",
              ),
        ))
        .go();
  }

  Future<void> insertNotificationMessage(
    NotificationMessagesCompanion companion,
  ) {
    return into(notificationMessages).insert(companion);
  }

  Future<void> markAsOpened(String messageId) {
    return (update(notificationMessages)
          ..where((table) => table.messageId.equals(messageId)))
        .write(const NotificationMessagesCompanion(isOpened: Value(true)));
  }

  Future<void> deleteMessage(String messageId) {
    return (delete(
      notificationMessages,
    )..where((table) => table.messageId.equals(messageId))).go();
  }

  Future<NotificationMessage?> getMessage(String messageId) {
    return (select(notificationMessages)
          ..where((table) => table.messageId.equals(messageId) & _isNotExpired))
        .getSingleOrNull();
  }

  Stream<NotificationMessage?> watchMessage(String messageId) {
    return (select(notificationMessages)
          ..where((table) => table.messageId.equals(messageId) & _isNotExpired))
        .watchSingleOrNull();
  }

  Stream<List<NotificationMessage>> watchMessages() {
    return (select(
      notificationMessages,
    )..where((table) => _isNotExpired)).watch();
  }

  Stream<List<NotificationMessage>> watchUnreadMessages() {
    return (select(
      notificationMessages,
    )..where((table) => table.isOpened.equals(false) & _isNotExpired)).watch();
  }

  Stream<int> watchUnreadCount() {
    final query = selectOnly(notificationMessages)
      ..addColumns([notificationMessages.id.count()])
      ..where(notificationMessages.isOpened.equals(false) & _isNotExpired);

    return query.watchSingle().map(
      (row) => row.read(notificationMessages.id.count()) ?? 0,
    );
  }
}
