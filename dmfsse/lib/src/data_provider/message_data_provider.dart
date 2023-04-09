import 'dart:convert';

import 'package:dmfsse/src/models/message.dart';
import 'package:http/http.dart' as http;

import '../../Ip/ip.dart';
import '../../local_storage/user_preference.dart';

class MessageDataProvier {
  late String accessToken;
  void init() async {
    UserPreference userPreference = UserPreference();
    accessToken = await userPreference.getUserToken();
  }

  Future<List<Message>> getAllUserMessage() async {
    init();
    try {
      print("the token is $accessToken");
      final response = await http.get(Uri.parse("${Ip.ip}/connectedUserList/"),
          headers: {'x-access-token': accessToken.toString()});
      if (response.statusCode == 200) {
        print("the status code one is ${response.statusCode}");
        final responseData = jsonDecode(response.body) as List;
        print("the status code one is ${response.body}");
        return responseData.map((e) => Message.fromJson(e)).toList();
      } else {
        print("the status code two is ${response.statusCode}");
        throw Exception("No Internet. Failed to load message");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
