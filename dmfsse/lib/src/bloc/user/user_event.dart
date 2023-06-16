import '../../models/user.dart';

class UserEvent {}

class UpdateUserEvent extends UserEvent {
  ProfileUpdate id;
  UpdateUserEvent({required this.id});
}

class GetUserInfoEvent extends UserEvent {
  String id;
  GetUserInfoEvent({required this.id});
}
class ForgetPasswordEvent extends UserEvent{
  String newPassword;
  String userId;
  ForgetPasswordEvent({required this.newPassword,required this.userId});
}
class GetUserByPhoneNumber extends UserEvent {
  String phoneNumber;
  GetUserByPhoneNumber({required this.phoneNumber});
}
class DeleteUserEvent extends UserEvent {
  String id;
  DeleteUserEvent({required this.id});
}
