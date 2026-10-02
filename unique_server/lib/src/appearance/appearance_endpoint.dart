import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class AppearanceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Retrieves the appearance settings for the authenticated user.
  Future<UserAppearanceSettings?> getSettings(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return null;

    final userId = authInfo.userId;
    return await UserAppearanceSettings.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
  }

  /// Updates or creates the appearance settings for the authenticated user and broadcasts updates.
  Future<UserAppearanceSettings> updateSettings(
    Session session,
    String themeMode,
    int seedColor,
    String locale,
  ) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) {
      throw Exception('User not authenticated');
    }

    final userId = authInfo.userId;
    final existing = await UserAppearanceSettings.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );

    final now = DateTime.now();
    UserAppearanceSettings settings;

    if (existing != null) {
      existing.themeMode = themeMode;
      existing.seedColor = seedColor;
      existing.locale = locale;
      existing.updatedAt = now;
      settings = await UserAppearanceSettings.db.updateRow(session, existing);
    } else {
      settings = UserAppearanceSettings(
        userId: userId,
        themeMode: themeMode,
        seedColor: seedColor,
        locale: locale,
        updatedAt: now,
      );
      settings = await UserAppearanceSettings.db.insertRow(session, settings);
    }

    // Post update message to session channel for streaming
    session.messages.postMessage(
      'user_appearance_$userId',
      settings,
    );

    return settings;
  }

  /// Establishes stream connection for real-time appearance settings updates.
  @override
  Future<void> streamOpened(StreamingSession session) async {
    final authInfo = await session.authenticated;
    if (authInfo != null) {
      final userId = authInfo.userId;
      session.messages.addListener('user_appearance_$userId', (message) {
        if (message is UserAppearanceSettings) {
          sendStreamMessage(session, message);
        }
      });
    }
  }
}
