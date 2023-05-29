import 'package:dmfsse/src/models/message.dart';

import '../../models/message_list.dart';

class MessageState {}

class MessageStateInitial extends MessageState {
   List<ListOfMessage>? listOfMessage;
   MessageStateInitial({this.listOfMessage});
}
class SendMessageStateInitial extends MessageState {
  
}

class MessageStateSentInitial extends MessageState {
  List<ListOfMessage>? listOfMessage;
  MessageStateSentInitial({this.listOfMessage});
}

class MessageSentStateSucess extends MessageState {
  ListOfMessage message;
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
