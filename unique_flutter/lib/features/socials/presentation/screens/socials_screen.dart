import 'package:flutter/material.dart';

class const SocialsScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Social Links')),
      body: const Center(child: Text('Connect with us on Social Media')),
    );
  }
}
