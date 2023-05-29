import 'dart:convert';
import 'package:dmfsse/src/models/message.dart';
import 'package:http/http.dart' as http;
import '../../Ip/ip.dart';
import '../../local_storage/user_preference.dart';
import '../models/message_list.dart';

class MessageDataProvier {
  late String accessToken;
  void init() async {
    UserPreference userPreference = UserPreference();
    accessToken = await userPreference.getUserToken();
  }

  Future<List<MessageInfo>> getAllUserMessage() async {
    init();
    try {
      print("the token is $accessToken");
      final response = await http.get(Uri.parse("${Ip.ip}/connectedUserList/"),
          headers: {'x-access-token': accessToken.toString()});
      if (response.statusCode == 200) {
        print("the status code one is ${response.statusCode}");
        final responseData = jsonDecode(response.body) as List;

        print("the status code one is ${response.body}");
        return responseData.map((e) => MessageInfo.fromJson(e)).toList();
      } else {
        print("the status code two is ${response.statusCode}");
        throw Exception("No Internet. Failed to load message");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> sendMessage(MessageBody messageBody) async {
    init();
    print(
        'accessToken: $accessToken id: ${messageBody.id} message body: ${messageBody.message}');
    try {
      final response = await http.post(
          Uri.parse("${Ip.ip}/message/${messageBody.id.toString()}"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'x-access-token': accessToken
          },
          body: jsonEncode({"message": messageBody.message}));
      if (response.statusCode == 201) {
        print("status code one is ${response.body}");
        // return ListOfMessage.fromJson(jsonDecode(response.body));
        return true;
      }
      return false;
    //   print("status code two is ${response.statusCode} body: ${response.body}");
    //  throw Exception("Failed to send message");
    } catch (e) {
      throw Exception('the problem was that ${e.toString()}');
    }
  }

  Future<List<ListOfMessage>> getYourMessage(String id) async {
    init();
    try {
      final response = await http.get(
        Uri.parse("${Ip.ip}/getYourMessage/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'x-access-token': accessToken
        },
      );
      if (response.statusCode == 200) {
        final extractedData = jsonDecode(response.body) as List;
        print('status code: ${response.statusCode} body: $extractedData');
        return extractedData.map((e) => ListOfMessage.fromJson(e)).toList();
      }
      print('status code: ${response.statusCode} body: ');
      throw Exception('No Connection');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
