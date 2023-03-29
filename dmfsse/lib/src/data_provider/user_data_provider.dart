import 'dart:convert';
import 'dart:io';

import 'package:dmfsse/local_storage/user_preference.dart';
import 'package:dmfsse/src/models/login_info.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class UserDataProvider {
  final baseUrl = 'http://10.5.224.86:5000/api/LoginInfo/login';
  final registrationUrl = 'http://10.6.210.99:5000/api/LoginInfo';
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
  Future<bool> createUser(User user) async{
    try {
      final url = Uri.parse(registrationUrl);
      final response = await http.post(url,
       headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer ',
            },
          body: jsonEncode({
            'UserId':user.UserId,
            'username':user.username,
            'role':user.role,
            'firstName':user.firstName,
            'lastName':user.lastName,
            'password':user.password

          })

      );
              if (response.statusCode == 201) {
          return true;
        } else {
         
          throw Exception('Failed to create user');
        }

      
    } catch (e) {
      // ignore: avoid_print
      print("Exception throuwn $e");
    }
return false;
    
  }
}
