import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dmfsse/src/screens/common/widget/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user/user_bloc.dart';
import '../../../bloc/user/user_event.dart';
import '../../../bloc/user/user_state.dart';
import '../../../models/login_info.dart';
import '../auth/firebas_auth_service.dart';

class GetUserInfo extends StatefulWidget {
  const GetUserInfo({super.key});

  @override
  State<GetUserInfo> createState() => _GetUserInfoState();
}

class _GetUserInfoState extends State<GetUserInfo> {
  TextEditingController phoneNumberController = TextEditingController();
  LoggedInUserInfo? loggedInUserInfo;
  bool isCodeSent = false;
  final formKey = GlobalKey<FormState>();
  bool isNumeric(String s) {
    // ignore: unnecessary_null_comparison
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
  TextEditingController pinCodeController = TextEditingController();

    FirebaseAuth auth = FirebaseAuth.instance;
   

  void verifyPhoneNumber()async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber:
              "+251${phoneNumberController.text.toString().substring(1)}",
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await auth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException firebaseAuthException) {
           
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
          codeSent: (String verificationId, int? resendToken) async {
            String sms = pinCodeController.text.toString();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text("Please check your phone for the verification code")));

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) =>  FirebaseAuthService(loggedInUserInfo: loggedInUserInfo as LoggedInUserInfo,)),
                (route) => false);
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: sms);
            await auth.signInWithCredential(phoneAuthCredential);
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 23, 43),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3,left: 20,right: 20),
          child: BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                if(state is GetUserInfoSucess){
                  loggedInUserInfo = state.user as LoggedInUserInfo;
                  verifyPhoneNumber();
        
                //  Navigator.pushAndRemoveUntil(
                // context,
                // MaterialPageRoute(builder: (context) =>  FirebaseAuthService(loggedInUserInfo: state.user as LoggedInUserInfo,)),
                // (route) => false);
                }
              },
              
              builder: (context, state) {
              if(state is GetUserInfoInitial){
                isCodeSent = true;
              } else{
                isCodeSent = false;
              }
                return Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Phone Number",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Color.fromARGB(255, 15, 23, 43)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //  InputTextFormField(),
                        InputTextFormField(
                          hintTxt: '09*********',
                          controller: phoneNumberController,
                          isRequired: false,
                          onChanged: (String value) {},
                          keyboardType: TextInputType.phone,
                          errorMessage: "phone number",
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Phone number";
                            } else if (value.toString().length != 10) {
                              return "phone number must be 10 digit";
                            } else if (!isNumeric(value)) {
                              print(isNumeric(value));
                              return "phone number must be number";
                            } else if (value.toString().characters.first != '0') {
                              return "phone number must start with 0";
                            } else {
                              return null;
                            }
                          },
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
                                GetUserByPhoneNumber getUserByPhoneNumber = GetUserByPhoneNumber(phoneNumber: phoneNumberController.text.toString());
                                BlocProvider.of<UserBloc>(context).add(getUserByPhoneNumber);
                              }
                            },
                            child: isCodeSent
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text("Send Code")),
                      ),
                        // Container(
                        //   margin: const EdgeInsets.only(left: 50, right: 50),
                        //   width: 60,
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(100),
                        //   ),
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       if(formKey.currentState!.validate()){
                        //         GetUserByPhoneNumber getUserByPhoneNumber = GetUserByPhoneNumber(phoneNumber: phoneNumberController.text.toString());
                        //         BlocProvider.of<UserBloc>(context).add(getUserByPhoneNumber);
                        //       }
                        //     },
                        //     style: ButtonStyle(
                        //         backgroundColor:
                        //             MaterialStateProperty.all(Colors.blue),
                        //         shape:
                        //             MaterialStateProperty.all(RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(25),
                        //         ))),
                        //     child: isVerify
                        //         ? const CircularProgressIndicator(
                        //             color: Colors.white,
                        //           )
                        //         : const Text("Send Code"),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
