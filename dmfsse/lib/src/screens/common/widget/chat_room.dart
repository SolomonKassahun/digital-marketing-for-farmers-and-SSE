import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../models/message.dart';
import '../../../service/firebase_service.dart';

class ChatRoom extends StatefulWidget {
  MessageInfo message;
  ChatRoom({required this.message, super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String? imageUrl;
  TextEditingController messageConroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            (widget.message.profilePicture == null)
                ? const Icon(Icons.person)
                : FutureBuilder(
                    future: FirebaseTaskManager.getImage(
                        widget.message.profilePicture.toString(),
                        '/ProfilePictures',
                        15),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Icon(
                            Icons.person,
                            size: 40,
                          );
                        }
                        if (snapshot.hasData) {
                          imageUrl = snapshot.data as String;
                          return CachedNetworkImage(
                            fit: BoxFit.fill,
                            height: 40.0,

                            width: 40,

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
                              color: Colors.black,
                            )),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.person),
                          );
                        }
                      }
                      return const SpinKitCircle(
                        color: Colors.blue,
                      );
                    })),
            const SizedBox(
              width: 15,
            ),
            Text("${widget.message.firstName} ${widget.message.lastName}"),
          ],
        ),
      ),
      body: Center(),
    );
  }
}
