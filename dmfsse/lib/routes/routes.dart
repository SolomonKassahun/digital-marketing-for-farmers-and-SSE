
import 'package:dmfsse/src/screens/common/registration/password_page.dart';
import 'package:dmfsse/src/screens/farmer/add_product_detail.dart';
import 'package:dmfsse/src/screens/homepage_screen.dart';
import 'package:flutter/material.dart';

import '../src/screens/common/registration/signup_page.dart';
import '../src/screens/login_screen.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings){
    if(settings.name == '/'){
      return MaterialPageRoute(builder: (context) => const Homepage());
    }
    else if(settings.name == '/login'){
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
    else if(settings.name == '/registration'){
      return MaterialPageRoute(builder: (context) => const SignupPage());
    }
    else if(settings.name == '/addProductDetail'){
      return MaterialPageRoute(builder: (context) => const AddProductDetail());
    }
    else if(settings.name == '/password_page'){
      return MaterialPageRoute(builder: (context) => const PasswordPage());
    }
    else {
        return MaterialPageRoute(builder: (context) => const Homepage());
    }
  }

}