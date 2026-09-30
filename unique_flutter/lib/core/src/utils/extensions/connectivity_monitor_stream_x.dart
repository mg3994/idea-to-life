import 'dart:async' show StreamController;

import '../../../core.dart' show ConnectivityMonitor;

extension ConnectivityMonitorStreamX on ConnectivityMonitor {
  Stream<bool> get onConnectivityChanged {
    late StreamController<bool> controller;
    void listener(bool connected) => controller.add(connected);

    controller = StreamController<bool>.broadcast(
      onListen: () => addListener(listener),
      onCancel: () => removeListener(listener),
    );
    return controller.stream;
  }
}
