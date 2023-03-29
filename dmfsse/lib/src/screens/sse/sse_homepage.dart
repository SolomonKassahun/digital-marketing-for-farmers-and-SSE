
import 'package:dmfsse/src/screens/sse/sse_message.dart';
import 'package:flutter/material.dart';

import 'sse_deals.dart';

class SseHomepage extends StatefulWidget {
  const SseHomepage({super.key});

  @override
  State<SseHomepage> createState() => _SseHomepageState();
}

class _SseHomepageState extends State<SseHomepage> {
  int selectedIndex = 0;
  getItemWidget(int index){
    switch (index) {
      case 0:
        return const SseHomepage();
      case 1:
          return const SseDeals();
      case 2:
          return const SseMessage();
      default:
           return const SseHomepage();
    }
  }
   void _onItemTapped(int index){
      setState(() {
        selectedIndex = index;
      });
    }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const  Text("Homepage"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:const  <BottomNavigationBarItem>[ 
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

        ] ,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}