

import 'package:flutter/material.dart';

class FarmerOffer extends StatefulWidget {
  const FarmerOffer({super.key});

  @override
  State<FarmerOffer> createState() => _FarmerOfferState();
}

class _FarmerOfferState extends State<FarmerOffer> {
  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
     body: Center(
      child: Text("No Offer"),
     ),
    );
  }
}