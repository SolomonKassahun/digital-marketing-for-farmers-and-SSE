import 'package:flutter/material.dart';


class FarmerHomepage extends StatelessWidget {
  const FarmerHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: const Text('farmer homepage'),
     ),
     body:const Center(
      child: Text("farmer homepage"),
     ),
    );
    
  }
}