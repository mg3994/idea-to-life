import 'package:flutter/material.dart';
import 'package:kaisel/kaisel.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../../core/core.dart'
    show Client, BuildContextLocalizationExtensions;

class const AuthenticationModalScreen({required final Client client, super.key})
    extends StatefulWidget {
  @override
  State<AuthenticationModalScreen> createState() =>
      _AuthenticationModalScreenState();
}

class _AuthenticationModalScreenState extends State<AuthenticationModalScreen> {
  @override
  void initState() {
    widget.client.auth.authInfoListenable.addListener(listener);
    super.initState();
  }

  void listener() {
    // kaisel modal return result api
    final result = widget.client.auth.isAuthenticated;
    if (result) {
      context.completeFlow<bool>(result);
    }
  }

  @override
  void dispose() {
    widget.client.auth.authInfoListenable.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              context.completeFlow<bool>(false);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),

      body: SignInWidget(
        client: widget.client,
        onAuthenticated: () {
          context.showSnackBar(
            message: 'User authenticated.',
            backgroundColor: colors.primaryContainer,
            foregroundColor: colors.onPrimaryContainer,
          );
        },
        onError: (error) {
          context.showSnackBar(
            message: 'Authentication failed: $error',
            backgroundColor: colors.errorContainer,
            foregroundColor: colors.onErrorContainer,
          );
        },
      ),
    );
  }
}

extension on BuildContext {
  void showSnackBar({
    required String message,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    sm.showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: foregroundColor)),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
