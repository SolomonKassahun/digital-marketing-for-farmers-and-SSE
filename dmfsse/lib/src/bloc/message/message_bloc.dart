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
        try {
          emit(MessageStateInitial());
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
        emit(MessageStateInitial());
        try {
          // bool isMessagesent = messageDataRepository.sendMessage(mess, id)
          bool isMessageSent =
              await messageDataRepository.sendMessage(event.message, event.id);
          if (isMessageSent) {
            emit(MessageSentStateSucess());
          } else {
            emit(MessageStateFailure(errorMessage: "Unable to send message"));
          }
        } catch (e) {
          emit(MessageStateFailure(errorMessage: "Unable to send message"));
        }
      }
    });
  }
}
