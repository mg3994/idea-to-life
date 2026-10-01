import 'package:flutter/material.dart';

class const AboutScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Unique Platform - Blogger & Multivendor Commerce Platform',
          ),
        ),
      ),
    );
  }
}
