import 'dart:convert';

import 'package:chapasdk/chapa_payment%20initializer.dart';
import 'package:http/http.dart' as http;


import '../models/payment_model.dart';

class PaymentDataProvider {
  String baseUrl = "https://api.chapa.co/v1/transaction/initialize";
  Future<PaymentResponse> payPayemnt(PaymentModel paymentModel) async {
    try {
      final response = await http.post(Uri.parse(baseUrl),
          headers: {
            'Authorization': 'Bearer CHASECK_TEST-Zy6eSfeshRoHHsxDS4Ccf1dzuIgHIHtv',
            'Content-Type': 'application/json'
          },
          body: jsonEncode({


Chapa.paymentParameters(
        context: paymentModel.context, // context 
        publicKey: 'CHASECK_TEST-Zy6eSfeshRoHHsxDS4Ccf1dzuIgHIHtv',
        currency: 'ETB',
        amount: paymentModel.amount,
        email: paymentModel.email,
        phone: paymentModel.phoneNumber,
        firstName: paymentModel.firstName,
        lastName: paymentModel.lastName,
        txRef: paymentModel.txtRef,
        title: 'title',
        desc:'desc',
        namedRouteFallBack: '/customerHomepage', // fall back route name
       )
            // "amount": paymentModel.amount.toString(),
            // "currency": paymentModel.currency,
            // "email": paymentModel.email,
            // "first_name": paymentModel.firstName,
            // "last_name": paymentModel.lastName,
            // "phone_number": paymentModel.phoneNumber,
            // "tx_ref": paymentModel.txtRef,
            // "callback_url": paymentModel.callbackUrl,
            // "return_url": "https://www.google.com/",
            // "customization[title]": "Payment for my favourite merchant",
            // "customization[description]": "I love online payments."
          }));
      if (response.statusCode == 200) {
        return PaymentResponse.fromJson(jsonDecode(response.body));
        // print('status code is ${response.statusCode}');
        // final extractedData = jsonDecode(response.body);
        // return extractedData;
      }
      print('status code is ${response.statusCode}');
      throw Exception("Failed to pay");
    } catch (e) {
      print('the problem is ');
      print(e.toString());
      throw Exception(e.toString());
    }
  }
}
