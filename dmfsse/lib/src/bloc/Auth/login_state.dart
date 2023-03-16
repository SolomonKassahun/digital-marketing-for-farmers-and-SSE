
import 'package:dmfsse/src/models/login_info.dart';

abstract class LoginState  {}
class LoginInitial extends LoginState{}
class LoginingState extends LoginState {}
class LoginSucess extends LoginState {
  final LoggedInUserInfo loggedInUserInfo;
  LoginSucess(this.loggedInUserInfo);
}
class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}