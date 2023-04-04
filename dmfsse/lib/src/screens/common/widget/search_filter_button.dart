import 'package:flutter/material.dart';

class SearchFilterButton extends StatelessWidget {
  final TextEditingController searchController;
  final void Function(String)? onChanged;

  const SearchFilterButton(
      {required this.searchController, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      onChanged: onChanged,
      decoration: const InputDecoration(
          hintText: "Search product",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    );
  }
}
