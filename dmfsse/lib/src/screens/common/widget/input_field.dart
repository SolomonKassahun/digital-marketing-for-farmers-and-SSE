import 'package:flutter/material.dart';

class InputTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintTxt;
  final Function onChanged;
  final bool isRequired;
  final TextInputType keyboardType;

  InputTextFormField(
      {required this.controller,
      required this.hintTxt,
      required this.keyboardType,
      required this.onChanged,
      required this.isRequired,
      super.key});

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
          onChanged: (value) => this.onChanged(value.toString()),
          decoration: InputDecoration(
              labelText: hintTxt,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              //fillColor: Colors.green

              contentPadding: const EdgeInsets.only(
                top: 6,
                bottom: 6,
                left: 12,
              ),
              // border: InputBorder.none,
              // prefixText: '${this.textFieldName}',
              suffixIcon: Container(
                width: 2,
                child: Center(
                  child: isRequired
                      ? const Text(
                          '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      : const Text(''),
                ),
              ))),
    );
  }
}