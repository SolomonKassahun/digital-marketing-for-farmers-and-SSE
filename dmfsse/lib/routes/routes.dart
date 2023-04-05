import 'package:dmfsse/src/screens/customer/customer_homepage.dart';
import 'package:dmfsse/src/screens/farmer/add_product_detail.dart';
import 'package:dmfsse/src/screens/farmer/farmer_homepage.dart';
import 'package:dmfsse/src/screens/homepage_screen.dart';
import 'package:dmfsse/src/screens/splash_screen.dart';
import 'package:dmfsse/src/screens/sse/sse_homepage.dart';
import 'package:flutter/material.dart';
import '../src/screens/common/registration/signup_page.dart';
import '../src/screens/login_screen.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => const FarmerHomepage());
    } else if (settings.name == '/login') {
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    } else if (settings.name == '/registration') {
      return MaterialPageRoute(builder: (context) => const SignupPage());
    } else if (settings.name == '/addProductDetail') {
      return MaterialPageRoute(builder: (context) => const AddProductDetail());
    } else if (settings.name == '/farmerHomepage') {
      return MaterialPageRoute(builder: (context) => const FarmerHomepage());
    } else if (settings.name == '/customerHomepage') {
      return MaterialPageRoute(builder: (context) => const CustomerHomepage());
    } else if (settings.name == '/splash_screen') {
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    } else if (settings.name == '/sse_homepage') {
      return MaterialPageRoute(builder: ((context) => const SseHomepage()));
    }
    // else if (settings.name == '/homepage/product_detail') {

    //   return MaterialPageRoute(builder: (context) => const ProductDetail());
    // }
    else {
      return MaterialPageRoute(builder: (context) => const Homepage());
    }
  }
}
