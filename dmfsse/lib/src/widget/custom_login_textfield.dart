
import 'package:flutter/material.dart';

class CustomLoginTextField extends StatelessWidget {
  final String textFieldName;
  final TextEditingController controller;
  final IconData icon;
  final Function validator;
  final bool obsecureText;
  final TextInputType keyboardType;
  final bool? isPassword;
  final bool? isDisabled;
  final Function(bool isObscured)? isObscured;
  final String? errorMessage;

  // ignore: use_key_in_widget_constructors
  const CustomLoginTextField({
    this.isObscured,
    this.isPassword,
    required this.keyboardType,
    required this.textFieldName,
    required this.controller,
    required this.icon,
    required this.validator,
    required this.obsecureText,
    required this.isDisabled,
    required this.errorMessage
  });

  @override
  Widget build(BuildContext context) {
    
   
    return Material(
      color: Colors.white,
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText,
        keyboardType: keyboardType,
        enabled: isDisabled,
        
        textInputAction: TextInputAction.done,
        onEditingComplete: () => FocusScope.of(context).unfocus(),
        style: const TextStyle(fontSize: 18, color: Colors.grey),
        
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 14),
          prefixIcon: Icon(icon),
          border: InputBorder.none,
        
          suffixIcon: isPassword != null
              ? IconButton(
                  onPressed: () {
                    isObscured!(obsecureText);
                  },
                  icon: Icon(
                      obsecureText ? Icons.visibility : Icons.visibility_off))
              : null,
          hintText: textFieldName,
          errorStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            textBaseline: TextBaseline.alphabetic,
          ),
          errorMaxLines: 1,
        ),
       validator: (values){
        if(values == null || values.isEmpty){
          return 'please enter $errorMessage';
        }
       },
      ),
    );
  }
}