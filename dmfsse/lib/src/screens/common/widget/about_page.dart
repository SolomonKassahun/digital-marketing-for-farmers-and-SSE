import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.black,
      ),
      body:  Padding(
        padding:const  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
             Text(
              'Shemeta ' ' version 1.0',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'We give farmers direct access to the market'
              'We provide video and audio supported training'
              'for farmers and SSE',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Email: shemeta@gmail.com',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'website: www.shemeta.com',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Phone: +251 11-456-7890',
              style: TextStyle(fontSize: 16),
            ),
            
          ],
        ),
      ),
    );
  }
}

//void main() {
//  runApp(MaterialApp(
//  home: AboutUsPage(),
//  ));
//}
