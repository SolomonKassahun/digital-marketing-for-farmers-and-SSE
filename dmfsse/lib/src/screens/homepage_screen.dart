import 'package:dmfsse/src/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'farmer/add_product_detail.dart';


class Homepage extends StatefulWidget {
   static const String routeName = "/";
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     
      body: const Center(
        child:  Text('Homepage'),
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 120,
        height: 45,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, LoginScreen.routeName);
          },

          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          child: const Text("Log in"),

        )
        ),
    );
  }
}