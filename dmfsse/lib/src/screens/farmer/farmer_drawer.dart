

import 'package:flutter/material.dart';

class FarmerDrawer extends StatefulWidget {
  const FarmerDrawer({super.key});

  @override
  State<FarmerDrawer> createState() => _FarmerDrawerState();
}

class _FarmerDrawerState extends State<FarmerDrawer> {

  
  @override
  Widget build(BuildContext context) {
    return   ListView(
         padding: EdgeInsets.zero,
         
         children: [
            const UserAccountsDrawerHeader(
              accountName:  Text("Solomon Kassahun",style: TextStyle(color: Colors.white),), 
              accountEmail:   Text("+251986557047",style: TextStyle(color: Colors.white)),
              currentAccountPicture:  CircleAvatar(
                backgroundImage: AssetImage('assets/images/drawerPP.jpg'),
                
                ),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                 
                ),
           
              )
          ,
             ListTile(
              title: const Text('Homepage'),
              leading:const Icon(Icons.home),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            Divider(height: 10, color: Colors.white.withOpacity(0.6)),
             ListTile(
              title: const Text('Settings'),
              leading:const Icon(Icons.settings),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            Divider(height: 10, color: Colors.white.withOpacity(0.6)),
          
             ListTile(
              title: const Text('Homepage'),
              leading:const Icon(Icons.home),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            Divider(height: 20, color: Colors.white.withOpacity(0.6)),
             ListTile(
              title: const Text('Settings'),
              leading:const Icon(Icons.settings),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
             SizedBox(height: MediaQuery.of(context).size.height * 0.23),
            Divider(height: 20, color: Colors.white.withOpacity(0.6)),
            Container(
               alignment: Alignment.bottomCenter,
               child:  ListTile(
              title: const Text('Log out'),
              leading:const Icon(Icons.logout),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            )
         ],

      );
  }
}