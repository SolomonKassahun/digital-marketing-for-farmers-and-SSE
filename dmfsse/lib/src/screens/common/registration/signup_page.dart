import 'package:dmfsse/src/screens/common/registration/password_page.dart';
import 'package:flutter/material.dart';

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

  FocusNode focusNode = FocusNode();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController rolesController = TextEditingController();

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(children: [
        TextSpan(
          text: 'Create Your Account\n',
          style: TextStyle(color: Colors.white, fontSize: 30),
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
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        width: double.infinity,
        color: Colors.blueAccent,
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
                        const Text(
                          "First Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InputTextFormField(
                          hintTxt: 'Write first  name',
                          controller: firstNameController,
                          isRequired: false,
                          onChanged: (String value) {},
                          keyboardType: TextInputType.text,
                          errorMessage: "first name",
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter first name";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const Text(
                          "Last Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //  InputTextFormField(),
                        InputTextFormField(
                          hintTxt: 'Write last name',
                          controller: lastNameController,
                          isRequired: false,
                          onChanged: (String value) {},
                          keyboardType: TextInputType.text,
                          errorMessage: 'last name',
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter last name";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const Text(
                          "Phone Number",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //  InputTextFormField(),
                        InputTextFormField(
                          hintTxt: 'Enter phone number',
                          controller: phoneNumberController,
                          isRequired: false,
                          onChanged: (String value) {},
                          keyboardType: TextInputType.number,
                          errorMessage: "phone number",
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Phone number";
                            } else if (value.toString().length < 10) {
                              return "phone number must be 10 digit";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const Text(
                          "Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //  InputTextFormField(),
                        InputTextFormField(
                          hintTxt: 'Write you address here',
                          controller: addressController,
                          isRequired: false,
                          onChanged: (String value) {},
                          keyboardType: TextInputType.number,
                          errorMessage: "address",
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter address";
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
                                        MaterialStateProperty.all(Colors.blue),
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
                                child: const Text("Next")),
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
