import 'package:flutter/material.dart';

class RolesDropDown extends StatefulWidget {
  final ValueChanged<String> changeRole;
  const RolesDropDown({required this.changeRole, super.key});

  @override
  State<RolesDropDown> createState() => _RolesDropDownState();
}

class _RolesDropDownState extends State<RolesDropDown> {
  String dropdownValue = 'Customer';
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          //<-- SEE HERE
          borderSide: BorderSide(color: Colors.black12, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          //<-- SEE HERE
          borderSide: BorderSide(color: Colors.black12, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      dropdownColor: Colors.white,
      value: dropdownValue,
      onChanged: (value) {
        setState(() {
          dropdownValue = value.toString();
          widget.changeRole(value.toString());
        });
      },
      items: <String>['Customer', 'Farmer', 'SSE']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        );
      }).toList(),
    );
  }
}
