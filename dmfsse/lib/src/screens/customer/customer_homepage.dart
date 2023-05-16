import 'package:dmfsse/src/screens/customer/customer_deals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/product_bloc.dart';
import '../../bloc/product/product_event.dart';
import '../common/widget/list_of_product.dart';
import '../common/widget/message.dart';

import 'customer_dashboard.dart';
import 'customer_drawer.dart';

class CustomerHomepage extends StatefulWidget {
  static const routeName = '/customerHomepage';
  const CustomerHomepage({Key? key}) : super(key: key);

  @override
  State<CustomerHomepage> createState() => _CustomerHomepageState();
}

class _CustomerHomepageState extends State<CustomerHomepage> {
  int selectedIndex = 0;
  getSelectedWidget(int index) {
    switch (index) {
      case 0:
        return const CustomerDashboard();
      case 1:
        return const CustomerDeals();
      case 2:
        return const MessageRoom();
      default:
        return const ListOfProduct();
    }
  }

  void _onItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     BlocProvider.of<ProductBloc>(context).add(FetchAllProduct());
    return Scaffold(
      
      appBar: AppBar(),
      drawer: const Drawer(
        child: CustomerDrawer(),
      ),
      body: getSelectedWidget(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: "Shop"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message")
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemSelected,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
