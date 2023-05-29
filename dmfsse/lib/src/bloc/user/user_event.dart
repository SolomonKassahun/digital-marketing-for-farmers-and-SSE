class UserEvent {}

class UpdateUserEvent extends UserEvent {
  String id;
  UpdateUserEvent({required this.id});
}

class GetUserInfoEvent extends UserEvent {
  String id;
  GetUserInfoEvent({required this.id});
}
class GetUserByPhoneNumber extends UserEvent {
  String phoneNumber;
  GetUserByPhoneNumber({required this.phoneNumber});
}
class DeleteUserEvent extends UserEvent {
  String id;
  DeleteUserEvent({required this.id});
}
