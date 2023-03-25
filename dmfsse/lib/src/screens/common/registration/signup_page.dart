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
  TextEditingController fullNameController = TextEditingController();
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
                          "Full Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        //  InputTextFormField(),
                        InputTextFormField(
                          hintTxt: 'Write full name',
                          controller: fullNameController,
                          isRequired: false,
                          onChanged: (String value) {},
                          keyboardType: TextInputType.text,
                        ),
                        const Text(
                          "Phone Number",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        //  InputTextFormField(),
                        InputTextFormField(
                          hintTxt: 'Enter phone number',
                          controller: phoneNumberController,
                          isRequired: false,
                          onChanged: (String value) {},
                          keyboardType: TextInputType.number,
                        ),
                        const Text(
                          "Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        //  InputTextFormField(),
                        InputTextFormField(
                          hintTxt: 'Write you address here',
                          controller: addressController,
                          isRequired: false,
                          onChanged: (String value) {},
                          keyboardType: TextInputType.number,
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
                       const SizedBox(height: 15,),
                       Center(
                         child: SizedBox(
                          // alignment: Alignment.center,
                          width: 150,
                          height: 40,
                           child: ElevatedButton(
                            style: ButtonStyle(
                                  backgroundColor:MaterialStateProperty.all(Colors.blue),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),
                                    )
                                  )
                                      
                                    
                                ),
                            onPressed: (){
                              Navigator.pushNamed(context, PasswordPage.routeName);
                               print(role);
                            }, 
                            child: const Text("Next")
                            ),
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
