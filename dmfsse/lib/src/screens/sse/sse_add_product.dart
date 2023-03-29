

import 'package:flutter/material.dart';

class SseAddProduct extends StatefulWidget {
  const SseAddProduct({super.key});

  @override
  State<SseAddProduct> createState() => _SseAddProductState();
}

class _SseAddProductState extends State<SseAddProduct> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
      ),
      body: const Center(
        child: Text("No product here"),
      ),
    )
    ;
  }
}