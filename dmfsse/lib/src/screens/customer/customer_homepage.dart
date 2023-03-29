import 'package:dmfsse/src/screens/customer/customer_deals.dart';
import 'package:dmfsse/src/screens/customer/customer_message.dart';
import 'package:flutter/material.dart';

import 'customer_drawer.dart';

class CustomerHomepage extends StatefulWidget {
  const CustomerHomepage({Key? key}) : super(key: key);

  @override
  State<CustomerHomepage> createState() => _CustomerHomepageState();
}

class _CustomerHomepageState extends State<CustomerHomepage> {
  int selectedIndex  = 0;
  getSelectedWidget(int index){
    switch (index) {
      case 0:
         return const CustomerHomepage();
      case 1:
         return const CustomerDeals();
      case 3:
        return const CustomerMessage();
      default:
        return const CustomerHomepage();
    }
     }
     void _onItemSelected(int index){
       setState(() {
         selectedIndex = index;
       });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("customer homepage"),
      ),
      drawer:const  Drawer(
        child:  CustomerDrawer(),
      ),
      body: getSelectedWidget(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items:const  <BottomNavigationBarItem> [
            BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop),
              label: "Shop"
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: "Message"
              )
                
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemSelected,
        unselectedItemColor: Colors.black,
        ),
    );
  }

  

}