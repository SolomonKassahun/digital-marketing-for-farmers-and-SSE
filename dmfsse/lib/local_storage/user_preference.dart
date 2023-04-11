import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../src/models/login_info.dart';

class UserPreference {
  Future<void> storeUserInformation(LoggedInUserInfo loggedInUserInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_information', jsonEncode(loggedInUserInfo));
  }

  Future<LoggedInUserInfo?> getUserInformation() async {
    final prefs = await SharedPreferences.getInstance();
    String? userInfo = prefs.getString('user_information');
    if (userInfo != null) {
      final userInfoJson = jsonDecode(userInfo) as Map<String, dynamic>;
      var user = LoggedInUserInfo.fromJson(userInfoJson);
      return user;
    }
    return null;
  }

  Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token').toString();
  }

  Future<void> storeId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id').toString();
  }

  Future<void> removeUserInformation() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
