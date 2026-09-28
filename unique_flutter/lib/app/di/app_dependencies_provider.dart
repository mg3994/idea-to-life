import 'package:flutter/widgets.dart' show InheritedWidget, BuildContext;

import 'app_dependencies.dart' show AppDependencies;

class const AppDependenciesProvider({
  super.key,
  required final AppDependencies appDependencies,
  required super.child,
}) extends InheritedWidget {
  static AppDependencies of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<AppDependenciesProvider>();
    assert(result != null, 'No DependenciesProvider found in context');
    return result!.appDependencies;
  }

  @override
  bool updateShouldNotify(AppDependenciesProvider oldWidget) =>
      appDependencies != oldWidget.appDependencies;
}
