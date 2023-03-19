import 'package:dmfsse/local_storage/user_preference.dart';
import 'package:dmfsse/routes/routes.dart';
import 'package:dmfsse/src/data_provider/user_data_provider.dart';
import 'package:dmfsse/src/screens/homepage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:http/http.dart' as http;

import 'bloc_observer.dart';
import 'src/bloc/Auth/auth_bloc.dart';

import 'src/data_repository/user_data_repository.dart';


void main() {
    Bloc.observer =  AppBlocObserver();
  runApp( MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  http.Client httpClient = http.Client();
  
  UserDataRepository userRepository = UserDataRepository( UserDataProvider(UserPreference()));

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(userRepository)
          )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
      
       
        // home: Login(),
       initialRoute: Homepage.routeName,
       onGenerateRoute: AppRoute.generateRoute,
     
       

      ),
    );
  }
}
