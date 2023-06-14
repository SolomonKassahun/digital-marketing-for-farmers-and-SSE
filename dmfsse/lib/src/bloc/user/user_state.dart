import '../../models/login_info.dart';
import '../../models/user.dart';

class UserState {}

class UserStateInitial extends UserState {}

class UserUpdateSucess extends UserState {
  User user;
  UserUpdateSucess({required this.user});
}
class UpdateSucess extends UserState{
  ProfileUpdate profileUpdate;
  UpdateSucess({required this.profileUpdate});
}
class UserForgetPasswordInitial extends UserState {}
class UserForgetPasswordSuccess extends UserState{}
class UserUpdateFailure extends UserState {
  String message;
  UserUpdateFailure({required this.message});
}

class UserDeleteSucess extends UserState {
  User user;
  UserDeleteSucess({required this.user});
}

class UserDeleteFailure extends UserState {
  String message;
  UserDeleteFailure({required this.message});
}

class GetUserInfoSucess extends UserState {
  User user;
  GetUserInfoSucess({required this.user});
}
class GetUserInfoInitial extends UserState {}
class GetUserInfoByPhoneNumberSucess extends UserState {
  GetUserInfoByPhoneNumber user;
  GetUserInfoByPhoneNumberSucess({required this.user});
}

class GetUserInfoFailure extends UserState {
  String message;
  GetUserInfoFailure({required this.message});
}
