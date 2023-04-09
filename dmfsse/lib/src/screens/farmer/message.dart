import 'package:dmfsse/src/bloc/message/message_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../bloc/message/message_bloc.dart';
import '../../bloc/message/message_event.dart';

class FarmerChat extends StatefulWidget {
  const FarmerChat({super.key});

  @override
  State<FarmerChat> createState() => _FarmerChatState();
}

class _FarmerChatState extends State<FarmerChat> {
  @override
  void initState() {
    BlocProvider.of<MessageBloc>(context).add(FetchAllMessageEvent());
    super.initState();
  }

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
                    ? const Text("No message")
                    : Column(
                        children: state.message
                            .map((e) => Card(
                                  child: Text(e.message),
                                ))
                            .toList(),
                      );
              }
              return const Center(
                child: Text("No Message"),
              );
            },
          ),
        ],
      ),
    );
  }
}
