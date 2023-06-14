import 'dart:async';

import 'package:flutter/material.dart';

import '../../local_storage/user_preference.dart';
import 'customer/customer_homepage.dart';
import 'farmer/farmer_homepage.dart';
import 'homepage_screen.dart';
import 'sse/sse_homepage.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    UserPreference userPreference = UserPreference();
    userPreference.getUserInformation().then((value) async {
      Timer(const Duration(milliseconds: 2000), () {
        if (value == null) {
          print("User is not logged in");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Homepage()),
              (route) => false);
        } else {
          if (value.roles.first == "farmer") {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const FarmerHomepage()),
                (route) => false);
          } else if (value.roles.first == "customer") {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const CustomerHomepage()),
                (route) => false);
          } else if (value.roles.first == 'sse') {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SseHomepage()),
                (route) => false);
          }
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color.fromARGB(255, 15, 23, 43),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.2,
            // ),
            

            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: 50,
            //   padding: const EdgeInsets.only(top: 50),
            //   decoration: const BoxDecoration(
            //       // image:
            //       image: DecorationImage(
            //           image: AssetImage(
            //             'assets/images/logo-o.jpg',
            //           ),
            //           fit: BoxFit.cover)),
            // ),
          
            Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: const Text(
                  "SHEMETA",
                  style: TextStyle(fontSize: 35, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
