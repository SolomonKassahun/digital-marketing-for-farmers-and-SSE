import 'package:dmfsse/src/models/login_info.dart';

 class LoginEvent {}
class Loging extends LoginEvent {
  final LoginInfo loginInfo;
  Loging(this.loginInfo);
}
// class Loggedin extends LoginEvent {}
class LogOut extends LoginEvent{}
