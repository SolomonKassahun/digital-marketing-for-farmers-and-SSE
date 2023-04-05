import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/Register/register_bloc.dart';
import '../../../bloc/Register/register_event.dart';
import '../../../bloc/Register/register_state.dart';
import '../../../models/user.dart';
import '../widget/input_field.dart';
import '../widget/upload_image.dart';

class PasswordPage extends StatefulWidget {
  final String firstName;
  final String lastName;
  // final String email;
  final String phoneNumber;
  final String role;

  const PasswordPage(
      {required this.firstName,
      required this.lastName,
      // required this.email,
      required this.phoneNumber,
      required this.role,
      super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController profilePhotoController = TextEditingController();
  TextEditingController identificationPhotoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<RegisterBloc, RegisterState>(
            listener: ((context, state) {
      if (state is RegisterInitial) {
        const CircularProgressIndicator(
          color: Colors.white,
        );
      } else if (state is RegistrationSucess) {
        Navigator.pushNamed(context, 'login');
      }
    }), builder: (BuildContext context, state) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                //  InputTextFormField(),
                InputTextFormField(
                  hintTxt: 'New Password',
                  controller: passwordController,
                  isRequired: false,
                  onChanged: (String value) {},
                  keyboardType: TextInputType.text,
                  errorMessage: "password",
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Confirm Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                //  InputTextFormField(),
                InputTextFormField(
                  hintTxt: 'Confirm New Password',
                  controller: passwordController,
                  isRequired: false,
                  onChanged: (String value) {},
                  keyboardType: TextInputType.text,
                  errorMessage: "confirm new password",
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Add Profile Photo",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                Center(
                  child: UploadImage(pickImage: (image) {
                    setState(() {
                      profilePhotoController.text = image.path;
                    });
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Add Identification Photo",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),

                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: UploadImage(pickImage: (image) {
                    setState(() {
                      identificationPhotoController.text = image.path;
                    });
                  }),
                ),
                const SizedBox(
                  height: 20,
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
                          // if (passwordController.text.toString() !=
                          //     confirmPasswordController.text.toString()) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(
                          //           content: Text(
                          //               "Password and confirm password didnot match")));
                          // }
                          if (formKey.currentState!.validate()) {
                            User user = User();

                            user.firstName = widget.firstName.toString();
                            user.lastName = widget.lastName.toString();
                            user.phoneNumber = widget.phoneNumber.toString();
                            user.email = "dmfsse@gmail.com";
                            user.password = passwordController.text.toString();
                            user.roles = widget.role.toString().toLowerCase();
                            user.profilePicture =
                                profilePhotoController.text.toString();
                            user.identifictionPicture =
                                identificationPhotoController.text.toString();
                            print(
                                'the user role is ${widget.role.toString().toLowerCase()}');
                            RegisterDetailInfo registerDetailInfo =
                                RegisterDetailInfo(user);
                            BlocProvider.of<RegisterBloc>(context)
                                .add(registerDetailInfo);
                            print("clicked");
                          }
                        },
                        child: const Text("Register")),
                  ),
                )
              ],
            ),
          ),
        ),
      );

      //  ElevatedButton(
      //     onPressed: () {
      //       print(
      //           "Register method called from the customer apage");
      //       User user = User();
      //       user.username = "Name 2";
      //       user.firstName = "Name 2";
      //       user.lastName = "Name 2";
      //       user.password = "Name 2";
      //       user.role = "Name 2";
      //       RegisterDetailInfo registerDetailInfo =
      //           RegisterDetailInfo(user);
      //       BlocProvider.of<RegisterBloc>(context)
      //           .add(registerDetailInfo);
      //     },
      //     child: const Text("Register")
      //     );
    }));
  }
}
