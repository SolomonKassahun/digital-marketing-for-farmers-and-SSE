

import 'package:flutter/material.dart';

class FarmerChat extends StatefulWidget {
  const FarmerChat({super.key});

  @override
  State<FarmerChat> createState() => _FarmerChatState();
}

class _FarmerChatState extends State<FarmerChat> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No message"),
    );
  }
}