import 'package:dmfsse/src/models/login_info.dart';
import 'package:dmfsse/src/screens/common/widget/product_form.dart';
import 'package:flutter/material.dart';

class UserProfileUpdate extends StatefulWidget {
  final LoggedInUserInfo loggedInUserInfo;
  const UserProfileUpdate({required this.loggedInUserInfo, super.key});

  @override
  State<UserProfileUpdate> createState() => _UserProfileUpdateState();
}

class _UserProfileUpdateState extends State<UserProfileUpdate> {
  Map<String, dynamic> _userBody = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(child: Text("Profile")),
        actions: [
          TextButton(
              onPressed: () {
                print("profile update button clicked");
              },
              child: const Text(
                "Edit",
                style: TextStyle(color: Colors.white, fontSize: 24),
              )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Name",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(
              height: 10,
            ),
            //  InputTextFormField(),
            ProductTextFormField(
              onSaved: (value) {
                _userBody['name'] = value;
              },
              initialValue:
                  '${widget.loggedInUserInfo.firstName} ${widget.loggedInUserInfo.lastName}',
              onChanged: (String value) {},
              keyboardType: TextInputType.text,
              errorMessage: "Product Name",
              obscureText: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Full  Name";
                } else {
                  return null;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
