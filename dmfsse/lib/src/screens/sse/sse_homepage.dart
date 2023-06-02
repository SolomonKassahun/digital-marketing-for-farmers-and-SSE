import 'package:dmfsse/src/screens/common/widget/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/product_bloc.dart';
import '../../bloc/product/product_event.dart';
import '../customer/customer_dashboard.dart';
import '../customer/customer_drawer.dart';
import '../farmer/add_product.dart';
import '../farmer/farmer_offer.dart';
import 'sse_deals.dart';
import 'sse_drawer.dart';

class SseHomepage extends StatefulWidget {
  static const routeName = '/sse_homepage';
  const SseHomepage({super.key});

  @override
  State<SseHomepage> createState() => _SseHomepageState();
}

class _SseHomepageState extends State<SseHomepage> {
  int selectedIndex = 0;
  getItemWidget(int index) {
    switch (index) {
      case 0:
        return const CustomerDashboard();
      case 1:
        return const AddProductPage();
      case 2:
        return const FarmerOffer();
      case 3:
        return const MessageRoom();
      default:
        return const SseHomepage();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(FetchAllProduct());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 23, 43),
      ),
      drawer: const Drawer(
        child: CustomerDrawer(),
      ),
       body: getItemWidget(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: "Product"),
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart,),label: "Offer"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
        ],
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
