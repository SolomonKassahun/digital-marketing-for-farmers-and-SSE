import 'dart:convert';

import '../../Ip/ip.dart';
import '../models/offer.dart';
import 'package:http/http.dart' as http;
class OfferDataProvider {
  String offerUrl = "${Ip.ip}/myOffers";
  Future<List<Offer>> getMyOffer() async{
     try {
       final response = await http.get(Uri.parse(offerUrl));
       if(response.statusCode == 200){
          final myOffer = jsonDecode(response.body) as List;
          return myOffer.map((e) => Offer.fromJson(e)).toList();
       }
       throw Exception("No internet. Failed to load offer");
     } catch (e) {
       throw Exception(e.toString());
     }
  }
}