import 'dart:convert';

import 'package:dmfsse/local_storage/user_preference.dart';
import 'package:http/http.dart' as http;

import '../../Ip/ip.dart';
import '../models/order.dart';

class OrderDataProvider {
  late String accessToken;
  void init() async {
    UserPreference userPreference = UserPreference();
    accessToken = await userPreference.getUserToken();
  }

  Future<bool> sendOffer(Order order) async {
    init();
    try {
      final response = await http.post(Uri.parse("${Ip.ip}/order/${order.id}"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'x-access-token': accessToken,
          },
          body: jsonEncode(
              {'quantity': order.quantity, 'offerPrice': order.offerPrice}));
      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
