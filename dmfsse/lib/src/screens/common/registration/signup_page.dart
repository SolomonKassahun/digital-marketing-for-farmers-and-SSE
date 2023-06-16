import 'package:dmfsse/src/screens/common/registration/password_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';
import '../widget/input_field.dart';
import '../widget/roles_dropdown.dart';

class SignupPage extends StatefulWidget {
  static String routeName = '/registration';
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String role = 'Customer';
  RegExp regExp = RegExp(r'^[0-9]+$');

  FocusNode focusNode = FocusNode();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController rolesController = TextEditingController();

  bool isNumeric(String s) {
    // ignore: unnecessary_null_comparison
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text:  TextSpan(children: [
        TextSpan(
          text: '${LocaleKeys.creatYourAccountText.tr()}\n',
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
        // TextSpan(
        //   text: 'Register to access your account',
        //   style: TextStyle(color: Colors.white, fontSize: 15),
        // ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 23, 43),
      ),
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(255, 15, 23, 43),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            _title(),
            const SizedBox(
              height: 15,
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
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          LocaleKeys.firstNameText.tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 15, 23, 43)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InputTextFormField(
                          hintTxt: LocaleKeys.firstNameText.tr(),
                          controller: firstNameController,
                          isRequired: false,
                          onChanged: (String value) {},
                          keyboardType: TextInputType.text,
                          errorMessage: LocaleKeys.firstNameText.tr(),
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.firstNameText.tr();
                            } else {
                              return null;
                            }
                          },
                        ),
                         Text(
                          LocaleKeys.lastNameText.tr(),
                          style: const  TextStyle(
                              fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 15, 23, 43)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //  InputTextFormField(),
                        InputTextFormField(
                          hintTxt: LocaleKeys.lastNameText.tr(),
                          controller: lastNameController,
                          isRequired: false,
                          onChanged: (String value) {},
                          keyboardType: TextInputType.text,
                          errorMessage: LocaleKeys.creatYourAccountText.tr(),
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.lastNameText.tr();
                            } else {
                              return null;
                            }
                          },
                        ),
                         Text(
                          LocaleKeys.phoneNumberText.tr(),
                          style: const  TextStyle(
                              fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 15, 23, 43)),
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
                          errorMessage: LocaleKeys.phoneNumberText.tr(),
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Invalid phone number";
                            } else if (value.toString().length != 10) {
                              return "Invalid phone number";
                            } else if (!isNumeric(value)) {
                              print(isNumeric(value));
                              return "Invalid phone number";
                            } else if (value.toString().characters.first != '0') {
                              return "Invalid phone number";
                            } else {
                              return null;
                            }
                          },
                        ),
                         Text(
                          LocaleKeys.addressText.tr(),
                          style: const  TextStyle(
                              fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 15, 23, 43)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //  InputTextFormField(),
                        InputTextFormField(
                          hintTxt: LocaleKeys.addressText.tr(),
                          controller: addressController,
                          isRequired: false,
                          onChanged: (String value) {},
                          keyboardType: TextInputType.text,
                          errorMessage: LocaleKeys.addressText.tr(),
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.addressText.tr();
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        RolesDropDown(
                          changeRole: (String value) {
                            setState(() {
                              role = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: SizedBox(
                            // alignment: Alignment.center,
                            width: 150,
                            height: 40,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(const Color.fromARGB(255, 15, 23, 43)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ))),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) => PasswordPage(
                                                firstName:
                                                    firstNameController.text,
                                                lastName:
                                                    lastNameController.text,
                                                phoneNumber:
                                                    phoneNumberController.text,
                                                role: role))));
                                    print('the roles is $role');
                                  }
                                },
                                child:  Text(LocaleKeys.nextText.tr())),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
