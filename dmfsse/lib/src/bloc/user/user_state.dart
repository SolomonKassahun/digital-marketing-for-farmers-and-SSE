import '../../models/user.dart';

class UserState {}

class UserStateInitial extends UserState {}

class UserUpdateSucess extends UserState {
  User user;
  UserUpdateSucess({required this.user});
}

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

class GetUserInfoFailure extends UserState {
  String message;
  GetUserInfoFailure({required this.message});
}
