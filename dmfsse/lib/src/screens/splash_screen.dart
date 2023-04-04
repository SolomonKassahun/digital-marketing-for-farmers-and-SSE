import 'dart:async';

import 'package:flutter/material.dart';

import '../../local_storage/user_preference.dart';
import 'customer/customer_homepage.dart';
import 'farmer/farmer_homepage.dart';
import 'homepage_screen.dart';

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
      Timer(const Duration(milliseconds: 1000), () {
        if (value == null) {
          print("User is not logged in");

          Navigator.pushNamed(context, Homepage.routeName);
        } else {
          if (value.user.role == "admin") {
            Navigator.pushNamed(context, FarmerHomepage.routeName);
          } else if (value.user.role == "tech") {
            Navigator.pushNamed(context, CustomerHomepage.routeName);
          }
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: const EdgeInsets.only(top: 50),
            decoration: const BoxDecoration(
                // image:
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/logo-o.jpg',
                    ),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 35,
          ),
          const Text(
            "Digital Marker For Farmer   and Small Sized Enterprises",
            style: TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
