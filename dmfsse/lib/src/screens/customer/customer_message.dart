

import 'package:flutter/material.dart';

class CustomerMessage extends StatefulWidget {
  const CustomerMessage({super.key});

  @override
  State<CustomerMessage> createState() => _CustomerMessageState();
}

class _CustomerMessageState extends State<CustomerMessage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Message"),
      ),
    body: const Center(
      child: Text("No message"),
    ),
    );
  }
}