import '../../models/user_registeration_info.dart';

class RegisterState {}

class InitialState extends RegisterState {}

class RegisterUpdateSucess extends RegisterState {
  final UserRegisterationInfo? user;
  RegisterUpdateSucess(this.user);
}

class RegisterInitial extends RegisterState {}

class RegistrationSucess extends RegisterState {}

class RegistraionFailure extends RegisterState {
  String? message;
  RegistraionFailure({this.message});
}
