import 'package:dmfsse/src/screens/homepage_screen.dart';
import 'package:flutter/material.dart';

import '../src/screens/login_screen.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings){
    if(settings.name == '/'){
      return MaterialPageRoute(builder: (context) => const Homepage());
    }
    else if(settings.name == '/login'){
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
    else {
        return MaterialPageRoute(builder: (context) => const Homepage());
    }
  }

}