import 'package:cached_network_image/cached_network_image.dart';
import 'package:dmfsse/src/bloc/user/user_state.dart';
import 'package:dmfsse/src/screens/homepage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../local_storage/user_preference.dart';
import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_event.dart';
import '../../models/login_info.dart';
import '../../service/firebase_service.dart';

class FarmerDrawer extends StatefulWidget {
  const FarmerDrawer({super.key});

  @override
  State<FarmerDrawer> createState() => _FarmerDrawerState();
}

class _FarmerDrawerState extends State<FarmerDrawer> {
  LoggedInUserInfo? loggedInUserInfo;
  String? imageUrl;

  getUsers() {
    UserPreference userPreference = UserPreference();
    userPreference.getUserInformation().then((value) {
      setState(() {
        loggedInUserInfo = value as LoggedInUserInfo;
      });
    });
  }

  @override
  void initState() {
    getUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(GetUserInfoEvent(
        id: (loggedInUserInfo != null) ? loggedInUserInfo!.id.toString() : ""));
    // BlocProvider.of<UserBloc>(context)
    //     .add(GetUserInfoEvent(id: loggedInUserInfo!.id.toString()));
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserUpdateSucess) {
        loggedInUserInfo = state.user as LoggedInUserInfo;
      }
      return ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              // ignore: unnecessary_null_comparison
              (loggedInUserInfo != null)
                  ? "${loggedInUserInfo!.firstName.toString()} ${loggedInUserInfo!.firstName.toString()}"
                  : "",
              style: const TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
                (loggedInUserInfo != null)
                    ? "+251${loggedInUserInfo!.phoneNumber.toString().substring(1)}"
                    : "+251",
                style: const TextStyle(color: Colors.white)),
            currentAccountPicture: FutureBuilder(
                future: FirebaseTaskManager.getImage(
                    (loggedInUserInfo != null)
                        ? loggedInUserInfo!.profilePicture.toString()
                        : "ProfilePictures/Screenshot_20230421-071626_Lite.jpg",
                    'ProfilePictures',
                    15),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      imageUrl = snapshot.data as String;
                      return CachedNetworkImage(
                        fit: BoxFit.fill,
                        height: 200.0,
                        width: MediaQuery.of(context).size.width,
                        imageUrl: snapshot.data.toString(),
                        // imageUrl: snapshot.data,
                        imageBuilder: (context, imageProvider) => Container(
                          width: MediaQuery.of(context).size.width * 4,
                          height: MediaQuery.of(context).size.height * 4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => const Center(
                            child: SpinKitCircle(
                          color: Colors.white,
                        )),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      );
                    }
                  }
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return Column(
                  //     children: const [
                  //       Text("Loading ..."),
                  //       Expanded(
                  //           child: SpinKitCircle(
                  //         color: Colors.black,
                  //       )),
                  //     ],
                  //   );
                  // }

                  return const Center(
                      child: SpinKitCircle(
                    color: Colors.white,
                  ));
                })),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
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
              Navigator.pop(context);
            },
          ),
          Divider(height: 10, color: Colors.white.withOpacity(0.6)),
          ListTile(
            title: const Text('Homepage'),
            leading: const Icon(Icons.home),
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
            leading: const Icon(Icons.settings),
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
