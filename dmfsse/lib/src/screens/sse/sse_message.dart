import 'package:flutter/material.dart';

class SseMessage extends StatefulWidget {
  const SseMessage({super.key});

  @override
  State<SseMessage> createState() => _SseMessageState();
}

class _SseMessageState extends State<SseMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("message"),
      ),
      body: const Center(
        child: Text("No message"),
      ),
    );
  }
}
