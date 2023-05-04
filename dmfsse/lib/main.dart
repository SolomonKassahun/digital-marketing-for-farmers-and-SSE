import 'package:dmfsse/local_storage/user_preference.dart';
import 'package:dmfsse/src/bloc/Register/register_bloc.dart';
import 'package:dmfsse/src/bloc/order/order_bloc.dart';
import 'package:dmfsse/src/data_provider/user_data_provider.dart';
import 'package:dmfsse/src/data_repository/order_data_repository.dart';
import 'package:dmfsse/src/data_repository/product_data_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observer.dart';
import 'routes/routes.dart';
import 'src/bloc/Auth/auth_bloc.dart';
import 'src/bloc/message/message_bloc.dart';
import 'src/bloc/product/product_bloc.dart';
import 'src/bloc/training/training_bloc.dart';
import 'src/bloc/user/user_bloc.dart';
import 'src/data_provider/message_data_provider.dart';
import 'src/data_provider/order_data_provider.dart';
import 'src/data_provider/product_data_provider.dart';
import 'src/data_provider/training_data_provider.dart';
import 'src/data_repository/message_data_repository.dart';
import 'src/data_repository/training_data_repository.dart';
import 'src/data_repository/user_data_repository.dart';
import 'src/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('am'), Locale('en'), Locale('oro')],
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('am'),
      saveLocale: true,
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  final UserDataRepository userRepository =
      UserDataRepository(UserDataProvider(UserPreference()));
  final ProductDataRepository productDataRepository =
      ProductDataRepository(ProductDataProvider());
  final TrainingDataRepository trainingDataRepository =
      TrainingDataRepository(trainingDataProiver: TrainingDataProvider());
  final MessageDataRepository messageDataRepository =
      MessageDataRepository(messageDataProvier: MessageDataProvier());
  final OrderDataRepostory orderDataRepostory =
      OrderDataRepostory(orderDataProvider: OrderDataProvider());

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (_) => LoginBloc(userRepository)),
        BlocProvider<RegisterBloc>(create: (_) => RegisterBloc(userRepository)),
        BlocProvider<ProductBloc>(
            create: (_) => ProductBloc(productDataRepository)),
        BlocProvider<UserBloc>(create: (_) => UserBloc(userRepository)),
        BlocProvider<TrainingBloc>(
            create: (_) =>
                TrainingBloc(trainingDataRepository: trainingDataRepository)),
        BlocProvider<MessageBloc>(
            create: (_) =>
                MessageBloc(messageDataRepository: messageDataRepository)),
        BlocProvider<OrderBloc>(
            create: (_) => OrderBloc(orderDataRepostory: orderDataRepostory))
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
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
