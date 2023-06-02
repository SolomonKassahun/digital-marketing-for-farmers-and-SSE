import 'dart:math';

import 'package:flutter/material.dart';

class PaymentModel {
  String amount;
  String currency;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  String txtRef;
  String callbackUrl;
  String customization;
  BuildContext context;
  PaymentModel({
    required this.context,
    required this.amount,
    required this.currency, 
    required this.email,
    required this.firstName,
    required this.lastName,required this.phoneNumber,
    required this.txtRef,
    required this.callbackUrl,
    required this.customization});
    

  
}

class PaymentResponse {
  String message;
  String status;
  PaymentData data;
  PaymentResponse({required this.message, required this.status, required this.data});

  Map<String,dynamic> toJson() =>{
  'message':message,
  'status':status,
  'data':data
  };
  PaymentResponse.fromJson(Map<String,dynamic> json): 
  message = json['message'],
  status = json['status'],
  data = PaymentData.fromJson(json['data']);
}
class PaymentData {
  String checkoutUrl;
  PaymentData({required this.checkoutUrl});
  Map<String,dynamic> toJson() => {
    'checkoutUrl':checkoutUrl
  };
  PaymentData.fromJson(Map<String, dynamic> json) : 
  checkoutUrl = json['checkout_url'];
}