import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
        backgroundColor: Colors.black,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'How to Use the System',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            
            SizedBox(height: 24),
            Text(
              'User Roles',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '1. Customer - Customers can do the following,'
              'view product (just opening the app),'
              'sign up (after pressing the log in button,'
              'the system prompts to sign up for new user) '
              'and purchase product (after logging in by '
              'pressing buy product button they can send '
              'offer and make payment).',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '2. Small Sized Enterprise (SSE) - SSE can '
              'do the following, sign up (If faces difficulty, '
              'can contact near by agents), manage product, '
              'customer communication (in the my product page)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '3. Farmer - Farmers can '
              'do the following, sign up (If faces difficulty, '
              'can contact near by agents), manage product, '
              'customer communication (in the my product page)',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
