import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dmfsse/generated/locale_keys.g.dart';

class SearchFilterButton extends StatelessWidget {
  final TextEditingController searchController;
  final void Function(String)? onChanged;

  const SearchFilterButton(
      {required this.searchController, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      child: TextFormField(
        controller: searchController,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: LocaleKeys.searchText.tr(),
            prefixIcon: const Icon(Icons.search),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ),
    );
  }
}
