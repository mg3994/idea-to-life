import 'package:firebase_messaging/firebase_messaging.dart' show RemoteMessage;

import '../../app/firebase/firebase_initializer.dart'
    show DefaultFirebaseInitializer;
import '../core.dart' show AppDatabase, AppFlavorConfig, Flavor, BuildMode;
import '../src/utils/utils.dart'
    show RemoteMessageToNotificationMessageCompanion;

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final rawFlavor = message.data['flavor'] as String? ?? 'production';

  final customFlavor = switch (rawFlavor) {
    'dev' || 'development' => Flavor.development,
    'stg' || 'staging' => Flavor.staging,
    _ => Flavor.production,
  };

  final customConfig = AppFlavorConfig(
    flavor: customFlavor,
    buildMode: BuildMode.current,
  );

  // Initialize Firebase using the parsed flavor
  await DefaultFirebaseInitializer(flavorConfig: customConfig).initialize();

  final db = AppDatabase(flavorConfig: customConfig);
  try {
    await db.notificationMsgDao.deleteExpiredMessages();
    await db.notificationMsgDao.insertNotificationMessage(
      message.toCompanion(),
    );
  } finally {
    await db.close();
  }
}
