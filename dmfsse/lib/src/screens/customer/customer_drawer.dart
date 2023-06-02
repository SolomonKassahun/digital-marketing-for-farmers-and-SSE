import 'package:dmfsse/src/bloc/user/user_state.dart';
import 'package:dmfsse/src/screens/homepage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../../local_storage/user_preference.dart';
import '../../bloc/user/user_bloc.dart';
import '../../models/login_info.dart';
import '../common/widget/help.dart';
import '../common/widget/user_profile.dart';

class CustomerDrawer extends StatefulWidget {
  const CustomerDrawer({super.key});

  @override
  State<CustomerDrawer> createState() => _CustomerDrawerState();
}

class _CustomerDrawerState extends State<CustomerDrawer> {
  LoggedInUserInfo? loggedInUserInfo;

  getUsers() {
    UserPreference userPreference = UserPreference();
    userPreference.getUserInformation().then((value) {
      setState(() {
        loggedInUserInfo = value;
      });
    });
  }
  void shareApp() async{
  String appLink = 'https://digital-marketing-for-farmers-and-sse.onrender.com/';
    await FlutterShare.share(title: "Share app",linkUrl: appLink);
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserUpdateSucess) {
        loggedInUserInfo = state.user as LoggedInUserInfo?;
      }
      return ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              (loggedInUserInfo != null)
                  ? "${loggedInUserInfo!.firstName.toString()} ${loggedInUserInfo!.lastName.toString()}"
                  : "",
              style: const TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
                (loggedInUserInfo != null)
                    ? "+251${loggedInUserInfo!.phoneNumber.toString().substring(1)}"
                    : "+251",
                style: const TextStyle(color: Colors.white)),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/drawerPP.jpg'),
            ),
            decoration: const BoxDecoration(
              color:  Color.fromARGB(255, 15, 23, 43),
            ),
          ),
          ListTile(
            title: const Text('Homepage'),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(height: 10, color: Colors.white.withOpacity(0.6)),
          ListTile(
            title: const Text('Profile'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => UserProfile(
                            loggedInUserInfo:
                                loggedInUserInfo as LoggedInUserInfo,
                          ))));
            },
          ),
          
          Divider(height: 10, color: Colors.white.withOpacity(0.6)),
          ListTile(
            title: const Text('Contact Us '),
            leading: const Icon(Icons.contact_page),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(height: 10, color: Colors.white.withOpacity(0.6)),
          ListTile(
            title: const Text('About '),
            leading: const Icon(Icons.add_location),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(height: 10, color: Colors.white.withOpacity(0.6)),
          ListTile(
            title: const Text('Help'),
            leading: const Icon(Icons.help),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const Help())));
            },
          ),
          Divider(height: 10, color: Colors.white.withOpacity(0.6)),
         
          ListTile(
            title: const Text('Settings'),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
            },
          ),
           Divider(height: 10, color: Colors.white.withOpacity(0.6)),
          ListTile(
            title: const Text('Share '),
            leading: const Icon(Icons.share),
            onTap: () {
              shareApp();
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          // Divider(height: 20, color: Colors.white.withOpacity(0.6)),
          Container(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              title: const Text('Log out'),
              leading: const Icon(Icons.logout),
              onTap: () {
                UserPreference userPreference = UserPreference();
                userPreference.removeUserInformation();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                    (route) => false);
              },
            ),
          )
        ],
      );
    });
  }
}
