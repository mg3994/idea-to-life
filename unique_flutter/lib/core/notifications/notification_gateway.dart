import 'dart:async' show unawaited;

import 'package:firebase_messaging/firebase_messaging.dart'
    show
        NotificationSettings,
        RemoteMessage,
        BackgroundMessageHandler,
        FirebaseMessaging,
        AuthorizationStatus,
        AppleNotificationSetting,
        AppleShowPreviewSetting;

import '../core.dart' show FirebaseConstants;

/// Gateway for push notification setup and permissions.
abstract interface class const NotificationGateway() {
  Future<bool> isSupported();

  /// Requests user permission for notifications.
  Future<NotificationSettings> requestPermission({
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carPlay = false,
    bool criticalAlert = false,
    bool provisional = false,
    bool sound = true,
    bool providesAppNotificationSettings = false,
  });

  Future<NotificationSettings> getNotificationSettings();

  Future<String?> getToken({String? vapidKey, String? serviceWorkerScriptPath});

  Future<String?> getAPNSToken();

  Stream<String> get tokenChanges;

  Future<void> deleteToken();

  Stream<RemoteMessage> get onForegroundMessage;

  Stream<RemoteMessage> get onNotificationOpened;

  Future<RemoteMessage?> getInitialMessage();

  bool get isAutoInitEnabled;

  Future<void> setAutoInitEnabled(bool enabled);

  Future<void> setDeliveryMetricsExportToBigQuery(bool enabled);

  Future<void> subscribeToTopic(String topic);

  Future<void> unsubscribeFromTopic(String topic);

  Future<void> setForegroundPresentationOptions({
    bool alert = false,
    bool badge = false,
    bool sound = false,
  });

  Future<void> registerBackgroundHandler(BackgroundMessageHandler handler);
}

/// Default implementation of [NotificationGateway].
final class const DefaultNotificationGateway({
  /// When omitted, [FirebaseMessaging.instance] is resolved lazily.
  final FirebaseMessaging? _messaging,

  /// VAPID key used for web push notifications.
  final String? _vapidKey = FirebaseConstants.vapidKey,

  /// Service worker script path used for web push notifications.
  final String? _serviceWorkerScriptPath =
      FirebaseConstants.serviceWorkerScriptPath,
}) implements NotificationGateway {
  FirebaseMessaging get _instance => _messaging ?? FirebaseMessaging.instance;

  static const _unsupportedSettings = NotificationSettings(
    authorizationStatus: AuthorizationStatus.notDetermined,
    alert: AppleNotificationSetting.notSupported,
    announcement: AppleNotificationSetting.notSupported,
    badge: AppleNotificationSetting.notSupported,
    carPlay: AppleNotificationSetting.notSupported,
    lockScreen: AppleNotificationSetting.notSupported,
    notificationCenter: AppleNotificationSetting.notSupported,
    showPreviews: AppleShowPreviewSetting.notSupported,
    timeSensitive: AppleNotificationSetting.notSupported,
    criticalAlert: AppleNotificationSetting.notSupported,
    sound: AppleNotificationSetting.notSupported,
    providesAppNotificationSettings: AppleNotificationSetting.notSupported,
  );

  Future<T> _ifSupported<T>(Future<T> Function() action, T? unsupported) {
    return isSupported().then(
      (supported) => supported ? action() : Future<T>.value(unsupported),
    );
  }

  @override
  Future<bool> isSupported() => _instance.isSupported();

  @override
  Future<NotificationSettings> requestPermission({
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carPlay = false,
    bool criticalAlert = false,
    bool provisional = false,
    bool sound = true,
    bool providesAppNotificationSettings = false,
  }) {
    return _ifSupported(
      () => _instance.requestPermission(
        alert: alert,
        announcement: announcement,
        badge: badge,
        carPlay: carPlay,
        criticalAlert: criticalAlert,
        provisional: provisional,
        sound: sound,
        providesAppNotificationSettings: providesAppNotificationSettings,
      ),
      _unsupportedSettings,
    );
  }

  @override
  Future<NotificationSettings> getNotificationSettings() {
    return _ifSupported(
      _instance.getNotificationSettings,
      _unsupportedSettings,
    );
  }

  @override
  Future<String?> getToken({
    String? vapidKey,
    String? serviceWorkerScriptPath,
  }) {
    return _ifSupported(
      () => _instance
          .getToken(
            vapidKey: vapidKey ?? _vapidKey,
            serviceWorkerScriptPath:
                serviceWorkerScriptPath ?? _serviceWorkerScriptPath,
          )
          .catchError((_) => null),
      null,
    );
  }

  @override
  Future<String?> getAPNSToken() {
    return _ifSupported(_instance.getAPNSToken, null);
  }

  @override
  Stream<String> get tokenChanges =>
      isSupported().asStream().asyncExpand((supported) {
        if (!supported) {
          return const Stream.empty();
        }

        return Stream.multi((controller) {
          unawaited(
            getToken().then((token) {
              if (token != null) {
                controller.add(token);
              }

              return controller.addStream(_instance.onTokenRefresh);
            }),
          );
        });
      });

  @override
  Future<void> deleteToken() {
    return _ifSupported<void>(_instance.deleteToken, null);
  }

  @override
  Stream<RemoteMessage> get onForegroundMessage => FirebaseMessaging.onMessage;

  @override
  Stream<RemoteMessage> get onNotificationOpened =>
      FirebaseMessaging.onMessageOpenedApp;

  @override
  Future<RemoteMessage?> getInitialMessage() {
    return _ifSupported(_instance.getInitialMessage, null);
  }

  @override
  bool get isAutoInitEnabled => _instance.isAutoInitEnabled;

  @override
  Future<void> setAutoInitEnabled(bool enabled) {
    return _ifSupported<void>(
      () => _instance.setAutoInitEnabled(enabled),
      null,
    );
  }

  @override
  Future<void> setDeliveryMetricsExportToBigQuery(bool enabled) {
    return _ifSupported<void>(
      () => _instance.setDeliveryMetricsExportToBigQuery(enabled),
      null,
    );
  }

  @override
  Future<void> subscribeToTopic(String topic) {
    return _ifSupported<void>(() => _instance.subscribeToTopic(topic), null);
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) {
    return _ifSupported<void>(
      () => _instance.unsubscribeFromTopic(topic),
      null,
    );
  }

  @override
  Future<void> setForegroundPresentationOptions({
    bool alert = false,
    bool badge = false,
    bool sound = false,
  }) {
    return _ifSupported<void>(
      () => _instance.setForegroundNotificationPresentationOptions(
        alert: alert,
        badge: badge,
        sound: sound,
      ),
      null,
    );
  }

  @override
  Future<void> registerBackgroundHandler(BackgroundMessageHandler handler) {
    return _ifSupported<void>(() {
      FirebaseMessaging.onBackgroundMessage(handler);
      return Future<void>.value();
    }, null);
  }
}
