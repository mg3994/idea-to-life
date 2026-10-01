import 'package:flutter/material.dart';

class const PrivacyPolicyScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text('Privacy Policy details and subscriber data rights.'),
        ),
      ),
    );
  }
}
