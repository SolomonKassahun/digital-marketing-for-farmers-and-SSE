import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';

class SearchFilterButton extends StatelessWidget {
  final TextEditingController searchController;
  final void Function(String)? onChanged;

  const SearchFilterButton(
      {required this.searchController, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: TextFormField(
        controller: searchController,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Color.fromARGB(255, 112, 110, 110)),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey.shade600,
            size: 20,
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 228, 225, 225),
          contentPadding: const EdgeInsets.all(8),
          hintText:LocaleKeys.searchText.tr(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 228, 225, 225))),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 228, 225, 225))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 228, 225, 225))),
        ),
      ),
    );
  }
}
