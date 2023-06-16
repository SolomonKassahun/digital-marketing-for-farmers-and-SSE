import 'package:dmfsse/src/screens/farmer/add_product.dart';
import 'package:dmfsse/src/screens/farmer/farmer_product_list.dart';
import 'package:dmfsse/src/screens/farmer/training.dart';
import 'package:dmfsse/src/screens/common/widget/message.dart';
import 'package:dmfsse/src/screens/farmer/product_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/locale_keys.g.dart';
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
        backgroundColor: const Color.fromARGB(255, 15, 23, 43),
      ),
      drawer: const Drawer(child: FarmerDrawer()),
      body: _getItemWidget(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items:   <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon:const  Icon(Icons.home), label: LocaleKeys.homeText.tr()),
          BottomNavigationBarItem(icon: const Icon(Icons.post_add), label: LocaleKeys.addProductText.tr()),
          BottomNavigationBarItem(icon: const Icon(Icons.add_shopping_cart,),label: LocaleKeys.offerText.tr()),
          BottomNavigationBarItem(icon: const Icon(Icons.message), label: LocaleKeys.messageText.tr()),
          BottomNavigationBarItem(
              icon: const Icon(Icons.cast_for_education), label: LocaleKeys.courseText.tr()),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
