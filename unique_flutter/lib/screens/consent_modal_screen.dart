import 'package:flutter/material.dart';

class ConsentModalScreen extends StatelessWidget {
  const ConsentModalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Consent & Privacy')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Please accept our terms of service and privacy policy to continue.',
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Accept & Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
