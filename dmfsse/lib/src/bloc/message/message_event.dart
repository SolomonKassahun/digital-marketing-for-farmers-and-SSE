import '../../models/message.dart';

class MessageEvent {}

class FetchAllMessageEvent extends MessageEvent {}

class SendMessageEvent extends MessageEvent {
  MessageBody messagebody;
  SendMessageEvent(this.messagebody);
}

class GetYourMessage extends MessageEvent {
  String id;
  GetYourMessage({required this.id});
}

class DeleteMessageEvent extends MessageEvent {
  String id;
  DeleteMessageEvent({required this.id});
}

class UpdateMessageEvent extends MessageEvent {
  String id;
  UpdateMessageEvent({required this.id});
}
