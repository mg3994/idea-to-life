import 'package:unique_client/unique_client.dart';

/// Remote datasource for user appearance settings connected via Serverpod [Client].
class AppearanceSettingsRemoteDatasource {
  /// Creates an [AppearanceSettingsRemoteDatasource] with the provided Serverpod [Client].
  AppearanceSettingsRemoteDatasource({required Client client}) : _client = client;

  final Client _client;

  /// Fetches appearance settings from the server for the current authenticated user.
  Future<UserAppearanceSettings?> getSettings() async {
    try {
      return await _client.appearance.getSettings();
    } catch (_) {
      return null;
    }
  }

  /// Updates user appearance settings on the server and broadcasts the update.
  Future<UserAppearanceSettings?> updateSettings({
    required String themeMode,
    required int seedColor,
    required String locale,
  }) async {
    try {
      return await _client.appearance.updateSettings(
        themeMode,
        seedColor,
        locale,
      );
    } catch (_) {
      return null;
    }
  }

  /// Streams real-time appearance settings updates from the Serverpod backend streaming connection.
  Stream<UserAppearanceSettings> streamSettings() async* {
    try {
      await for (final message in _client.streaming.stream) {
        if (message is UserAppearanceSettings) {
          yield message;
        }
      }
    } catch (_) {
      // Return empty stream if streaming fails or disconnects
    }
  }
}
