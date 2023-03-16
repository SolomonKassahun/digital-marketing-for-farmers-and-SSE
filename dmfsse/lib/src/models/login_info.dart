import 'package:dmfsse/src/models/user.dart';

class LoginInfo {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String role;
  LoginInfo(this.username, this.password, this.firstName, this.lastName, this.role);

  Map<String, dynamic> toJson() => {
    'username': username, 
    'password': password,
    'firstName':firstName,
    'lastName':lastName,
    'role': role
    };
  LoginInfo.fromJson(Map<String, dynamic> json)
  :username=json['username'],
  password= json['password'],
  firstName = json['firstName'],
  lastName = json['lastName'],
  role = json['role']
  ;
}

class LoggedInUserInfo {
  final String access_token;
  final String message;
  final User user;
  LoggedInUserInfo(this.message, this.access_token,this.user);
  Map<String , dynamic> toJson() =>{
    'access_token': access_token,
    'message':message,
    'user':user
  };
  LoggedInUserInfo.fromJson(Map<String, dynamic> json):
  access_token=json['access_token'],
  message = json['message'],
  user = User.fromJson(json['user']);

}
