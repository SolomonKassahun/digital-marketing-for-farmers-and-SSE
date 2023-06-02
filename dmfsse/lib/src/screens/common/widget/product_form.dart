import 'package:flutter/material.dart';

class ProductTextFormField extends StatelessWidget {
 
  final Function onChanged;
  final Function validator;
    final Function(String value) onSaved;

  final TextInputType keyboardType;
  final String errorMessage;
  final bool obscureText;
  final String initialValue;
  const ProductTextFormField({
    required this.validator,
   required this.onSaved,
    required this.keyboardType,
    required this.onChanged,
   
    required this.errorMessage,
    required this.obscureText,
    required this.initialValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        onTap: () {},
        keyboardType: keyboardType,
        onEditingComplete: () => FocusScope.of(context).unfocus(),
        style:const  TextStyle(fontSize: 18, color:  Color.fromARGB(255, 15, 23, 43)),
        onChanged: (value) => onChanged(value.toString()),
        initialValue: initialValue,
        obscureText: obscureText,
        onSaved: (value){
          onSaved(value!);
        },
        validator: (value) => validator(value.toString()),
        // {
        //   // if (value!.isEmpty) {
        //   //   return "enter $value";
        //   // } else {
        //   //   return null;
        //   // }
        // },
        decoration: InputDecoration(
        

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
          
          errorStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          // errorMaxLines: 1,
        ),

        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return "Enter $errorMessage";
        //   } else {
        //     return null;
        //   }
        // },
      ),
    );
  }
}
