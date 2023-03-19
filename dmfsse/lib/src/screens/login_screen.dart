import 'package:dmfsse/src/bloc/Auth/auth_bloc.dart';
import 'package:dmfsse/src/bloc/Auth/auth_event.dart';
import 'package:dmfsse/src/bloc/Auth/auth_state.dart';
import 'package:dmfsse/src/models/login_info.dart';
import 'package:dmfsse/src/screens/customer/customer_homepage.dart';
import 'package:dmfsse/src/screens/farmer/farmer_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/custom_login_textfield.dart';

class LoginScreen extends StatefulWidget {
   static String routeName = "/login";
   const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void loginHandler() {
    
    LoginInfo loginInfo = LoginInfo(phoneController.text.toString(),
        passwordController.text.toString(), "firstName", "lastName", "role");
    Loging loging = Loging(loginInfo);
    BlocProvider.of<LoginBloc>(context).add(loging);
  }
 bool _isObscured = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
    body: BlocConsumer<LoginBloc, LoginState>(
       listener: ((context, state) {
        if(state is LoginSucess){
          if(state.loggedInUserInfo.user.role == 'admin'){
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FarmerHomepage()));
          }
          if(state.loggedInUserInfo.user.role == 'tech'){
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CustomerHomepage()));
          }
          
        }
         
       }),
      builder: (context,state){
         Widget label;
            if (state is LoginFailure) {
              label = Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Center(
                    child: Text(
                      "failed to authenticate",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ));
            } else if (state is LoginingState) {
              label = const CircularProgressIndicator(
                color: Colors.black,
              );
            } else {
              label = const SizedBox();
            }  return Form(
                key: formKey,
                // ignore: prefer_const_constructors
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        label,
                        CustomLoginTextField(
                          // isObsecure: false,
                          textFieldName: "enter username",
                          controller: phoneController,
                          icon: Icons.email,
                          isDisabled: true,

                          validator: (value) {
                            if (value.isEmpty || value.toString().length < 10) {
                              return "enter username";
                            } else {
                              return null;
                            }
                          },
                          obsecureText: false,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomLoginTextField(
                          isPassword: true,
                          isDisabled: true,
                          isObscured: (value) {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                          keyboardType: TextInputType.text,
                          textFieldName: "enter password",
                          controller: passwordController,
                          icon: Icons.lock,
                          validator: (value) {
                            if (value.isEmpty || value.toString().length < 5) {
                              return "enter password";
                            } else {
                              return null;
                            }
                          },
                          obsecureText: _isObscured,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.pink),
                            ),
                            onPressed: () {
                             loginHandler();
                            },
                            child: const Text("Log in"))
                      ],
                    ),
                  ),
                ));
      }
      
       ),
    );
  }
}
