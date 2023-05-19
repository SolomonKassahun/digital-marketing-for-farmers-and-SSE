import 'package:dmfsse/src/models/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_repository/message_data_repository.dart';
import 'message_event.dart';
import 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageDataRepository messageDataRepository;

  MessageBloc({required this.messageDataRepository})
      : super(MessageStateInitial()) {
    on<MessageEvent>((event, emit) async {
      if (event is FetchAllMessageEvent) {
        emit(MessageStateInitial());
        try {
          
          print('list of message ');
          List<MessageInfo> listOfMessage =
              await messageDataRepository.getAllUserMessage();
          print('list of message $listOfMessage');
          if (listOfMessage != []) {
            print('list of object two $listOfMessage');
            emit(MessageStateSucess(message: listOfMessage));
          } else {
            emit(MessageStateFailure(
                errorMessage: "No internet. Failed to load Message"));
          }
        } catch (e) {
          emit(MessageStateFailure(errorMessage: e.toString()));
        }
      }
      if (event is SendMessageEvent) {
        emit(SendMessageStateInitial());
        try {
          // bool isMessagesent = messageDataRepository.sendMessage(mess, id)
          bool isMessageSent =
              await messageDataRepository.sendMessage(event.messagebody);
          if (isMessageSent) {
            emit(MessageSentStateSucess(message:event.messagebody.message.toString()));
          } else {
            emit(MessageStateFailure(errorMessage: "Unable to send message"));
          }
        } catch (e) {
          emit(MessageStateFailure(errorMessage: e.toString()));
        }
      }
      if (event is GetYourMessage) {
        emit(MessageStateInitial());
        try {
          final listOfMessage =
              await messageDataRepository.getYourMessage(event.id);
          if (listOfMessage != []) {
            emit(MessageStateGetSucess(listOfMessage: listOfMessage));
          } else {
            emit(MessageStateFailure(errorMessage: "Unable to load message"));
          }
        } catch (e) {
          throw Exception("Failed to load Message");
        }
      }
    });
  }
}
