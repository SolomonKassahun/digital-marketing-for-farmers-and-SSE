import 'dart:convert';
import 'dart:io';

import 'package:dmfsse/local_storage/user_preference.dart';
import 'package:dmfsse/src/models/login_info.dart';
import 'package:http/http.dart' as http;

class UserDataProvider {
  final baseUrl = 'http://127.0.0.1:5000/api/LoginInfo/login';
  final UserPreference userPreference;
  UserDataProvider(this.userPreference);

  Future<LoggedInUserInfo> login(LoginInfo loginInfo) async {
    LoggedInUserInfo serverResponse;
    // ignore: avoid_print
    print('login click with ${loginInfo.username} and ${loginInfo.password} ');
    try {
      final response = await http.post(Uri.parse(baseUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // 'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "username": loginInfo.username.toString(),
            "password": loginInfo.password.toString(),
            "fistName": "fn",
            "lastName": "ln",
            "role": "r"
          }));
      if (response.statusCode != 200) {
        throw const HttpException('Incorrect email / or password');
      } else {
        final extractedData =json.decode(response.body) as Map<String, dynamic>;
        serverResponse = LoggedInUserInfo.fromJson(extractedData);
        await userPreference.storeUserInformation(serverResponse);
        return serverResponse;
      }
    } catch (e) {
      throw throw e;
    }
  }
}
