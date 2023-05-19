import 'package:dmfsse/src/screens/farmer/add_product.dart';
import 'package:dmfsse/src/screens/farmer/farmer_product_list.dart';
import 'package:dmfsse/src/screens/farmer/training.dart';
import 'package:dmfsse/src/screens/common/widget/message.dart';
import 'package:dmfsse/src/screens/farmer/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/product_bloc.dart';
import '../../bloc/product/product_event.dart';
import 'farmer_dashboard.dart';
import 'farmer_drawer.dart';
import 'farmer_offer.dart';

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
        return const FarmerDashboard();
      case 1:
        return const AddProductPage();
      case 2:
        return const FarmerOffer();
      case 3:
        return const MessageRoom();
      case 4:
        return const Education();
      default:
        return const ProductList();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(FetchAllProduct());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const Drawer(child: FarmerDrawer()),
      body: _getItemWidget(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const  <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: "Product"),
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart,),label: "Offer"),
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
