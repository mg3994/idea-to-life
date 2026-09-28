import '../../core/core.dart'
    show
        FlavorConfig,
        currentFBConfig,
        NotificationGateway,
        DefaultNotificationGateway,
        AnalyticsGateway,
        FirebaseAnalyticsGateway,
        CrashReporter,
        DefaultCrashReporter;
import '../firebase/firebase_initializer.dart'
    show FirebaseInitializer, DefaultFirebaseInitializer;

/// Container holding pluggable external dependencies for bootstrap.
final class const AppDependencies({
  final FlavorConfig flavorConfig = currentFBConfig,

  /// Firebase initialization service.
  final FirebaseInitializer firebaseInitializer =
      const DefaultFirebaseInitializer(),

  /// Notification gateway service.
  final NotificationGateway notificationGateway =
      const DefaultNotificationGateway(),

  final AnalyticsGateway analyticsGateway = const FirebaseAnalyticsGateway(),

  /// Crashlytics / error reporting service.
  final CrashReporter crashReporter = const DefaultCrashReporter(),

  /// Runtime database instance (Optional in const constructor)
  // final AppDatabase? db,
  // final FirebaseAuth? auth,
  // final FirebaseAnalytics? analytics,
});
