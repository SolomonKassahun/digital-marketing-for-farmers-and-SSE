import 'dart:convert';
import 'dart:io';

import 'package:dmfsse/local_storage/user_preference.dart';
import 'package:dmfsse/src/bloc/product/product_state.dart';
import 'package:dmfsse/src/models/login_info.dart';
import 'package:dmfsse/src/service/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
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

        // await userPreference.storeUserInformation(serverResponse);
        // await userPreference.storeToken(serverResponse.accessToken);
        // await userPreference.storeUserId(serverResponse.id);

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
      final profileImgUrl = await FirebaseTaskManager.getImage(
          profilePicture.toString(), 'ProfilePictures', 15);
      final identificationImgUrl = await FirebaseTaskManager.getImage(
          identificationPicture.toString(), '/IdentificationPictures', 22);
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
            'profilePicture': profileImgUrl,
            'password': user.password,
            'roles': [user.roles],
            'identifictionPicture': identificationImgUrl,
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

  Future<GetUserInfoByPhoneNumber> getUserByPhoneNumber(
      String phoneNumber) async {
    try {
      final response = await http.get(
        Uri.parse(
          "${Ip.ip}/userByPhoneNumber/$phoneNumber",
        ),
      );
      if (response.statusCode == 200) {
        print("status code one is ${response.statusCode}");
        return GetUserInfoByPhoneNumber.fromJson(jsonDecode(response.body));
      }
      print("status code two is ${response.statusCode}");
      throw Exception("Failed to fetch user");
    } catch (e) {
      print("the erros is ");
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<bool> updateProfile(ProfileUpdate profileUpdate) async {
    
    initState();
    try {
      print(profileUpdate.id);
      final response =
          await http.patch(Uri.parse("${Ip.ip}/user/${profileUpdate.id}"),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'x-access-token': accessToken.toString()
              },
              body: jsonEncode({
                'firstName': profileUpdate.firstName,
              'lastName': profileUpdate.lastName,
                'phoneNumber': profileUpdate.phoneNumber
              }));
      if (response.statusCode == 201) {
        print('status code one is ${response.statusCode}');
        return true;
      }
      print('status code two is ${response.statusCode}');
      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> forgetPassword(String newPassword, String userId) async {
    try {
      final response =
          await http.patch(Uri.parse("${Ip.ip}/forgotpassword/$userId"),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
              body: jsonEncode({'password': newPassword}));
      if (response.statusCode == 201) {
        print('status code one is ${response.statusCode}');
        return true;
      }
      print('status code two is ${response.statusCode}');
      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
