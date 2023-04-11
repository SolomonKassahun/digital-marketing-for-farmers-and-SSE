import 'dart:convert';
import 'dart:io';

import 'package:dmfsse/local_storage/user_preference.dart';
import 'package:dmfsse/src/bloc/product/product_state.dart';
import 'package:dmfsse/src/models/login_info.dart';
import 'package:dmfsse/src/service/firebase_service.dart';
import 'package:http/http.dart' as http;

import '../../Ip/ip.dart';
import '../models/user.dart';
import '../models/user_registeration_info.dart';

class UserDataProvider {
  final registrationUrl = '${Ip.ip}/signup';
  final baseUrl = '${Ip.ip}/signin';
  final UserPreference userPreference;
  UserDataProvider(this.userPreference);
  String? accessToken;

  Future<void> initState() async {
    print("init is being called");
    accessToken = (await userPreference.getUserToken());
    print('the toke is $accessToken');
  }

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
            "phoneNumber": loginInfo.phoneNumber.toString(),
            "password": loginInfo.password.toString(),
          }));
      if (response.statusCode != 201) {
        print('the status code one is that ${response.statusCode}');
        throw const HttpException('Incorrect email / or password');
      } else {
        print(
            'the status code is that ${json.decode(response.body) as Map<String, dynamic>}');
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        serverResponse = LoggedInUserInfo.fromJson(extractedData);

        await userPreference.storeUserInformation(serverResponse);
        await userPreference.storeToken(serverResponse.accessToken);

        return serverResponse;
      }
    } catch (e) {
      print('the error was that ${e.toString()}');
      throw throw e;
    }
  }

  Future<bool> createUser(UserRegisterationInfo user) async {
    try {
      String? profilePicture;
      String? identificationPicture;
      print('login click with ${user} and ${user.roles} ');
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
            'roles': [user.roles],
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

  Future<User> getUserInfo(String id) async {
    initState();
    print("the id im amba was $id");
    try {
      final response = await http.get(Uri.parse('${Ip.ip}/user/$id'),
          headers: {'x-access-token': accessToken.toString()});
      if (response.statusCode == 200) {
        print('statis code one is ${response.statusCode}');
        print(json.decode(response.body));
        return User.fromJson(json.decode(response.body));
      } else {
        print('statis code two is ${response.statusCode}');
        throw Exception("failed to load");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
