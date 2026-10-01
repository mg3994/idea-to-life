import 'package:flutter/material.dart';
import 'package:kaisel/kaisel.dart';

import '../../../../navigation/router.dart'
    show AppRoute, AuthenticationModalRoute;

class const SupportScreen({super.key}) extends StatefulWidget {
  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  // final List<SupportItem> supportItems = [
  //   SupportItem(
  //     title: 'Get Help',
  //     subtitle: 'Chat with our support team',
  //     icon: Icons.chat_bubble,
  //     color: Colors.blue,
  //     route: 'chat', // Add this later
  //   ),
  //   SupportItem(
  //     title: 'FAQs',
  //     subtitle: 'Common questions & answers',
  //     icon: Icons.question_mark,
  //     color: Colors.green,
  //     route: 'faq', // Add this later
  //   ),
  //   SupportItem(
  //     title: 'How-To Guides',
  //     subtitle: 'Step-by-step instructions',
  //     icon: Icons.book,
  //     color: Colors.purple,
  //     route: 'guides', // Add this later
  //   ),
  //   SupportItem(
  //     title: 'Submit Feedback',
  //     subtitle: 'Share your thoughts with us',
  //     icon: Icons.feedback,
  //     color: Colors.orange,
  //     route: 'feedback', // Add this later
  //   ),
  // ];
  //

  checkFlow() async {
    /// kaisel check flow if flow exist then return it else
    final result = await context.router<AppRoute>().run<bool?>(
      AuthenticationModalRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Support')),
      body: Center(
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                checkFlow();
              },
              icon: Icon(Icons.support),
            ),
            Text('Help & Support Desk'),
          ],
        ),
      ),
    );
  }
}
