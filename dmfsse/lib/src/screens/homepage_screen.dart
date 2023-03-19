import 'package:dmfsse/src/screens/login_screen.dart';
import 'package:flutter/material.dart';


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
     
      body: Center(
        child: ElevatedButton(onPressed: (){
          Navigator.pushNamed(context, LoginScreen.routeName);
        }, child: const Text("Log in")),
      ),
    );
  }
}