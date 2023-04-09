class MessageEvent {}

class FetchAllMessageEvent extends MessageEvent {}

class SendMessageEvent extends MessageEvent {}

class DeleteMessageEvent extends MessageEvent {
  String id;
  DeleteMessageEvent({required this.id});
}

class UpdateMessageEvent extends MessageEvent {
  String id;
  UpdateMessageEvent({required this.id});
}
