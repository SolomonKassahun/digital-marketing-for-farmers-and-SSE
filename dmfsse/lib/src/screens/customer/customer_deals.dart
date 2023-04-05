import 'package:flutter/material.dart';

class CustomerDeals extends StatefulWidget {
  const CustomerDeals({super.key});

  @override
  State<CustomerDeals> createState() => _CustomerDealsState();
}

class _CustomerDealsState extends State<CustomerDeals> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("No Deals"),
      ),
    );
  }
}
