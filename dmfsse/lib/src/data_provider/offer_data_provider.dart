import 'dart:convert';

import '../../Ip/ip.dart';
import '../../local_storage/user_preference.dart';
import '../models/offer.dart';
import 'package:http/http.dart' as http;

class OfferDataProvider {
  String offerUrl = "${Ip.ip}/myOffers";

  late String accessToken;
  void init() async {
    UserPreference userPreference = UserPreference();
    accessToken = (await userPreference.getUserToken());
    print("the toke is $accessToken");
  }

  Future<List<Offer>> getMyOffer() async {
    init();
    try {
      final response = await http.get(Uri.parse(offerUrl),
          headers: {'x-access-token': accessToken.toString()});
      if (response.statusCode == 200) {
        print('status code is ${response.statusCode}');
        final myOffer = jsonDecode(response.body) as List;
        print('status code is ${myOffer}');
        var data = myOffer.map((e) => Offer.fromJson(e)).toList();
        print("Data");
        print(data);
        return data;
      }
      print('status code two is  is ${response.statusCode}');
      throw Exception("No internet. Failed to load offer");
    } catch (e) {
      print("Error in exception block");
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<Offer>> getMyOrder() async {
    init();
    try {
      final response = await http.get(Uri.parse("${Ip.ip}/myOrders"),
          headers: {'x-access-token': accessToken.toString()});
      if (response.statusCode == 200) {
        print('status code is ${response.statusCode}');
        final myOrder = jsonDecode(response.body) as List;
        print('status code is ${myOrder}');
        var data = myOrder.map((e) => Offer.fromJson(e)).toList();
        print("Data");
        print(data);
        return data;
      }
      print('status code two is  is ${response.statusCode}');
      throw Exception("No internet. Failed to load offer");
    } catch (e) {
      print("Error in exception block");
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<Offer> acceptOffer(OfferUpdateData offer) async {
    init();
    print('of ii was ${offer.offerId}');
    try {
      final response = await http.patch(Uri.parse('${Ip.ip}/order/${offer.offerId}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'x-access-token': accessToken,
          },
          body: jsonEncode({
            
              "accepted": offer.accepted,
              "canRate": offer.canRate,
              "quantity": offer.quantity,
              "offerPrice": offer.offerPrice
            
          }));
      if (response.statusCode == 201) {
        print('staus code is ${response.statusCode}');
        final myOffer = jsonDecode(response.body);
        return myOffer;
      }
       print('staus code is ${response.statusCode}');
      throw Exception("No internet. Failed to accept offer");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> deleteOffer(String offerId) async {
    try {
      final response = await http.delete(Uri.parse('$offerUrl/$offerId'));
      if (response.statusCode == 200) {
        final myOffer = jsonDecode(response.body) as List;
        return true;
      }
      throw Exception("No internet. Failed to delete offer");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
