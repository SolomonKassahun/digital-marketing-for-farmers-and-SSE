import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dmfsse/local_storage/user_preference.dart';
import 'package:dmfsse/src/screens/homepage_screen.dart';
import 'package:dmfsse/src/screens/sse/sse_homepage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../generated/locale_keys.g.dart';
import '../../models/login_info.dart';
import '../customer/customer_homepage.dart';
import '../farmer/farmer_homepage.dart';

class FirebaseAuthScreen extends StatefulWidget {
  final LoggedInUserInfo loggedInUserInfo;
  final String token;
  final String id;
  final String verificationID;

  const FirebaseAuthScreen(
      {required this.loggedInUserInfo,
      required this.token,
      required this.id,
      required this.verificationID,
      super.key});

  @override
  State<FirebaseAuthScreen> createState() => _FirebaseAuthScreenState();
}

class _FirebaseAuthScreenState extends State<FirebaseAuthScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController pinCodeController = TextEditingController();
  bool hasError = false;
  bool isVerify = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  void verifyPhoneNumber() async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber:
              "+251${widget.loggedInUserInfo.phoneNumber.toString().substring(1)}",
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await auth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException firebaseAuthException) {
            setState(() {
              isVerify = false;
            });
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
                MaterialPageRoute(builder: (context) => const Homepage()),
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

  void signInWIthPhoneNumber() async {
    setState(() {
      isVerify = true;
    });
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationID.toString(),
      smsCode: pinCodeController.text,
    );
    final UserCredential user = (await auth.signInWithCredential(credential));
    UserPreference userPreference = UserPreference();
    await userPreference.storeUserInformation(widget.loggedInUserInfo);
    await userPreference.storeToken(widget.token);
    await userPreference.storeUserId(widget.id);
    if (widget.loggedInUserInfo.roles.first == 'customer') {
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const CustomerHomepage()),
              (route) => false);
     
    }
    if (widget.loggedInUserInfo.roles.first == 'farmer') {
       // ignore: use_build_context_synchronously
       Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const FarmerHomepage()),
              (route) => false);
      // ignore: use_build_context_synchronously
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const FarmerHomepage()));
    }
    if (widget.loggedInUserInfo.roles.first == 'sse') {
      // ignore: use_build_context_synchronously
       Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SseHomepage()),
              (route) => false);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              const SizedBox(height: 30),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('assets/images/phoneVerification.png'),
                ),
              ),
              const SizedBox(height: 8),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  LocaleKeys.phoneNumberVerficationText.tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: '${LocaleKeys.enterCodeText.tr()} ',
                      children: [
                        TextSpan(
                            text:
                                '+251${widget.loggedInUserInfo.phoneNumber.toString()}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    obscureText: false,
                    length: 6,
                    onChanged: (String value) {},
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.length < 6) {
                        return "Verification Code must be 6 digit";
                      }
                    },
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Colors.blue),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: pinCodeController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "Please fill up all the cells properly" : "",
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the code? ",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () {
                      
                    },
                    child:  Text(
                      LocaleKeys.resendText.tr(),
                      style: const  TextStyle(
                          color:  Color.fromARGB(255, 15, 23, 43),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                margin: const EdgeInsets.only(left: 50, right: 50),
                width: 60,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    signInWIthPhoneNumber();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 15, 23, 43),),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ))),
                  child: isVerify
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      :  Text(LocaleKeys.verfiyNumberText.tr()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
