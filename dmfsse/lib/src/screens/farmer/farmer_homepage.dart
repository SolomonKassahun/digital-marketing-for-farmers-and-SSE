import 'package:dmfsse/src/screens/farmer/add_product.dart';
import 'package:dmfsse/src/screens/farmer/education.dart';
import 'package:dmfsse/src/screens/farmer/message.dart';
import 'package:dmfsse/src/screens/farmer/product_list.dart';
import 'package:flutter/material.dart';

import 'farmer_drawer.dart';

class FarmerHomepage extends StatefulWidget {
  static const routeName = '/farmerHomepage';
  const FarmerHomepage({super.key});

  @override
  State<FarmerHomepage> createState() => _FarmerHomepageState();
}

class _FarmerHomepageState extends State<FarmerHomepage> {
  int selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  _getItemWidget(int index) {
    switch (index) {
      case 0:
        return const ProductList();
      case 1:
        return const AddProductPage();
      case 2:
        return const FarmerChat();
      case 3:
        return const Education();
      default:
        return const ProductList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const Drawer(child: FarmerDrawer()),
      body: _getItemWidget(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: "Product"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
          BottomNavigationBarItem(
              icon: Icon(Icons.cast_for_education), label: "Course"),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
