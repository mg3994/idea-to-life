// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $NotificationMessagesTable extends NotificationMessages
    with TableInfo<$NotificationMessagesTable, NotificationMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _senderIdMeta = const VerificationMeta(
    'senderId',
  );
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
    'sender_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fromMeta = const VerificationMeta('from');
  @override
  late final GeneratedColumn<String> from = GeneratedColumn<String>(
    'from',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _messageTypeMeta = const VerificationMeta(
    'messageType',
  );
  @override
  late final GeneratedColumn<String> messageType = GeneratedColumn<String>(
    'message_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _collapseKeyMeta = const VerificationMeta(
    'collapseKey',
  );
  @override
  late final GeneratedColumn<String> collapseKey = GeneratedColumn<String>(
    'collapse_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actionIdentifierMeta = const VerificationMeta(
    'actionIdentifier',
  );
  @override
  late final GeneratedColumn<String> actionIdentifier = GeneratedColumn<String>(
    'action_identifier',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentAvailableMeta = const VerificationMeta(
    'contentAvailable',
  );
  @override
  late final GeneratedColumn<bool> contentAvailable = GeneratedColumn<bool>(
    'content_available',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("content_available" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _mutableContentMeta = const VerificationMeta(
    'mutableContent',
  );
  @override
  late final GeneratedColumn<bool> mutableContent = GeneratedColumn<bool>(
    'mutable_content',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("mutable_content" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _ttlMeta = const VerificationMeta('ttl');
  @override
  late final GeneratedColumn<int> ttl = GeneratedColumn<int>(
    'ttl',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sentTimeMeta = const VerificationMeta(
    'sentTime',
  );
  @override
  late final GeneratedColumn<DateTime> sentTime = GeneratedColumn<DateTime>(
    'sent_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
    'link',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
    'data',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isOpenedMeta = const VerificationMeta(
    'isOpened',
  );
  @override
  late final GeneratedColumn<bool> isOpened = GeneratedColumn<bool>(
    'is_opened',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_opened" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _receivedAtMeta = const VerificationMeta(
    'receivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
    'received_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    messageId,
    senderId,
    from,
    messageType,
    collapseKey,
    category,
    actionIdentifier,
    contentAvailable,
    mutableContent,
    ttl,
    sentTime,
    title,
    body,
    imageUrl,
    link,
    data,
    isOpened,
    receivedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    }
    if (data.containsKey('sender_id')) {
      context.handle(
        _senderIdMeta,
        senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta),
      );
    }
    if (data.containsKey('from')) {
      context.handle(
        _fromMeta,
        from.isAcceptableOrUnknown(data['from']!, _fromMeta),
      );
    }
    if (data.containsKey('message_type')) {
      context.handle(
        _messageTypeMeta,
        messageType.isAcceptableOrUnknown(
          data['message_type']!,
          _messageTypeMeta,
        ),
      );
    }
    if (data.containsKey('collapse_key')) {
      context.handle(
        _collapseKeyMeta,
        collapseKey.isAcceptableOrUnknown(
          data['collapse_key']!,
          _collapseKeyMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('action_identifier')) {
      context.handle(
        _actionIdentifierMeta,
        actionIdentifier.isAcceptableOrUnknown(
          data['action_identifier']!,
          _actionIdentifierMeta,
        ),
      );
    }
    if (data.containsKey('content_available')) {
      context.handle(
        _contentAvailableMeta,
        contentAvailable.isAcceptableOrUnknown(
          data['content_available']!,
          _contentAvailableMeta,
        ),
      );
    }
    if (data.containsKey('mutable_content')) {
      context.handle(
        _mutableContentMeta,
        mutableContent.isAcceptableOrUnknown(
          data['mutable_content']!,
          _mutableContentMeta,
        ),
      );
    }
    if (data.containsKey('ttl')) {
      context.handle(
        _ttlMeta,
        ttl.isAcceptableOrUnknown(data['ttl']!, _ttlMeta),
      );
    }
    if (data.containsKey('sent_time')) {
      context.handle(
        _sentTimeMeta,
        sentTime.isAcceptableOrUnknown(data['sent_time']!, _sentTimeMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('link')) {
      context.handle(
        _linkMeta,
        link.isAcceptableOrUnknown(data['link']!, _linkMeta),
      );
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    }
    if (data.containsKey('is_opened')) {
      context.handle(
        _isOpenedMeta,
        isOpened.isAcceptableOrUnknown(data['is_opened']!, _isOpenedMeta),
      );
    }
    if (data.containsKey('received_at')) {
      context.handle(
        _receivedAtMeta,
        receivedAt.isAcceptableOrUnknown(data['received_at']!, _receivedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_receivedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationMessage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      ),
      senderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_id'],
      ),
      from: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from'],
      ),
      messageType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_type'],
      ),
      collapseKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collapse_key'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      actionIdentifier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action_identifier'],
      ),
      contentAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}content_available'],
      )!,
      mutableContent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}mutable_content'],
      )!,
      ttl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ttl'],
      ),
      sentTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_time'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      link: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}link'],
      ),
      data: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data'],
      ),
      isOpened: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_opened'],
      )!,
      receivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_at'],
      )!,
    );
  }

  @override
  $NotificationMessagesTable createAlias(String alias) {
    return $NotificationMessagesTable(attachedDatabase, alias);
  }
}

