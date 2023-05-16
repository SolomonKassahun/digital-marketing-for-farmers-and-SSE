import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../models/login_info.dart';

class UserProfile extends StatelessWidget {
  final LoggedInUserInfo loggedInUserInfo;
  const UserProfile({required this.loggedInUserInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(child: Text("Profile")),
        actions: [
          TextButton(
              onPressed: () {
                print("profile update button clicked");
              },
              child: const Text(
                "Edit",
                style: TextStyle(color: Colors.white, fontSize: 24),
              )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              color: const Color.fromRGBO(33, 150, 243, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(children: [
                    CachedNetworkImage(
                      fit: BoxFit.fill,
                      height: 160.0,
                      width: MediaQuery.of(context).size.width,
                      imageUrl:
                          loggedInUserInfo.profilePicture.toString(),
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
                    const Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Full Name',
                    style: TextStyle(color: Colors.white60),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(loggedInUserInfo.firstName),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 5,
                  ),
                  const Text(
                    'Phone',
                    style: TextStyle(color: Colors.white60),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(loggedInUserInfo.phoneNumber),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 5,
                  ),
                  const Text(
                    'Full Name',
                    style: TextStyle(color: Colors.white60),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(loggedInUserInfo.firstName),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 5,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
