import 'package:dmfsse/src/models/message.dart';

import '../../models/message_list.dart';

class MessageState {}

class MessageStateInitial extends MessageState {}
class SendMessageStateInitial extends MessageState {}

class MessageStateSentInitial extends MessageState {}

class MessageSentStateSucess extends MessageState {
  String message;
  MessageSentStateSucess({required this.message});
}

class MessageStateSucess extends MessageState {
  List<MessageInfo> message;
  MessageStateSucess({required this.message});
}

class MessageStateGetSucess extends MessageState {
  List<ListOfMessage> listOfMessage;
  MessageStateGetSucess({required this.listOfMessage});
}

class MessageStateFailure extends MessageState {
  String errorMessage;
  MessageStateFailure({required this.errorMessage});
}
