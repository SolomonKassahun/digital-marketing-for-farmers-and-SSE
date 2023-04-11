import 'package:dmfsse/src/models/message.dart';

class MessageState {}

class MessageStateInitial extends MessageState {}

class MessageSentStateSucess extends MessageState {}

class MessageStateSucess extends MessageState {
  List<MessageInfo> message;
  MessageStateSucess({required this.message});
}

class MessageStateFailure extends MessageState {
  String errorMessage;
  MessageStateFailure({required this.errorMessage});
}
