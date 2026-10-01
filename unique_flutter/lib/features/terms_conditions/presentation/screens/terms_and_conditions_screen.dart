import 'package:flutter/material.dart';

class const TermsAndConditionsScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms and Conditions')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text('Terms and Conditions for store, vendors and users.'),
        ),
      ),
    );
  }
}
