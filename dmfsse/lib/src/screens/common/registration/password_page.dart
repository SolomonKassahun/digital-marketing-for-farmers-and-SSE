import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/Register/register_bloc.dart';
import '../../../bloc/Register/register_event.dart';
import '../../../bloc/Register/register_state.dart';
import '../../../models/user.dart';
import '../widget/input_field.dart';
import '../widget/upload_image.dart';

class PasswordPage extends StatefulWidget {
  static String routeName = '/password_page';
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController profilePhotoController = TextEditingController();
  TextEditingController identificationPhotoController = TextEditingController();
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
                          child: BlocConsumer<RegisterBloc, RegisterState>(
                              listener: ((context, state) {
                            if (state is RegisterInitial) {
                              const CircularProgressIndicator(
                                color: Colors.white,
                              );
                            } else if (state is RegistrationSucess) {
                              Navigator.pushNamed(context, 'login');
                            }
                          }), builder: (BuildContext context, state) {
                            return   SingleChildScrollView(
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
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                //  InputTextFormField(),
                InputTextFormField(
                  hintTxt: 'New Password',
                  controller: passwordController,
                  isRequired: false,
                  onChanged: (String value) {},
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Confirm Password",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                //  InputTextFormField(),
                InputTextFormField(
                  hintTxt: 'Confirm New Password',
                  controller: passwordController,
                  isRequired: false,
                  onChanged: (String value) {},
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Add Profile Photo",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
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
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
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
                                  backgroundColor:MaterialStateProperty.all(Colors.blue),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),
                                    )
                                  )
                                      
                                    
                                ),
                            onPressed: (){
                                User user = User();
                                  user.username = "Mukera 1 2 2";
                                  user.firstName = "Name 2";
                                  user.lastName = "Name 2";
                                  user.password = "Name 2";
                                  user.role = "Name 2";
                                  RegisterDetailInfo registerDetailInfo =
                                      RegisterDetailInfo(user);
                                  BlocProvider.of<RegisterBloc>(context)
                                      .add(registerDetailInfo);
                               print("clicked");
                            }, 
                            child: const Text("Register")
                            ),
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
                          }),
                        )
    
    );
  }
}
