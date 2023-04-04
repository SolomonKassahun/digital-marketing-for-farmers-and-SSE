import 'dart:convert';
import 'dart:io';

import 'package:dmfsse/local_storage/user_preference.dart';
import 'package:dmfsse/src/models/login_info.dart';
import 'package:dmfsse/src/service/firebase_service.dart';
import 'package:http/http.dart' as http;

import '../../Ip/ip.dart';
import '../models/user.dart';

class UserDataProvider {
  final registrationUrl = '${Ip.ip}/signup';
  final baseUrl = '${Ip.ip}/signin';
  final UserPreference userPreference;
  UserDataProvider(this.userPreference);

  Future<LoggedInUserInfo> login(LoginInfo loginInfo) async {
    LoggedInUserInfo serverResponse;
    // ignore: avoid_print
    print(
        'login click with ${loginInfo.phoneNumber} and ${loginInfo.password} ');
    try {
      final response = await http.post(Uri.parse(baseUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // 'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            "username": loginInfo.phoneNumber.toString(),
            "password": loginInfo.password.toString(),
          }));
      if (response.statusCode != 200) {
        throw const HttpException('Incorrect email / or password');
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        serverResponse = LoggedInUserInfo.fromJson(extractedData);
        await userPreference.storeUserInformation(serverResponse);
        return serverResponse;
      }
    } catch (e) {
      throw throw e;
    }
  }

  Future<bool> createUser(User user) async {
    try {
      String? profilePicture;
      String? identificationPicture;
      if (user.profilePicture == null || user.identifictionPicture == null) {
        throw Exception("Profile or Identification picture is required");
      }
      await FirebaseTaskManager.uploadImage(
              user.profilePicture.toString(), '/ProfilePictures')
          .then((value) {
        profilePicture = value.toString();
      });
      await FirebaseTaskManager.uploadImage(
              user.identifictionPicture.toString(), "IdentificationPictures")
          .then((value) {
        identificationPicture = value.toString();
      });
      final url = Uri.parse(registrationUrl);
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ',
          },
          body: jsonEncode({
            'firstName': user.firstName,
            'lastName': user.lastName,
            'email': user.email,
            'phoneNumber': user.phoneNumber,
            'profilePicture': profilePicture,
            'password': user.password,
            'role': user.role as List,
            'identifictionPicture': identificationPicture,
          }));
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
