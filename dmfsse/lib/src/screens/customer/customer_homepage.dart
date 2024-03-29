import 'package:dmfsse/src/screens/customer/customer_deals.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/locale_keys.g.dart';
import '../../bloc/product/product_bloc.dart';
import '../../bloc/product/product_event.dart';
import '../common/widget/list_of_product.dart';
import '../common/widget/message.dart';

import 'customer_dashboard.dart';
import 'customer_drawer.dart';
import 'customer_offer.dart';

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
        return const CustomerOffer();
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
      
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 23, 43),
      ),
      drawer: const Drawer(
        child: CustomerDrawer(),
      ),
      body: getSelectedWidget(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon:const Icon(Icons.home), label: LocaleKeys.homeText.tr()),
           BottomNavigationBarItem(icon: const Icon(Icons.shop), label: LocaleKeys.yourOfferText.tr()),
          BottomNavigationBarItem(icon: const Icon(Icons.message), label: LocaleKeys.messageText.tr())
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemSelected,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
