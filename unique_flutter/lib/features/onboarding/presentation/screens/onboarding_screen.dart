import 'package:flutter/material.dart';

class const OnboardingScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding'),
      ),
      body: const Center(
        child: Text('Onboarding'),
      ),
    );
  }
}
