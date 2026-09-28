export 'package:unique_client/unique_client.dart';
export 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart'
    hide Protocol;
export 'package:serverpod_flutter/serverpod_flutter.dart';

// Future<void> initializeClient() async {
//   client = Client(await serverUrl)
//     ..connectivityMonitor = FlutterConnectivityMonitor()
//     ..authSessionManager = FlutterAuthSessionManager();
//   unawaited(client.auth.initialize());
// }
