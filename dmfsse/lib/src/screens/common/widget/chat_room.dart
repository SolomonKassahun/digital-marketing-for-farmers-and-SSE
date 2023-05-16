import 'package:cached_network_image/cached_network_image.dart';
import 'package:dmfsse/src/bloc/message/message_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../local_storage/user_preference.dart';
import '../../../bloc/message/message_bloc.dart';
import '../../../bloc/message/message_event.dart';
import '../../../models/message.dart';
import '../../../models/message_list.dart';
import '../../../service/firebase_service.dart';

// ignore: must_be_immutable
class ChatRoom extends StatefulWidget {
  MessageInfo message;
  ChatRoom({required this.message, super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late String id;
  final ScrollController listScrollController = ScrollController();
  void getId() async {
    UserPreference userPreference = UserPreference();
    id = (await userPreference.getUserId());
  }

  @override
  void initState() {
    getId();
    super.initState();
  }

  String? imageUrl;

  final _formKey = GlobalKey<FormState>();
  TextEditingController messageConroller = TextEditingController();
  String msg = '';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MessageBloc>(context)
        .add(GetYourMessage(id: widget.message.id));
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            (widget.message.profilePicture == null)
                ? const Icon(Icons.person)
                : 
                CachedNetworkImage(
                            fit: BoxFit.fill,
                            height: 40.0,

                            width: 40,

                            imageUrl: widget.message.profilePicture.toString(),
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
                          ),
                // FutureBuilder(
                //     future: FirebaseTaskManager.getImage(
                //         widget.message.profilePicture.toString(),
                //         '/ProfilePictures',
                //         15),
                //     builder: ((context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.done) {
                //         if (snapshot.hasError) {
                //           return const Icon(
                //             Icons.person,
                //             size: 40,
                //           );
                //         }
                //         if (snapshot.hasData) {
                //           imageUrl = snapshot.data as String;
                //           return CachedNetworkImage(
                //             fit: BoxFit.fill,
                //             height: 40.0,

                //             width: 40,

                //             imageUrl: snapshot.data.toString(),
                //             // imageUrl: snapshot.data,
                //             imageBuilder: (context, imageProvider) => Container(
                //               width: MediaQuery.of(context).size.width * 4,
                //               height: MediaQuery.of(context).size.height * 4,
                //               decoration: BoxDecoration(
                //                 shape: BoxShape.circle,
                //                 image: DecorationImage(
                //                     image: imageProvider, fit: BoxFit.cover),
                //               ),
                //             ),
                //             placeholder: (context, url) => const Center(
                //                 child: SpinKitCircle(
                //               color: Colors.black,
                //             )),
                //             errorWidget: (context, url, error) =>
                //                 const Icon(Icons.person),
                //           );
                //         }
                //       }
                //       return const SpinKitCircle(
                //         color: Colors.blue,
                //       );
                //     })),
            const SizedBox(
              width: 15,
            ),
            Text("${widget.message.firstName} ${widget.message.lastName}"),
          ],
        ),
      ),
      body: Stack(children: [
        BlocConsumer<MessageBloc, MessageState>(
          listener: (context, state) {},
          builder: (BuildContext context, state) {
            if (state is MessageStateInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            if (state is MessageStateFailure) {
              return const Center(child: Text("Failed to load message"));
            }

            if (state is MessageStateGetSucess) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.listOfMessage.reversed
                      .map(
                        (e) => (e.sender!.id == id)
                            ?
                            //  Column(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            // children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    width: 200,
                                    margin: const EdgeInsets.only(
                                        bottom: 5, right: 5, top: 2),
                                    child: Text(
                                      e.message,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              )
                            // const SizedBox(
                            //   height: 2,
                            // )
                            // ],
                            // )
                            : Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    // width: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.pink,
                                        borderRadius: BorderRadius.circular(8)),
                                    margin:
                                        const EdgeInsets.only(left: 10, top: 2),
                                    child: Text(
                                      e.message,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  )
                                ],
                              ),
                      )
                      .toList(),
                ),
              );
              // return const Center(child: Text("wait a minute!! "));
            }
            return const  Center(
              child:  SizedBox(
                child: Text("No message"),
              ),
            );
          },
          // child: SizedBox(
          //   height: double.infinity,
          //   width: double.infinity,
          //   child: buildListMessage(),
          // ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                        controller: messageConroller,
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                        validator: (value) {
                          if (value!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Enter message")));
                          } else {
                            return null;
                          }
                        }),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      MessageBody messageBody = MessageBody(
                          id: widget.message.id.toString(),
                          message: messageConroller.text.toString());
                          msg = messageConroller.text.toString();
                      // messageBody.message = messageConroller.text.toString();
                      // messageBody.id = widget.message.id.toString();
                      BlocProvider.of<MessageBloc>(context)
                          .add(SendMessageEvent(messageBody));
                      print("message is in ready to sent");
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(const CircleBorder())),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 18,
                  ),
                )
              ],
            ),
          ),
        )
      ]),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
      //   height: 60,
      //   width: double.infinity,
      //   color: Colors.white,
      //   child: Row(
      //     children: [
      //       GestureDetector(
      //         onTap: () {},
      //         child: Container(
      //           height: 40,
      //           width: 40,
      //           decoration: BoxDecoration(
      //             color: Colors.lightBlue,
      //             borderRadius: BorderRadius.circular(35),
      //           ),
      //           child: const Icon(
      //             Icons.add,
      //             color: Colors.white,
      //             size: 20,
      //           ),
      //         ),
      //       ),
      //       const SizedBox(
      //         width: 20,
      //       ),
      //       Expanded(
      //         child: Form(
      //           key: _formKey,
      //           child: TextFormField(
      //               controller: messageConroller,
      //               onChanged: (value) {},
      //               decoration: const InputDecoration(
      //                   hintText: "Write message...",
      //                   hintStyle: TextStyle(color: Colors.black54),
      //                   border: InputBorder.none),
      //               validator: (value) {
      //                 if (value!.isEmpty) {
      //                   ScaffoldMessenger.of(context).showSnackBar(
      //                       const SnackBar(content: Text("Enter message")));
      //                 } else {
      //                   return null;
      //                 }
      //               }),
      //         ),
      //       ),
      //       const SizedBox(
      //         width: 15,
      //       ),
      //       ElevatedButton(
      //         onPressed: () {
      //           if (_formKey.currentState!.validate()) {
      //             MessageBody messageBody = MessageBody(
      //                 id: widget.message.id.toString(),
      //                 message: messageConroller.text.toString());
      //             // messageBody.message = messageConroller.text.toString();
      //             // messageBody.id = widget.message.id.toString();
      //             BlocProvider.of<MessageBloc>(context)
      //                 .add(SendMessageEvent(messageBody));
      //             print("message is in ready to sent");
      //           }
      //         },
      //         style: ButtonStyle(
      //             backgroundColor: MaterialStateProperty.all(Colors.blue),
      //             shape: MaterialStateProperty.all(const CircleBorder())),
      //         child: const Icon(
      //           Icons.send,
      //           color: Colors.white,
      //           size: 18,
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
