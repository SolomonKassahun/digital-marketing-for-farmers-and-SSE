import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/Register/register_bloc.dart';
import '../../../bloc/Register/register_event.dart';
import '../../../bloc/Register/register_state.dart';
import '../../../models/user_registeration_info.dart';
import '../../login_screen.dart';
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
  bool isRegister = false;
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<RegisterBloc, RegisterState>(
            listener: ((context, state) {
      if (state is RegisterInitial) {
        isRegister = true;
      }
      if (state is RegistrationSucess) {
        Navigator.pushNamed(context, LoginScreen.routeName);
      }
      if (state is RegistraionFailure) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'Failed to create register',
          desc: 'Fill all the information carefully!',
          btnCancelOnPress: () {
            Navigator.pop(context);
          },
          btnOkOnPress: () {
            Navigator.pop(context);
          },
        ).show();
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
                      fontWeight: FontWeight.bold, color: Color.fromARGB(255, 15, 23, 43)),
                ),
                const SizedBox(height: 10,),
                //  InputTextFormField(),
                InputTextFormField(
                  hintTxt: 'New Password',
                  controller: passwordController,
                  isRequired: false,
                  onChanged: (String value) {},
                  keyboardType: TextInputType.text,
                  errorMessage: "password",
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
                  height: 10,
                ),
                const Text(
                  "Confirm Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color.fromARGB(255, 15, 23, 43)),
                ),
                 const SizedBox(
                  height: 10,
                ),
                //  InputTextFormField(),
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
                const Text(
                  "Add Profile Photo",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color.fromARGB(255, 15, 23, 43)),
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
                      fontWeight: FontWeight.bold, color: Color.fromARGB(255, 15, 23, 43)),
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
                                MaterialStateProperty.all(const Color.fromARGB(255, 15, 23, 43)),
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
                          if ((formKey.currentState!.validate()) &&
                              (passwordController.text.toString() ==
                                  confirmPasswordController.text.toString())) {
                            UserRegisterationInfo user =
                                UserRegisterationInfo();

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
                        child: isRegister
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Register")),
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
