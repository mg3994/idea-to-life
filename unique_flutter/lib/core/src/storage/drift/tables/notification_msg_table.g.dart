// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_msg_table.dart';

// ignore_for_file: type=lint
mixin _$NotificationMsgDaoMixin on DatabaseAccessor<AppDatabase> {
  $NotificationMessagesTable get notificationMessages =>
      attachedDatabase.notificationMessages;
  NotificationMsgDaoManager get managers => NotificationMsgDaoManager(this);
}

class NotificationMsgDaoManager {
  final _$NotificationMsgDaoMixin _db;
  NotificationMsgDaoManager(this._db);
  $$NotificationMessagesTableTableManager get notificationMessages =>
      $$NotificationMessagesTableTableManager(
        _db.attachedDatabase,
        _db.notificationMessages,
      );
}
