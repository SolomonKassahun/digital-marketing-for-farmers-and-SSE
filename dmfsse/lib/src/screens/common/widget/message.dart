import 'package:cached_network_image/cached_network_image.dart';
import 'package:dmfsse/local_storage/user_preference.dart';
import 'package:dmfsse/src/bloc/message/message_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../bloc/message/message_bloc.dart';
import '../../../bloc/message/message_event.dart';
import 'chat_room.dart';

class MessageRoom extends StatefulWidget {
  const MessageRoom({super.key});

  @override
  State<MessageRoom> createState() => _MessageRoomState();
}

class _MessageRoomState extends State<MessageRoom> {
  late String id;
  @override
  void initState() {
    BlocProvider.of<MessageBloc>(context).add(FetchAllMessageEvent());

    super.initState();
  }

  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MessageBloc>(context).add(FetchAllMessageEvent());
    return SingleChildScrollView(
      child: Column(
        
        children: [
          BlocBuilder<MessageBloc, MessageState>(
            builder: (context, state) {
              if (state is MessageStateInitial) {
                return const Center(
                  child: SpinKitCircle(
                    color: Colors.black,
                  ),
                );
              }
              if (state is MessageStateFailure) {
                return Center(
                  child: Text(state.errorMessage.toString()),
                );
              }
              if (state is MessageStateSucess) {
                return state.message.isEmpty
                    ? const   Center(child:  Text("No message!"))
                    : SingleChildScrollView(
                        child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search...",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade600),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey.shade600,
                                  size: 20,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                contentPadding: const EdgeInsets.all(8),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade100)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Column(
                            children: state.message
                                .map((e) => GestureDetector(
                                      onTap: () {
                                      
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) => ChatRoom(
                                                      message: e,
                                                    )))).then((value) {
                                          BlocProvider.of<MessageBloc>(context)
                                              .add(FetchAllMessageEvent());
                                        });
                                      },
                                      child: Card(
                                        child: SizedBox(
                                          height: 80.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  (e.profilePicture == null)
                                                      ? const Icon(Icons.person)
                                                      : CachedNetworkImage(
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  height: 40.0,

                                                                  width: 40,

                                                                  imageUrl:e.profilePicture.toString(),
                                                                  // imageUrl: snapshot.data,
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        4,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        4,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image: DecorationImage(
                                                                          image:
                                                                              imageProvider,
                                                                          fit: BoxFit
                                                                              .cover),
                                                                    ),
                                                                  ),
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      const Center(
                                                                          child:
                                                                              SpinKitCircle(
                                                                    color: Colors
                                                                        .blue,
                                                                  )),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                          Icons
                                                                              .person),
                                                                ),
                                                 
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                          '${e.firstName}  ${e.lastName}'),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      const Divider(
                                                        color: Colors.black,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(e.updatedAt
                                                  .toString()
                                                  .substring(0, 10))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ));
              }
              return const Center(
                child: Text("No Message Here"),
              );
            },
          ),
        ],
      ),
    );
  }
}
