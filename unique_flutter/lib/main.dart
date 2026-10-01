import 'dart:async' show runZonedGuarded;

import 'package:flutter/foundation.dart' show PlatformDispatcher;
import 'package:flutter/material.dart';

import 'app/di/app_dependencies.dart' show AppDependencies;
import 'client.dart';
import 'core/core.dart' show BootstrapErrorReporter; //,FlavorConfig,
// currentFBConfig;
// import 'screens/greetings_screen.dart';
import 'app/app.dart';

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();

  final errors = BootstrapErrorReporter.active();

  FlutterError.onError = (details) {
    errors.report(details.exception, details.stack ?? StackTrace.current);
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    errors.report(error, stackTrace);
    return true;
  };
  // final FlavorConfig flavorConfig = currentFBConfig;
  final AppDependencies appDependencies = const AppDependencies(
    // flavorConfig: flavorConfig,
  );

  // await initializeClient();
  runZonedGuarded(
    () => runApp(
      BootStrap(
        // having const is more important for me
        binding: binding,
        errors: errors,
        appDependencies: appDependencies,
      ),
    ),
    errors.report,
  );
}

// /// Builds a theme for the given [brightness].
// ThemeData _buildTheme(Brightness brightness) {
//   return ThemeData(
//     colorScheme: ColorScheme.fromSeed(
//       seedColor: Colors.blue,
//       brightness: brightness,
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Serverpod Demo',
//       theme: _buildTheme(Brightness.light),
//       darkTheme: _buildTheme(Brightness.dark),
//       themeMode: ThemeMode.system,
//       home: const MyHomePage(title: 'Serverpod Example'),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       body: const GreetingsScreen(),
//       // To test authentication in this example app, uncomment the line below
//       // and comment out the line above. This wraps the GreetingsScreen with a
//       // SignInScreen, which automatically shows a sign-in UI when the user is
//       // not authenticated and displays the GreetingsScreen once they sign in.
//       //
//       // body: SignInScreen(
//       //   child: GreetingsScreen(
//       //     onSignOut: () async {
//       //       await client.auth.signOutDevice();
//       //     },
//       //   ),
//       // ),
//     );
//   }
// }
