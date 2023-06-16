import 'package:dmfsse/src/bloc/user/user_bloc.dart';
import 'package:dmfsse/src/bloc/user/user_state.dart';
import 'package:dmfsse/src/models/login_info.dart';
import 'package:dmfsse/src/models/user.dart';
import 'package:dmfsse/src/screens/common/widget/product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../local_storage/user_preference.dart';
import '../../../bloc/product/product_event.dart';
import '../../../bloc/user/user_event.dart';
import '../../customer/customer_homepage.dart';

class UserProfileUpdate extends StatefulWidget {
  final LoggedInUserInfo loggedInUserInfo;
  const UserProfileUpdate({required this.loggedInUserInfo, super.key});

  @override
  State<UserProfileUpdate> createState() => _UserProfileUpdateState();
}

class _UserProfileUpdateState extends State<UserProfileUpdate> {
   
 

  final formKey = GlobalKey<FormState>();
  bool isUpdate = false;
  Map<String, dynamic> userBody = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 15, 23, 43),
          title: const Text(
            "Update Profle",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          color: const Color.fromARGB(255, 15, 23, 43),
          width: double.infinity,
          height: double.infinity,
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
                    listener: ((context, state) {
                      if (state is UpdateSucess) {
                     LoggedInUserInfo loggedInUserInfo =    LoggedInUserInfo(widget.loggedInUserInfo.id, widget.loggedInUserInfo.accessToken, userBody['firstName'], userBody['lastName'], widget.loggedInUserInfo.email, userBody['phoneNumber'], widget.loggedInUserInfo.profilePicture, widget.loggedInUserInfo.identifictionPicture,widget.loggedInUserInfo.roles, widget.loggedInUserInfo.verified);
                        UserPreference userPreference = UserPreference();
                        userPreference.storeUserInformation(loggedInUserInfo);
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CustomerHomepage()));
                      }
                      if (state is GetUserInfoFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Failed to update profle")));
                      }
                    }),
                    builder: ((context, state) {
                      if (state is GetUserInfoInitial) {
                        isUpdate = true;
                      } else {
                        isUpdate = false;
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "First Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 15, 23, 43)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //  InputTextFormField(),
                                ProductTextFormField(
                                  onSaved: (value) {
                                    userBody['firstName'] = value;
                                  },
                                  initialValue:
                                      widget.loggedInUserInfo.firstName,
                                  onChanged: (String value) {},
                                  keyboardType: TextInputType.text,
                                  errorMessage: "First Name",
                                  obscureText: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter first  name";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Last Name ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 15, 23, 43)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //  InputTextFormField(),
                                ProductTextFormField(
                                  onSaved: (value) {
                                    userBody['lastName'] = value;
                                  },
                                  initialValue:
                                      widget.loggedInUserInfo.lastName,
                                  onChanged: (String value) {},
                                  keyboardType: TextInputType.text,
                                  errorMessage: "last  Name",
                                  obscureText: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter last   name";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const Text(
                                  "Phone Number",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 15, 23, 43)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //  InputTextFormField(),
                                ProductTextFormField(
                                  onSaved: (value) {
                                    userBody['phoneNumber'] = value;
                                  },
                                  initialValue: widget
                                      .loggedInUserInfo.phoneNumber
                                      .toString(),
                                  onChanged: (String value) {},
                                  keyboardType: TextInputType.number,
                                  errorMessage: "phone number",
                                  obscureText: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter phone number";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),

                                const SizedBox(
                                  height: 10,
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
                                          print("Update button tapped");
                                          ProfileUpdate profileUpdate =
                                              ProfileUpdate(
                                                  id: widget.loggedInUserInfo.id,
                                                  firstName:
                                                      userBody['firstName'],
                                                  lastName:
                                                      userBody['lastName'],
                                                  phoneNumber:
                                                      userBody['phoneNumber']);
                                                   UpdateUserEvent updateProfile = UpdateUserEvent(id: profileUpdate);
                                           BlocProvider.of<UserBloc>(context)
                                              .add(updateProfile);   
                                          //  LoggedInUserInfo(

                                          //   // id: widget.product.id,
                                          //   // name: productBody['name'],
                                          //   //  price: int.parse(productBody['price']),
                                          //   //  description: productBody['description'],
                                          //   //  amount: int.parse(productBody['amount']),
                                          //   //  photo: widget.product.photo,
                                          //   //  soldout: widget.product.soldout,

                                          //    );
                                          // UpdateProduct updateProduct = UpdateProduct(product);
                                          //  BlocProvider.of<ProductBloc>(context)
                                          //     .add(updateProduct);
                                        }
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromARGB(
                                                      255, 15, 23, 43)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ))),
                                      child: isUpdate
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : const Text("Update Product")),
                                ),
                              ],
                            )),
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ));
    // return
    // Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: const Color.fromARGB(255, 15, 23, 43),
    //     title: const Center(child: Text("Profile")),
    //     actions: [
    //       TextButton(
    //           onPressed: () {
    //             print("profile update button clicked");
    //           },
    //           child: const Text(
    //             "Edit",
    //             style: TextStyle(color: Colors.white, fontSize: 24),
    //           )),
    //       const SizedBox(
    //         width: 10,
    //       )
    //     ],
    //   ),
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         const Text(
    //           "Name",
    //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         //  InputTextFormField(),
    //         ProductTextFormField(
    //           onSaved: (value) {
    //             _userBody['name'] = value;
    //           },
    //           initialValue:
    //               '${widget.loggedInUserInfo.firstName} ${widget.loggedInUserInfo.lastName}',
    //           onChanged: (String value) {},
    //           keyboardType: TextInputType.text,
    //           errorMessage: "Product Name",
    //           obscureText: false,
    //           validator: (value) {
    //             if (value!.isEmpty) {
    //               return "Enter Full  Name";
    //             } else {
    //               return null;
    //             }
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
