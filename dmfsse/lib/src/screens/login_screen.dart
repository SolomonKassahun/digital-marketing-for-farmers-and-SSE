import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dmfsse/src/bloc/Auth/auth_bloc.dart';
import 'package:dmfsse/src/bloc/Auth/auth_event.dart';
import 'package:dmfsse/src/bloc/Auth/auth_state.dart';
import 'package:dmfsse/src/models/login_info.dart';
import 'package:dmfsse/src/screens/customer/customer_homepage.dart';
import 'package:dmfsse/src/screens/farmer/farmer_homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import 'auth/fireabase_verification_screen.dart';
import 'common/widget/custom_login_textfield.dart';
import 'common/widget/get_user_info.dart';
import 'sse/sse_homepage.dart';

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
   LoggedInUserInfo? loggedInUserInfo;
  void loginHandler() {
    LoginInfo loginInfo = LoginInfo(
        phoneController.text.toString(), passwordController.text.toString());
    Loging loging = Loging(loginInfo);
    BlocProvider.of<LoginBloc>(context).add(loging);
  }

  bool _isObscured = true;
  bool isLoading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  void verifyPhoneNumber() async{
      FirebaseAuth auth = FirebaseAuth.instance;

      try {
        await  auth.verifyPhoneNumber(
          phoneNumber: "+251${phoneController.text.toString()}",
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async{
           await auth.signInWithCredential(phoneAuthCredential);
        },
         verificationFailed: (FirebaseAuthException firebaseAuthException){
        
            AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: "Phone number verification failed.",
        desc: firebaseAuthException.message,
        btnOkOnPress: () {
          Navigator.pop(context);
        },
      ).show();
    
         }, 
         codeSent: (String verificationId, int? forceResendingToken) async {
           ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Please check your phone for the verification code")));
        Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  FirebaseAuthScreen(id: loggedInUserInfo!.id,loggedInUserInfo: loggedInUserInfo as LoggedInUserInfo,token: loggedInUserInfo!.accessToken,verificationID: verificationId,)),
              (route) => false);
         },
          codeAutoRetrievalTimeout: (String verificationId) {
            
          }
          );
      } catch (e) {
        AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: "Failed to Verify Phone Number",
        desc: e.toString(),
        btnOkOnPress: () {},
      ).show();
      }
      
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        child: BlocConsumer<LoginBloc, LoginState>(listener: ((context, state) {
          //  final progress = ProgressHUD.of(context);

          if (state is LoginSucess) {
            loggedInUserInfo = state.loggedInUserInfo;
            verifyPhoneNumber();
            //  Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) =>  FirebaseAuthScreen(id: state.loggedInUserInfo.id.toString(), loggedInUserInfo: state.loggedInUserInfo, token: state.loggedInUserInfo.accessToken.toString(),)),
            //   (route) => false);
            // progress!.dismiss();
            // if (state.loggedInUserInfo.roles.first == 'farmer') {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const FarmerHomepage()));
            // }
            // if (state.loggedInUserInfo.roles.first == 'customer') {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const CustomerHomepage()));
            // }
            // if (state.loggedInUserInfo.roles.first == 'sse') {
            //   Navigator.of(context).pushReplacementNamed(SseHomepage.routeName);
            // }
          }

          if (state is LoginingState) {
            // progress!.showWithText("Loging");
          }
          if (state is LoginFailure) {
            // progress!.dismiss();
          }
        }), builder: (context, state) {
          Widget label;
          if (state is LoginFailure) {
            isLoading = false;
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
            isLoading = true;
            label = const SizedBox();

            // label = const CircularProgressIndicator(
            //   color: Colors.black,
            // );
          } else {
            label = const SizedBox();
          }
          return Form(
              key: formKey,
              // ignore: prefer_const_constructors
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.only(top: 45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 45,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: const BoxDecoration(
                            // image:
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/logo-o.jpg',
                                ),
                                fit: BoxFit.contain)),
                      ),

                      label,
                      const SizedBox(height: 50,),
                      CustomLoginTextField(
                        // isObsecure: false,
                        textFieldName: "enter phone number",
                        controller: phoneController,
                        errorMessage: 'Phone number?',
                        icon: Icons.phone,
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
                        errorMessage: 'password?',
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
                      Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(const Color.fromARGB(255, 15, 23, 43)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ))),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                loginHandler();
                              }
                            },
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text("Log in")),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => GetUserInfo()));
                              },
                              child: const Text(
                                "Forget Password",
                                style: TextStyle(color:  Color.fromARGB(255, 15, 23, 43)),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("New user?"),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/registration');
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                    color:  Color.fromARGB(255, 15, 23, 43), fontSize: 20),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ));
        }),
      ),
    );
  }
}
