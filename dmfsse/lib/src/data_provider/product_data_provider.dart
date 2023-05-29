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
    accessToken = (await userPreference.getUserToken());
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
        headers: {'x-access-token': accessToken.toString()},
      );

      if (response.statusCode == 200) {
        print('status code one is ${response.statusCode}');
        final extractedData = json.decode(response.body) as List;
        print('status code one is ${extractedData}');

        return extractedData.map((e) => Product.fromJson(e)).toList();
      } else {
        print('status code one is ${response.statusCode}');

        throw Exception('No Connection');
      }
    } catch (e) {
      throw Exception('error at data provider ${e.toString()}');
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
      String productImgUrl = await FirebaseTaskManager.getImage(
          productPhoto.toString(), 'product', 7);
      print("product picture path is productPhoto: $productPhoto");
      //  async{
      final response = await http.post(Uri.parse(addProductUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'x-access-token': accessToken,
          },
          body: jsonEncode({
            'photo': productImgUrl,
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

  Future<Product> updateProducct(Product product) async {
    init();
    print('product is ${product.id}');
    try {
      final response =
          await http.patch(Uri.parse('${Ip.ip}/product/${product.id}'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'x-access-token': accessToken,
              },
              body: jsonEncode({
                'photo': product.photo,
                'price': product.price,
                'description': product.description,
                'name': product.name,
                'amount': product.amount,
                '_id': product.id,
                'soldout': product.soldout
              }));
      if (response.statusCode != 201) {
        print("staus code is ${response.statusCode}");
        throw const HttpException('Failed to update product');
      }
      print("staus code is ${response.body}");
      final extractedData = jsonDecode(response.body);
      return extractedData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> deleteProduct(String id) async {
    init();
    try {
      final response = await http.delete(Uri.parse("$baseUrl/$id"), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-access-token': accessToken,
      });
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (s) {
      throw Exception(e.toString());
    }
  }
}
