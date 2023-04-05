import 'package:dmfsse/local_storage/user_preference.dart';

import 'package:dmfsse/src/bloc/Register/register_bloc.dart';
import 'package:dmfsse/src/data_provider/user_data_provider.dart';
import 'package:dmfsse/src/data_repository/product_data_repository.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'bloc_observer.dart';
import 'routes/routes.dart';
import 'src/bloc/Auth/auth_bloc.dart';
import 'src/bloc/product/product_bloc.dart';
import 'src/data_provider/product_data_provider.dart';
import 'src/data_repository/user_data_repository.dart';
import 'src/screens/customer/customer_homepage.dart';
import 'src/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  http.Client httpClient = http.Client();

  UserDataRepository userRepository =
      UserDataRepository(UserDataProvider(UserPreference()));
  ProductDataRepository productDataRepository =
      ProductDataRepository(ProductDataProvider());

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (_) => LoginBloc(userRepository)),
        BlocProvider<RegisterBloc>(create: (_) => RegisterBloc(userRepository)),
        BlocProvider<ProductBloc>(
            create: (_) => ProductBloc(productDataRepository))
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,

          // home: Login(),
          initialRoute: SplashScreen.routeName,
          onGenerateRoute: AppRoute.generateRoute

          // onUnknownRoute: (settings) {
          //     return MaterialPageRoute(builder: (context) => FarmerHomePage());
          //   },
          ),
    );
  }
}