class NotificationMessage extends DataClass
    implements Insertable<NotificationMessage> {
  final int id;

  /// FCM message ID.
  final String? messageId;

  /// FCM sender ID.
  final String? senderId;

  /// FCM `from` field.
  final String? from;

  /// Message type supplied by FCM.
  final String? messageType;

  /// Collapse key supplied by FCM.
  final String? collapseKey;

  /// iOS category.
  final String? category;

  /// iOS action identifier.
  final String? actionIdentifier;

  /// Whether this was a content-available/background message.
  final bool contentAvailable;

  /// Whether APNs mutable-content was enabled.
  final bool mutableContent;

  /// FCM message TTL in seconds.
  final int? ttl;

  /// Time at which FCM reports that the message was sent.
  final DateTime? sentTime;

  /// Notification title.
  final String? title;

  /// Notification body.
  final String? body;

  /// Android/iOS/Web image URL.
  final String? imageUrl;

  /// Notification link.
  final String? link;

  /// Custom FCM data payload encoded as JSON.
  final String? data;

  /// Whether the notification has been opened by the user.
  final bool isOpened;

  /// Time at which this application stored the message.
  final DateTime receivedAt;
  const NotificationMessage({
    required this.id,
    this.messageId,
    this.senderId,
    this.from,
    this.messageType,
    this.collapseKey,
    this.category,
    this.actionIdentifier,
    required this.contentAvailable,
    required this.mutableContent,
    this.ttl,
    this.sentTime,
    this.title,
    this.body,
    this.imageUrl,
    this.link,
    this.data,
    required this.isOpened,
    required this.receivedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || messageId != null) {
      map['message_id'] = Variable<String>(messageId);
    }
    if (!nullToAbsent || senderId != null) {
      map['sender_id'] = Variable<String>(senderId);
    }
    if (!nullToAbsent || from != null) {
      map['from'] = Variable<String>(from);
    }
    if (!nullToAbsent || messageType != null) {
      map['message_type'] = Variable<String>(messageType);
    }
    if (!nullToAbsent || collapseKey != null) {
      map['collapse_key'] = Variable<String>(collapseKey);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || actionIdentifier != null) {
      map['action_identifier'] = Variable<String>(actionIdentifier);
    }
    map['content_available'] = Variable<bool>(contentAvailable);
    map['mutable_content'] = Variable<bool>(mutableContent);
    if (!nullToAbsent || ttl != null) {
      map['ttl'] = Variable<int>(ttl);
    }
    if (!nullToAbsent || sentTime != null) {
      map['sent_time'] = Variable<DateTime>(sentTime);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || body != null) {
      map['body'] = Variable<String>(body);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    if (!nullToAbsent || data != null) {
      map['data'] = Variable<String>(data);
    }
    map['is_opened'] = Variable<bool>(isOpened);
    map['received_at'] = Variable<DateTime>(receivedAt);
    return map;
  }

  NotificationMessagesCompanion toCompanion(bool nullToAbsent) {
    return NotificationMessagesCompanion(
      id: Value(id),
      messageId: messageId == null && nullToAbsent
          ? const Value.absent()
          : Value(messageId),
      senderId: senderId == null && nullToAbsent
          ? const Value.absent()
          : Value(senderId),
      from: from == null && nullToAbsent ? const Value.absent() : Value(from),
      messageType: messageType == null && nullToAbsent
          ? const Value.absent()
          : Value(messageType),
      collapseKey: collapseKey == null && nullToAbsent
          ? const Value.absent()
          : Value(collapseKey),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      actionIdentifier: actionIdentifier == null && nullToAbsent
          ? const Value.absent()
          : Value(actionIdentifier),
      contentAvailable: Value(contentAvailable),
      mutableContent: Value(mutableContent),
      ttl: ttl == null && nullToAbsent ? const Value.absent() : Value(ttl),
      sentTime: sentTime == null && nullToAbsent
          ? const Value.absent()
          : Value(sentTime),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
      data: data == null && nullToAbsent ? const Value.absent() : Value(data),
      isOpened: Value(isOpened),
      receivedAt: Value(receivedAt),
    );
  }

  factory NotificationMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationMessage(
      id: serializer.fromJson<int>(json['id']),
      messageId: serializer.fromJson<String?>(json['messageId']),
      senderId: serializer.fromJson<String?>(json['senderId']),
      from: serializer.fromJson<String?>(json['from']),
      messageType: serializer.fromJson<String?>(json['messageType']),
      collapseKey: serializer.fromJson<String?>(json['collapseKey']),
      category: serializer.fromJson<String?>(json['category']),
      actionIdentifier: serializer.fromJson<String?>(json['actionIdentifier']),
      contentAvailable: serializer.fromJson<bool>(json['contentAvailable']),
      mutableContent: serializer.fromJson<bool>(json['mutableContent']),
      ttl: serializer.fromJson<int?>(json['ttl']),
      sentTime: serializer.fromJson<DateTime?>(json['sentTime']),
      title: serializer.fromJson<String?>(json['title']),
      body: serializer.fromJson<String?>(json['body']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      link: serializer.fromJson<String?>(json['link']),
      data: serializer.fromJson<String?>(json['data']),
      isOpened: serializer.fromJson<bool>(json['isOpened']),
      receivedAt: serializer.fromJson<DateTime>(json['receivedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'messageId': serializer.toJson<String?>(messageId),
      'senderId': serializer.toJson<String?>(senderId),
      'from': serializer.toJson<String?>(from),
      'messageType': serializer.toJson<String?>(messageType),
      'collapseKey': serializer.toJson<String?>(collapseKey),
      'category': serializer.toJson<String?>(category),
      'actionIdentifier': serializer.toJson<String?>(actionIdentifier),
      'contentAvailable': serializer.toJson<bool>(contentAvailable),
      'mutableContent': serializer.toJson<bool>(mutableContent),
      'ttl': serializer.toJson<int?>(ttl),
      'sentTime': serializer.toJson<DateTime?>(sentTime),
      'title': serializer.toJson<String?>(title),
      'body': serializer.toJson<String?>(body),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'link': serializer.toJson<String?>(link),
      'data': serializer.toJson<String?>(data),
      'isOpened': serializer.toJson<bool>(isOpened),
      'receivedAt': serializer.toJson<DateTime>(receivedAt),
    };
  }

  NotificationMessage copyWith({
    int? id,
    Value<String?> messageId = const Value.absent(),
    Value<String?> senderId = const Value.absent(),
    Value<String?> from = const Value.absent(),
    Value<String?> messageType = const Value.absent(),
    Value<String?> collapseKey = const Value.absent(),
    Value<String?> category = const Value.absent(),
    Value<String?> actionIdentifier = const Value.absent(),
    bool? contentAvailable,
    bool? mutableContent,
    Value<int?> ttl = const Value.absent(),
    Value<DateTime?> sentTime = const Value.absent(),
    Value<String?> title = const Value.absent(),
    Value<String?> body = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> link = const Value.absent(),
    Value<String?> data = const Value.absent(),
    bool? isOpened,
    DateTime? receivedAt,
  }) => NotificationMessage(
    id: id ?? this.id,
    messageId: messageId.present ? messageId.value : this.messageId,
    senderId: senderId.present ? senderId.value : this.senderId,
    from: from.present ? from.value : this.from,
    messageType: messageType.present ? messageType.value : this.messageType,
    collapseKey: collapseKey.present ? collapseKey.value : this.collapseKey,
    category: category.present ? category.value : this.category,
    actionIdentifier: actionIdentifier.present
        ? actionIdentifier.value
        : this.actionIdentifier,
    contentAvailable: contentAvailable ?? this.contentAvailable,
    mutableContent: mutableContent ?? this.mutableContent,
    ttl: ttl.present ? ttl.value : this.ttl,
    sentTime: sentTime.present ? sentTime.value : this.sentTime,
    title: title.present ? title.value : this.title,
    body: body.present ? body.value : this.body,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    link: link.present ? link.value : this.link,
    data: data.present ? data.value : this.data,
    isOpened: isOpened ?? this.isOpened,
    receivedAt: receivedAt ?? this.receivedAt,
  );
  NotificationMessage copyWithCompanion(NotificationMessagesCompanion data) {
    return NotificationMessage(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      from: data.from.present ? data.from.value : this.from,
      messageType: data.messageType.present
          ? data.messageType.value
          : this.messageType,
      collapseKey: data.collapseKey.present
          ? data.collapseKey.value
          : this.collapseKey,
      category: data.category.present ? data.category.value : this.category,
      actionIdentifier: data.actionIdentifier.present
          ? data.actionIdentifier.value
          : this.actionIdentifier,
      contentAvailable: data.contentAvailable.present
          ? data.contentAvailable.value
          : this.contentAvailable,
      mutableContent: data.mutableContent.present
          ? data.mutableContent.value
          : this.mutableContent,
      ttl: data.ttl.present ? data.ttl.value : this.ttl,
      sentTime: data.sentTime.present ? data.sentTime.value : this.sentTime,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      link: data.link.present ? data.link.value : this.link,
      data: data.data.present ? data.data.value : this.data,
      isOpened: data.isOpened.present ? data.isOpened.value : this.isOpened,
      receivedAt: data.receivedAt.present
          ? data.receivedAt.value
          : this.receivedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationMessage(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('senderId: $senderId, ')
          ..write('from: $from, ')
          ..write('messageType: $messageType, ')
          ..write('collapseKey: $collapseKey, ')
          ..write('category: $category, ')
          ..write('actionIdentifier: $actionIdentifier, ')
          ..write('contentAvailable: $contentAvailable, ')
          ..write('mutableContent: $mutableContent, ')
          ..write('ttl: $ttl, ')
          ..write('sentTime: $sentTime, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('link: $link, ')
          ..write('data: $data, ')
          ..write('isOpened: $isOpened, ')
          ..write('receivedAt: $receivedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    messageId,
    senderId,
    from,
    messageType,
    collapseKey,
    category,
    actionIdentifier,
    contentAvailable,
    mutableContent,
    ttl,
    sentTime,
    title,
    body,
    imageUrl,
    link,
    data,
    isOpened,
    receivedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationMessage &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.senderId == this.senderId &&
          other.from == this.from &&
          other.messageType == this.messageType &&
          other.collapseKey == this.collapseKey &&
          other.category == this.category &&
          other.actionIdentifier == this.actionIdentifier &&
          other.contentAvailable == this.contentAvailable &&
          other.mutableContent == this.mutableContent &&
          other.ttl == this.ttl &&
          other.sentTime == this.sentTime &&
          other.title == this.title &&
          other.body == this.body &&
          other.imageUrl == this.imageUrl &&
          other.link == this.link &&
          other.data == this.data &&
          other.isOpened == this.isOpened &&
          other.receivedAt == this.receivedAt);
}

class NotificationMessagesCompanion
    extends UpdateCompanion<NotificationMessage> {
  final Value<int> id;
  final Value<String?> messageId;
  final Value<String?> senderId;
  final Value<String?> from;
  final Value<String?> messageType;
  final Value<String?> collapseKey;
  final Value<String?> category;
  final Value<String?> actionIdentifier;
  final Value<bool> contentAvailable;
  final Value<bool> mutableContent;
  final Value<int?> ttl;
  final Value<DateTime?> sentTime;
  final Value<String?> title;
  final Value<String?> body;
  final Value<String?> imageUrl;
  final Value<String?> link;
  final Value<String?> data;
  final Value<bool> isOpened;
  final Value<DateTime> receivedAt;
  const NotificationMessagesCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.senderId = const Value.absent(),
    this.from = const Value.absent(),
    this.messageType = const Value.absent(),
    this.collapseKey = const Value.absent(),
    this.category = const Value.absent(),
    this.actionIdentifier = const Value.absent(),
    this.contentAvailable = const Value.absent(),
    this.mutableContent = const Value.absent(),
    this.ttl = const Value.absent(),
    this.sentTime = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.link = const Value.absent(),
    this.data = const Value.absent(),
    this.isOpened = const Value.absent(),
    this.receivedAt = const Value.absent(),
  });
  NotificationMessagesCompanion.insert({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.senderId = const Value.absent(),
    this.from = const Value.absent(),
    this.messageType = const Value.absent(),
    this.collapseKey = const Value.absent(),
    this.category = const Value.absent(),
    this.actionIdentifier = const Value.absent(),
    this.contentAvailable = const Value.absent(),
    this.mutableContent = const Value.absent(),
    this.ttl = const Value.absent(),
    this.sentTime = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.link = const Value.absent(),
    this.data = const Value.absent(),
    this.isOpened = const Value.absent(),
    required DateTime receivedAt,
  }) : receivedAt = Value(receivedAt);
  static Insertable<NotificationMessage> custom({
    Expression<int>? id,
    Expression<String>? messageId,
    Expression<String>? senderId,
    Expression<String>? from,
    Expression<String>? messageType,
    Expression<String>? collapseKey,
    Expression<String>? category,
    Expression<String>? actionIdentifier,
    Expression<bool>? contentAvailable,
    Expression<bool>? mutableContent,
    Expression<int>? ttl,
    Expression<DateTime>? sentTime,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? imageUrl,
    Expression<String>? link,
    Expression<String>? data,
    Expression<bool>? isOpened,
    Expression<DateTime>? receivedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (senderId != null) 'sender_id': senderId,
      if (from != null) 'from': from,
      if (messageType != null) 'message_type': messageType,
      if (collapseKey != null) 'collapse_key': collapseKey,
      if (category != null) 'category': category,
      if (actionIdentifier != null) 'action_identifier': actionIdentifier,
      if (contentAvailable != null) 'content_available': contentAvailable,
      if (mutableContent != null) 'mutable_content': mutableContent,
      if (ttl != null) 'ttl': ttl,
      if (sentTime != null) 'sent_time': sentTime,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (imageUrl != null) 'image_url': imageUrl,
      if (link != null) 'link': link,
      if (data != null) 'data': data,
      if (isOpened != null) 'is_opened': isOpened,
      if (receivedAt != null) 'received_at': receivedAt,
    });
  }

  NotificationMessagesCompanion copyWith({
    Value<int>? id,
    Value<String?>? messageId,
    Value<String?>? senderId,
    Value<String?>? from,
    Value<String?>? messageType,
    Value<String?>? collapseKey,
    Value<String?>? category,
    Value<String?>? actionIdentifier,
    Value<bool>? contentAvailable,
    Value<bool>? mutableContent,
    Value<int?>? ttl,
    Value<DateTime?>? sentTime,
    Value<String?>? title,
    Value<String?>? body,
    Value<String?>? imageUrl,
    Value<String?>? link,
    Value<String?>? data,
    Value<bool>? isOpened,
    Value<DateTime>? receivedAt,
  }) {
    return NotificationMessagesCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      senderId: senderId ?? this.senderId,
      from: from ?? this.from,
      messageType: messageType ?? this.messageType,
      collapseKey: collapseKey ?? this.collapseKey,
      category: category ?? this.category,
      actionIdentifier: actionIdentifier ?? this.actionIdentifier,
      contentAvailable: contentAvailable ?? this.contentAvailable,
      mutableContent: mutableContent ?? this.mutableContent,
      ttl: ttl ?? this.ttl,
      sentTime: sentTime ?? this.sentTime,
      title: title ?? this.title,
      body: body ?? this.body,
      imageUrl: imageUrl ?? this.imageUrl,
      link: link ?? this.link,
      data: data ?? this.data,
      isOpened: isOpened ?? this.isOpened,
      receivedAt: receivedAt ?? this.receivedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (from.present) {
      map['from'] = Variable<String>(from.value);
    }
    if (messageType.present) {
      map['message_type'] = Variable<String>(messageType.value);
    }
    if (collapseKey.present) {
      map['collapse_key'] = Variable<String>(collapseKey.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (actionIdentifier.present) {
      map['action_identifier'] = Variable<String>(actionIdentifier.value);
    }
    if (contentAvailable.present) {
      map['content_available'] = Variable<bool>(contentAvailable.value);
    }
    if (mutableContent.present) {
      map['mutable_content'] = Variable<bool>(mutableContent.value);
    }
    if (ttl.present) {
      map['ttl'] = Variable<int>(ttl.value);
    }
    if (sentTime.present) {
      map['sent_time'] = Variable<DateTime>(sentTime.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (isOpened.present) {
      map['is_opened'] = Variable<bool>(isOpened.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationMessagesCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('senderId: $senderId, ')
          ..write('from: $from, ')
          ..write('messageType: $messageType, ')
          ..write('collapseKey: $collapseKey, ')
          ..write('category: $category, ')
          ..write('actionIdentifier: $actionIdentifier, ')
          ..write('contentAvailable: $contentAvailable, ')
          ..write('mutableContent: $mutableContent, ')
          ..write('ttl: $ttl, ')
          ..write('sentTime: $sentTime, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('link: $link, ')
          ..write('data: $data, ')
          ..write('isOpened: $isOpened, ')
          ..write('receivedAt: $receivedAt')
          ..write(')'))
        .toString();
  }
}

class $TasksTableTable extends TasksTable
    with TableInfo<$TasksTableTable, TasksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _serializedTagsMeta = const VerificationMeta(
    'serializedTags',
  );
  @override
  late final GeneratedColumn<String> serializedTags = GeneratedColumn<String>(
    'serialized_tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    isCompleted,
    serializedTags,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TasksTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('serialized_tags')) {
      context.handle(
        _serializedTagsMeta,
        serializedTags.isAcceptableOrUnknown(
          data['serialized_tags']!,
          _serializedTagsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serializedTagsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TasksTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TasksTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      serializedTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serialized_tags'],
      )!,
    );
  }

  @override
  $TasksTableTable createAlias(String alias) {
    return $TasksTableTable(attachedDatabase, alias);
  }
}

class TasksTableData extends DataClass implements Insertable<TasksTableData> {
  final String id;
  final String title;
  final bool isCompleted;
  final String serializedTags;
  const TasksTableData({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.serializedTags,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['serialized_tags'] = Variable<String>(serializedTags);
    return map;
  }

  TasksTableCompanion toCompanion(bool nullToAbsent) {
    return TasksTableCompanion(
      id: Value(id),
      title: Value(title),
      isCompleted: Value(isCompleted),
      serializedTags: Value(serializedTags),
    );
  }

  factory TasksTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TasksTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      serializedTags: serializer.fromJson<String>(json['serializedTags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'serializedTags': serializer.toJson<String>(serializedTags),
    };
  }

  TasksTableData copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    String? serializedTags,
  }) => TasksTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    isCompleted: isCompleted ?? this.isCompleted,
    serializedTags: serializedTags ?? this.serializedTags,
  );
  TasksTableData copyWithCompanion(TasksTableCompanion data) {
    return TasksTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      serializedTags: data.serializedTags.present
          ? data.serializedTags.value
          : this.serializedTags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TasksTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('serializedTags: $serializedTags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, isCompleted, serializedTags);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TasksTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.isCompleted == this.isCompleted &&
          other.serializedTags == this.serializedTags);
}

class TasksTableCompanion extends UpdateCompanion<TasksTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<bool> isCompleted;
  final Value<String> serializedTags;
  final Value<int> rowid;
  const TasksTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.serializedTags = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksTableCompanion.insert({
    required String id,
    required String title,
    this.isCompleted = const Value.absent(),
    required String serializedTags,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       serializedTags = Value(serializedTags);
  static Insertable<TasksTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<bool>? isCompleted,
    Expression<String>? serializedTags,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (serializedTags != null) 'serialized_tags': serializedTags,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<bool>? isCompleted,
    Value<String>? serializedTags,
    Value<int>? rowid,
  }) {
    return TasksTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      serializedTags: serializedTags ?? this.serializedTags,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (serializedTags.present) {
      map['serialized_tags'] = Variable<String>(serializedTags.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('serializedTags: $serializedTags, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppearanceSettingsTable extends AppearanceSettings
    with TableInfo<$AppearanceSettingsTable, AppearanceSettingsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppearanceSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ThemeMode, String> themeMode =
      GeneratedColumn<String>(
        'theme_mode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ThemeMode>($AppearanceSettingsTable.$converterthemeMode);
  @override
  late final GeneratedColumnWithTypeConverter<Locale, String> locale =
      GeneratedColumn<String>(
        'locale',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Locale>($AppearanceSettingsTable.$converterlocale);
  @override
  late final GeneratedColumnWithTypeConverter<Color, int> seedColor =
      GeneratedColumn<int>(
        'seed_color',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Color>($AppearanceSettingsTable.$converterseedColor);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    themeMode,
    locale,
    seedColor,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appearance_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppearanceSettingsData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppearanceSettingsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppearanceSettingsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      themeMode: $AppearanceSettingsTable.$converterthemeMode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}theme_mode'],
        )!,
      ),
      locale: $AppearanceSettingsTable.$converterlocale.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}locale'],
        )!,
      ),
      seedColor: $AppearanceSettingsTable.$converterseedColor.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}seed_color'],
        )!,
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppearanceSettingsTable createAlias(String alias) {
    return $AppearanceSettingsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ThemeMode, String, String> $converterthemeMode =
      const EnumNameConverter<ThemeMode>(ThemeMode.values);
  static TypeConverter<Locale, String> $converterlocale =
      const LocaleConverter();
  static TypeConverter<Color, int> $converterseedColor = const ColorConverter();
}

class AppearanceSettingsData extends DataClass
    implements Insertable<AppearanceSettingsData> {
  /// Primary key identifying the settings profile.
  final int id;

  /// User's theme mode preference.
  final ThemeMode themeMode;

  /// Selected application locale.
  final Locale locale;

  /// Primary seed color used for dynamic Material 3 color scheming.
  final Color seedColor;

  /// Timestamp when the settings were last updated.
  final DateTime updatedAt;
  const AppearanceSettingsData({
    required this.id,
    required this.themeMode,
    required this.locale,
    required this.seedColor,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['theme_mode'] = Variable<String>(
        $AppearanceSettingsTable.$converterthemeMode.toSql(themeMode),
      );
    }
    {
      map['locale'] = Variable<String>(
        $AppearanceSettingsTable.$converterlocale.toSql(locale),
      );
    }
    {
      map['seed_color'] = Variable<int>(
        $AppearanceSettingsTable.$converterseedColor.toSql(seedColor),
      );
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppearanceSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppearanceSettingsCompanion(
      id: Value(id),
      themeMode: Value(themeMode),
      locale: Value(locale),
      seedColor: Value(seedColor),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppearanceSettingsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppearanceSettingsData(
      id: serializer.fromJson<int>(json['id']),
      themeMode: $AppearanceSettingsTable.$converterthemeMode.fromJson(
        serializer.fromJson<String>(json['themeMode']),
      ),
      locale: serializer.fromJson<Locale>(json['locale']),
      seedColor: serializer.fromJson<Color>(json['seedColor']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'themeMode': serializer.toJson<String>(
        $AppearanceSettingsTable.$converterthemeMode.toJson(themeMode),
      ),
      'locale': serializer.toJson<Locale>(locale),
      'seedColor': serializer.toJson<Color>(seedColor),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppearanceSettingsData copyWith({
    int? id,
    ThemeMode? themeMode,
    Locale? locale,
    Color? seedColor,
    DateTime? updatedAt,
  }) => AppearanceSettingsData(
    id: id ?? this.id,
    themeMode: themeMode ?? this.themeMode,
    locale: locale ?? this.locale,
    seedColor: seedColor ?? this.seedColor,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppearanceSettingsData copyWithCompanion(AppearanceSettingsCompanion data) {
    return AppearanceSettingsData(
      id: data.id.present ? data.id.value : this.id,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      locale: data.locale.present ? data.locale.value : this.locale,
      seedColor: data.seedColor.present ? data.seedColor.value : this.seedColor,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppearanceSettingsData(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('locale: $locale, ')
          ..write('seedColor: $seedColor, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, themeMode, locale, seedColor, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppearanceSettingsData &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.locale == this.locale &&
          other.seedColor == this.seedColor &&
          other.updatedAt == this.updatedAt);
}

class AppearanceSettingsCompanion
    extends UpdateCompanion<AppearanceSettingsData> {
  final Value<int> id;
  final Value<ThemeMode> themeMode;
  final Value<Locale> locale;
  final Value<Color> seedColor;
  final Value<DateTime> updatedAt;
  const AppearanceSettingsCompanion({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.locale = const Value.absent(),
    this.seedColor = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AppearanceSettingsCompanion.insert({
    this.id = const Value.absent(),
    required ThemeMode themeMode,
    required Locale locale,
    required Color seedColor,
    required DateTime updatedAt,
  }) : themeMode = Value(themeMode),
       locale = Value(locale),
       seedColor = Value(seedColor),
       updatedAt = Value(updatedAt);
  static Insertable<AppearanceSettingsData> custom({
    Expression<int>? id,
    Expression<String>? themeMode,
    Expression<String>? locale,
    Expression<int>? seedColor,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (locale != null) 'locale': locale,
      if (seedColor != null) 'seed_color': seedColor,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AppearanceSettingsCompanion copyWith({
    Value<int>? id,
    Value<ThemeMode>? themeMode,
    Value<Locale>? locale,
    Value<Color>? seedColor,
    Value<DateTime>? updatedAt,
  }) {
    return AppearanceSettingsCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      seedColor: seedColor ?? this.seedColor,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(
        $AppearanceSettingsTable.$converterthemeMode.toSql(themeMode.value),
      );
    }
    if (locale.present) {
      map['locale'] = Variable<String>(
        $AppearanceSettingsTable.$converterlocale.toSql(locale.value),
      );
    }
    if (seedColor.present) {
      map['seed_color'] = Variable<int>(
        $AppearanceSettingsTable.$converterseedColor.toSql(seedColor.value),
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppearanceSettingsCompanion(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('locale: $locale, ')
          ..write('seedColor: $seedColor, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NotificationMessagesTable notificationMessages =
      $NotificationMessagesTable(this);
  late final $TasksTableTable tasksTable = $TasksTableTable(this);
  late final $AppearanceSettingsTable appearanceSettings =
      $AppearanceSettingsTable(this);
  late final NotificationMsgDao notificationMsgDao = NotificationMsgDao(
    this as AppDatabase,
  );
  late final AppearanceSettingsDao appearanceSettingsDao =
      AppearanceSettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    notificationMessages,
    tasksTable,
    appearanceSettings,
  ];
}

typedef $$NotificationMessagesTableCreateCompanionBuilder =
    NotificationMessagesCompanion Function({
      Value<int> id,
      Value<String?> messageId,
      Value<String?> senderId,
      Value<String?> from,
      Value<String?> messageType,
      Value<String?> collapseKey,
      Value<String?> category,
      Value<String?> actionIdentifier,
      Value<bool> contentAvailable,
      Value<bool> mutableContent,
      Value<int?> ttl,
      Value<DateTime?> sentTime,
      Value<String?> title,
      Value<String?> body,
      Value<String?> imageUrl,
      Value<String?> link,
      Value<String?> data,
      Value<bool> isOpened,
      required DateTime receivedAt,
    });
typedef $$NotificationMessagesTableUpdateCompanionBuilder =
    NotificationMessagesCompanion Function({
      Value<int> id,
      Value<String?> messageId,
      Value<String?> senderId,
      Value<String?> from,
      Value<String?> messageType,
      Value<String?> collapseKey,
      Value<String?> category,
      Value<String?> actionIdentifier,
      Value<bool> contentAvailable,
      Value<bool> mutableContent,
      Value<int?> ttl,
      Value<DateTime?> sentTime,
      Value<String?> title,
      Value<String?> body,
      Value<String?> imageUrl,
      Value<String?> link,
      Value<String?> data,
      Value<bool> isOpened,
      Value<DateTime> receivedAt,
    });

class $$NotificationMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationMessagesTable> {
  $$NotificationMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get from => $composableBuilder(
    column: $table.from,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get collapseKey => $composableBuilder(
    column: $table.collapseKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actionIdentifier => $composableBuilder(
    column: $table.actionIdentifier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get contentAvailable => $composableBuilder(
    column: $table.contentAvailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get mutableContent => $composableBuilder(
    column: $table.mutableContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ttl => $composableBuilder(
    column: $table.ttl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentTime => $composableBuilder(
    column: $table.sentTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOpened => $composableBuilder(
    column: $table.isOpened,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationMessagesTable> {
  $$NotificationMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get from => $composableBuilder(
    column: $table.from,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get collapseKey => $composableBuilder(
    column: $table.collapseKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actionIdentifier => $composableBuilder(
    column: $table.actionIdentifier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get contentAvailable => $composableBuilder(
    column: $table.contentAvailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get mutableContent => $composableBuilder(
    column: $table.mutableContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ttl => $composableBuilder(
    column: $table.ttl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentTime => $composableBuilder(
    column: $table.sentTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOpened => $composableBuilder(
    column: $table.isOpened,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationMessagesTable> {
  $$NotificationMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<String> get senderId =>
      $composableBuilder(column: $table.senderId, builder: (column) => column);

  GeneratedColumn<String> get from =>
      $composableBuilder(column: $table.from, builder: (column) => column);

  GeneratedColumn<String> get messageType => $composableBuilder(
    column: $table.messageType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get collapseKey => $composableBuilder(
    column: $table.collapseKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get actionIdentifier => $composableBuilder(
    column: $table.actionIdentifier,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get contentAvailable => $composableBuilder(
    column: $table.contentAvailable,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get mutableContent => $composableBuilder(
    column: $table.mutableContent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ttl =>
      $composableBuilder(column: $table.ttl, builder: (column) => column);

  GeneratedColumn<DateTime> get sentTime =>
      $composableBuilder(column: $table.sentTime, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<bool> get isOpened =>
      $composableBuilder(column: $table.isOpened, builder: (column) => column);

  GeneratedColumn<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => column,
  );
}

class $$NotificationMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationMessagesTable,
          NotificationMessage,
          $$NotificationMessagesTableFilterComposer,
          $$NotificationMessagesTableOrderingComposer,
          $$NotificationMessagesTableAnnotationComposer,
          $$NotificationMessagesTableCreateCompanionBuilder,
          $$NotificationMessagesTableUpdateCompanionBuilder,
          (
            NotificationMessage,
            BaseReferences<
              _$AppDatabase,
              $NotificationMessagesTable,
              NotificationMessage
            >,
          ),
          NotificationMessage,
          PrefetchHooks Function()
        > {
  $$NotificationMessagesTableTableManager(
    _$AppDatabase db,
    $NotificationMessagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationMessagesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NotificationMessagesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> messageId = const Value.absent(),
                Value<String?> senderId = const Value.absent(),
                Value<String?> from = const Value.absent(),
                Value<String?> messageType = const Value.absent(),
                Value<String?> collapseKey = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> actionIdentifier = const Value.absent(),
                Value<bool> contentAvailable = const Value.absent(),
                Value<bool> mutableContent = const Value.absent(),
                Value<int?> ttl = const Value.absent(),
                Value<DateTime?> sentTime = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> body = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> link = const Value.absent(),
                Value<String?> data = const Value.absent(),
                Value<bool> isOpened = const Value.absent(),
                Value<DateTime> receivedAt = const Value.absent(),
              }) => NotificationMessagesCompanion(
                id: id,
                messageId: messageId,
                senderId: senderId,
                from: from,
                messageType: messageType,
                collapseKey: collapseKey,
                category: category,
                actionIdentifier: actionIdentifier,
                contentAvailable: contentAvailable,
                mutableContent: mutableContent,
                ttl: ttl,
                sentTime: sentTime,
                title: title,
                body: body,
                imageUrl: imageUrl,
                link: link,
                data: data,
                isOpened: isOpened,
                receivedAt: receivedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> messageId = const Value.absent(),
                Value<String?> senderId = const Value.absent(),
                Value<String?> from = const Value.absent(),
                Value<String?> messageType = const Value.absent(),
                Value<String?> collapseKey = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> actionIdentifier = const Value.absent(),
                Value<bool> contentAvailable = const Value.absent(),
                Value<bool> mutableContent = const Value.absent(),
                Value<int?> ttl = const Value.absent(),
                Value<DateTime?> sentTime = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> body = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> link = const Value.absent(),
                Value<String?> data = const Value.absent(),
                Value<bool> isOpened = const Value.absent(),
                required DateTime receivedAt,
              }) => NotificationMessagesCompanion.insert(
                id: id,
                messageId: messageId,
                senderId: senderId,
                from: from,
                messageType: messageType,
                collapseKey: collapseKey,
                category: category,
                actionIdentifier: actionIdentifier,
                contentAvailable: contentAvailable,
                mutableContent: mutableContent,
                ttl: ttl,
                sentTime: sentTime,
                title: title,
                body: body,
                imageUrl: imageUrl,
                link: link,
                data: data,
                isOpened: isOpened,
                receivedAt: receivedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NotificationMessagesTable, NotificationMessage>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $NotificationMessagesTable,
                    NotificationMessage
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationMessagesTable,
      NotificationMessage,
      $$NotificationMessagesTableFilterComposer,
      $$NotificationMessagesTableOrderingComposer,
      $$NotificationMessagesTableAnnotationComposer,
      $$NotificationMessagesTableCreateCompanionBuilder,
      $$NotificationMessagesTableUpdateCompanionBuilder,
      (
        NotificationMessage,
        BaseReferences<
          _$AppDatabase,
          $NotificationMessagesTable,
          NotificationMessage
        >,
      ),
      NotificationMessage,
      PrefetchHooks Function()
    >;
typedef $$TasksTableTableCreateCompanionBuilder = TasksTableCompanion Function({
  required String id,
  required String title,
  Value<bool> isCompleted,
  required String serializedTags,
  Value<int> rowid,
});
typedef $$TasksTableTableUpdateCompanionBuilder = TasksTableCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<bool> isCompleted,
  Value<String> serializedTags,
  Value<int> rowid,
});

class $$TasksTableTableFilterComposer
    extends Composer<_$AppDatabase, $TasksTableTable> {
  $$TasksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serializedTags => $composableBuilder(
    column: $table.serializedTags,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TasksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTableTable> {
  $$TasksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serializedTags => $composableBuilder(
    column: $table.serializedTags,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TasksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTableTable> {
  $$TasksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serializedTags => $composableBuilder(
    column: $table.serializedTags,
    builder: (column) => column,
  );
}

class $$TasksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTableTable,
          TasksTableData,
          $$TasksTableTableFilterComposer,
          $$TasksTableTableOrderingComposer,
          $$TasksTableTableAnnotationComposer,
          $$TasksTableTableCreateCompanionBuilder,
          $$TasksTableTableUpdateCompanionBuilder,
          (
            TasksTableData,
            BaseReferences<_$AppDatabase, $TasksTableTable, TasksTableData>,
          ),
          TasksTableData,
          PrefetchHooks Function()
        > {
  $$TasksTableTableTableManager(_$AppDatabase db, $TasksTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<String> serializedTags = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksTableCompanion(
                id: id,
                title: title,
                isCompleted: isCompleted,
                serializedTags: serializedTags,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<bool> isCompleted = const Value.absent(),
                required String serializedTags,
                Value<int> rowid = const Value.absent(),
              }) => TasksTableCompanion.insert(
                id: id,
                title: title,
                isCompleted: isCompleted,
                serializedTags: serializedTags,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TasksTableTable, TasksTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $TasksTableTable,
                    TasksTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TasksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTableTable,
      TasksTableData,
      $$TasksTableTableFilterComposer,
      $$TasksTableTableOrderingComposer,
      $$TasksTableTableAnnotationComposer,
      $$TasksTableTableCreateCompanionBuilder,
      $$TasksTableTableUpdateCompanionBuilder,
      (
        TasksTableData,
        BaseReferences<_$AppDatabase, $TasksTableTable, TasksTableData>,
      ),
      TasksTableData,
      PrefetchHooks Function()
    >;
typedef $$AppearanceSettingsTableCreateCompanionBuilder =
    AppearanceSettingsCompanion Function({
      Value<int> id,
      required ThemeMode themeMode,
      required Locale locale,
      required Color seedColor,
      required DateTime updatedAt,
    });
typedef $$AppearanceSettingsTableUpdateCompanionBuilder =
    AppearanceSettingsCompanion Function({
      Value<int> id,
      Value<ThemeMode> themeMode,
      Value<Locale> locale,
      Value<Color> seedColor,
      Value<DateTime> updatedAt,
    });

class $$AppearanceSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppearanceSettingsTable> {
  $$AppearanceSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ThemeMode, ThemeMode, String> get themeMode =>
      $composableBuilder(
        column: $table.themeMode,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Locale, Locale, String> get locale =>
      $composableBuilder(
        column: $table.locale,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Color, Color, int> get seedColor =>
      $composableBuilder(
        column: $table.seedColor,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppearanceSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppearanceSettingsTable> {
  $$AppearanceSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seedColor => $composableBuilder(
    column: $table.seedColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppearanceSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppearanceSettingsTable> {
  $$AppearanceSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ThemeMode, String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Locale, String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Color, int> get seedColor =>
      $composableBuilder(column: $table.seedColor, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppearanceSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppearanceSettingsTable,
          AppearanceSettingsData,
          $$AppearanceSettingsTableFilterComposer,
          $$AppearanceSettingsTableOrderingComposer,
          $$AppearanceSettingsTableAnnotationComposer,
          $$AppearanceSettingsTableCreateCompanionBuilder,
          $$AppearanceSettingsTableUpdateCompanionBuilder,
          (
            AppearanceSettingsData,
            BaseReferences<
              _$AppDatabase,
              $AppearanceSettingsTable,
              AppearanceSettingsData
            >,
          ),
          AppearanceSettingsData,
          PrefetchHooks Function()
        > {
  $$AppearanceSettingsTableTableManager(
    _$AppDatabase db,
    $AppearanceSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppearanceSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppearanceSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppearanceSettingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<ThemeMode> themeMode = const Value.absent(),
                Value<Locale> locale = const Value.absent(),
                Value<Color> seedColor = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AppearanceSettingsCompanion(
                id: id,
                themeMode: themeMode,
                locale: locale,
                seedColor: seedColor,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required ThemeMode themeMode,
                required Locale locale,
                required Color seedColor,
                required DateTime updatedAt,
              }) => AppearanceSettingsCompanion.insert(
                id: id,
                themeMode: themeMode,
                locale: locale,
                seedColor: seedColor,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppearanceSettingsTable, AppearanceSettingsData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $AppearanceSettingsTable,
                    AppearanceSettingsData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppearanceSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppearanceSettingsTable,
      AppearanceSettingsData,
      $$AppearanceSettingsTableFilterComposer,
      $$AppearanceSettingsTableOrderingComposer,
      $$AppearanceSettingsTableAnnotationComposer,
      $$AppearanceSettingsTableCreateCompanionBuilder,
      $$AppearanceSettingsTableUpdateCompanionBuilder,
      (
        AppearanceSettingsData,
        BaseReferences<
          _$AppDatabase,
          $AppearanceSettingsTable,
          AppearanceSettingsData
        >,
      ),
      AppearanceSettingsData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NotificationMessagesTableTableManager get notificationMessages =>
      $$NotificationMessagesTableTableManager(_db, _db.notificationMessages);
  $$TasksTableTableTableManager get tasksTable =>
      $$TasksTableTableTableManager(_db, _db.tasksTable);
  $$AppearanceSettingsTableTableManager get appearanceSettings =>
      $$AppearanceSettingsTableTableManager(_db, _db.appearanceSettings);
}
