import 'package:dmfsse/src/bloc/user/user_bloc.dart';
import 'package:dmfsse/src/bloc/user/user_state.dart';
import 'package:dmfsse/src/screens/common/widget/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user/user_event.dart';
import '../../login_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final String id;
  const ForgetPasswordScreen({required this.id, super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isUpdate = false;
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
        backgroundColor: const Color.fromARGB(255, 15, 23, 43),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 15, 23, 43),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 35,
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserForgetPasswordSuccess) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                  }
                },
                builder: (context, state) {
                  if (state is UserForgetPasswordInitial) {
                    isUpdate = true;
                  } else {
                    isUpdate = false;
                  }
                  return SingleChildScrollView(
                    child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "New Password",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 15, 23, 43)),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            InputTextFormField(
                              hintTxt: 'New Password',
                              controller: passwordController,
                              isRequired: false,
                              onChanged: (String value) {},
                              keyboardType: TextInputType.text,
                              errorMessage: "enter new password",
                              obscureText: _isObscured,
                              isPassword: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter new passowrd";
                                } else if (value.toString().length < 6) {
                                  return "password must greater than 6 ";
                                } else {
                                  return null;
                                }
                              },
                              isObscured: (value) {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              "Confirm New Password",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 15, 23, 43)),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            InputTextFormField(
                              hintTxt: 'Confirm New Password',
                              controller: confirmPasswordController,
                              isRequired: false,
                              onChanged: (String value) {},
                              keyboardType: TextInputType.text,
                              errorMessage: "confirm new password",
                              obscureText: _isObscured,
                              isPassword: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "confirm new password";
                                } else if (passwordController.text != value) {
                                  return "password  didn't  match";
                                }
                              },
                              isObscured: (bool isObscured) {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ElevatedButton(
                                  onPressed: () {
                                    formKey.currentState!.save();
                                    if (formKey.currentState!.validate()) {
                                      if ((formKey.currentState!.validate()) &&
                                          (passwordController.text.toString() ==
                                              confirmPasswordController.text
                                                  .toString())) {
                                        ForgetPasswordEvent
                                            forgetPasswordEvent =
                                            ForgetPasswordEvent(
                                                newPassword: passwordController
                                                    .text
                                                    .toString(),
                                                userId: widget.id);
                                        BlocProvider.of<UserBloc>(context)
                                            .add(forgetPasswordEvent);
                                      }
                                    }
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  255, 15, 23, 43)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ))),
                                  child: isUpdate
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text("Save Changes")),
                            ),
                          ],
                        )),
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
