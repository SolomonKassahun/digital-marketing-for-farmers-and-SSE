import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dmfsse/src/models/product.dart';
import 'package:dmfsse/src/service/firebase_service.dart';
import 'package:http/http.dart' as http;

import '../../Ip/ip.dart';
import '../../local_storage/user_preference.dart';

class ProductDataProvider {
  final baseUrl = '${Ip.ip}/products';
  final addProductUrl = '${Ip.ip}/addProduct';

  String? productPhoto;
  late String accessToken;
  void init() async {
    UserPreference userPreference = UserPreference();
    accessToken = await userPreference.getUserToken();
  }

  Future<List<Product>> getAllActiveProduct() async {
    try {
     
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization': 'Bearer $token',
        },
      );
      
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List;
      
        return extractedData.map((e) => Product.fromJson(e)).toList();
      } else {
       
        throw Exception('No Connection');
      }
    } catch (e) {
      throw Exception('error at data provider $e');
    }
  }
  Future<List<Product>> getMyProduct() async {
    init();
    try {
     
      final response = await http.get(
        Uri.parse("${Ip.ip}/myProduct/"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'x-access-token':accessToken.toString()
        
        },
      );
      
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List;
      
        return extractedData.map((e) => Product.fromJson(e)).toList();
      } else {
       
        throw Exception('No Connection');
      }
    } catch (e) {
      throw Exception('error at data provider $e');
    }
  }

  Future<bool> addProduct(Product product) async {
    init();

    try {
      if (product.photo == null) {
        throw Exception("Product picture is required");
      }
      await FirebaseTaskManager.uploadImage(
              product.photo.toString(), '/product')
          .then((productPicturePath) {
        productPhoto = productPicturePath;
      });
      print("product picture path is productPhoto: $productPhoto");
      //  async{
      final response = await http.post(Uri.parse(addProductUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'x-access-token': accessToken,
          },
          body: jsonEncode({
            'photo': productPhoto,
            'price': product.price,
            'description': product.description,
            'name': product.name,
            'amount': product.amount,
          }));

      if (response.statusCode == 201) {
        print('the status code is ${response.statusCode}');
        return true;
      } else {
        print('the status code is ${response.statusCode}');
        return false;
      }
      ;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Product> updateProducct(String id) async{
    try {
      final response = await http.put(Uri.parse('${Ip.ip}/product/$id'));
      if(response.statusCode != 201){
        throw const HttpException('Failed to update product');
       
      }
      final extractedData= jsonDecode(response.body);
        return extractedData;
      
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
