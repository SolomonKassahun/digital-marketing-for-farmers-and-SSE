import 'package:flutter/material.dart';

class InputTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintTxt;
  final Function onChanged;
  final bool isRequired;
  final bool? isPassword;
  final Function(bool isObscured)? isObscured;
  final TextInputType keyboardType;
  final String errorMessage;
  final bool obscureText;
  const InputTextFormField({
    required this.controller,
    required this.hintTxt,
    required this.keyboardType,
    required this.onChanged,
    required this.isRequired,
    this.isPassword,
    this.isObscured,
    required this.errorMessage,
    required this.obscureText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        onTap: () {},
        keyboardType: keyboardType,
        controller: controller,
        onEditingComplete: () => FocusScope.of(context).unfocus(),
        style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
        onChanged: (value) => onChanged(value.toString()),
        obscureText: obscureText,

        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return "enter $value";
        //   } else {
        //     return null;
        //   }
        // },
        decoration: InputDecoration(
          labelText: hintTxt,

          contentPadding: const EdgeInsets.only(
            top: 6,
            bottom: 6,
            left: 12,
          ),
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          suffixIcon: isPassword != null
              ? IconButton(
                  onPressed: () {
                    isObscured!(obscureText);
                  },
                  icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off))
              : null,
          errorStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          // errorMaxLines: 1,
        ),

        validator: (value) {
          if (value!.isEmpty) {
            return "Enter $errorMessage";
          } else {
            return null;
          }
        },
      ),
    );
  }
}
