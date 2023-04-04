import 'package:dmfsse/src/models/user.dart';

class LoginInfo {
  final String phoneNumber;
  final String password;

  LoginInfo(this.phoneNumber, this.password);

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'password': password,
      };
  LoginInfo.fromJson(Map<String, dynamic> json)
      : phoneNumber = json['phoneNumber'],
        password = json['password'];
}

class LoggedInUserInfo {
  final String id;
  final String verified;

  final String accessToken;
  final User user;
  LoggedInUserInfo(this.id, this.accessToken, this.user, this.verified);
  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'verified': verified,
        'user': user,
        'id': id
      };
  LoggedInUserInfo.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        verified = json['verified'],
        id = json['id'],
        user = User.fromJson(json['user']);
}
