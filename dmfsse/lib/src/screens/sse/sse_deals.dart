

import 'package:flutter/material.dart';

class SseDeals extends StatefulWidget {
  const SseDeals({super.key});

  @override
  State<SseDeals> createState() => _SseDealsState();
}

class _SseDealsState extends State<SseDeals> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Deals"),
      ),
      body: const Center(
        child: Text("No deals"),
      ),
    );
  }
}