import 'package:cached_network_image/cached_network_image.dart';
import 'package:dmfsse/src/bloc/user/user_state.dart';
import 'package:dmfsse/src/screens/homepage_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../local_storage/user_preference.dart';
import '../../bloc/user/user_bloc.dart';
import '../../models/login_info.dart';
import '../common/widget/about_page.dart';
import '../common/widget/faq.dart';
import '../common/widget/help.dart';
import '../common/widget/help_page.dart';
import '../common/widget/settings.dart';
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
            currentAccountPicture: CachedNetworkImage(
                        fit: BoxFit.fill,
                        height: 200.0,
                        width: MediaQuery.of(context).size.width,
                        imageUrl: loggedInUserInfo!.profilePicture.toString(),
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
                      ),
            decoration: const BoxDecoration(
              color:  Color.fromARGB(255, 15, 23, 43),
            ),
          ),
          ListTile(
            title:  Text(LocaleKeys.homeText.tr()),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(height: 10, color: Colors.white.withOpacity(0.6)),
          ListTile(
            title:  Text(LocaleKeys.profileText.tr()),
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
            title:  Text(LocaleKeys.faqText.tr()),
             leading: const Icon(Icons.help),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => const  FAQPage())));
            },
          ),
          Divider(height: 10, color: Colors.white.withOpacity(0.6)),
          ListTile(
            title:  Text(LocaleKeys.aboutUsText.tr()),
            leading: const Icon(Icons.add_location),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => const  AboutUsPage())));
            },
          ),
         
          Divider(height: 10, color: Colors.white.withOpacity(0.6)),
         
          ListTile(
            title:  Text(LocaleKeys.settingsText.tr()),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => const SettingsPage())));
            },
          ),
           Divider(height: 10, color: Colors.white.withOpacity(0.6)),
          ListTile(
            title:  Text(LocaleKeys.settingsText.tr()),
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
              title:  Text(LocaleKeys.logOutText.tr()),
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
