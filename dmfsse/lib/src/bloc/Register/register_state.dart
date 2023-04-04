import '../../models/user.dart';

class RegisterState {}

class InitialState extends RegisterState {}

class RegisterUpdateSucess extends RegisterState {
  final User? user;
  RegisterUpdateSucess(this.user);
}

class RegisterInitial extends RegisterState {}

class RegistrationSucess extends RegisterState {}

class RegistraionFailure extends RegisterState {
  String? message;
  RegistraionFailure({this.message});
}
