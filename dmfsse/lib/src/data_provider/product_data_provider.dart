import 'dart:convert';

import 'package:dmfsse/src/models/product.dart';
import 'package:dmfsse/src/service/firebase_service.dart';
import 'package:http/http.dart' as http;

class ProductDataProvider {
  final baseUrl = 'http://10.5.224.86:5000/api/addproduct';
  String? name;
  Future<List<Product>> getAllActiveProduct() async{
    try {
      print("Sammmmmmmmmmmmmmmmmmmmmmmmmmmmmm+++++++++++++++++++++++");
      final response = await http.get(Uri.parse(baseUrl),
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // 'Authorization': 'Bearer $token',
          },     
      );
       print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
      print('the status code is One ${response.statusCode}');
      if(response.statusCode == 200){
        final extractedData = json.decode(response.body) as List;
        return extractedData.map((e) => Product.fromJson(e)).toList();
      }else{
        print('the status code is ${response.statusCode}');
         throw Exception('No Connection');
      }
    } catch (e) {
      
      throw Exception('error at data provider $e');
    }
  }
  Future<bool> addProduct(Product product) async {
    try {
      if (product.photos == null) {
        throw Exception("Product picture is required");
      }
      await FirebaseTaskManager.uploadImage(
              product.photos.toString(), '/product')
          .then((productPicturePath) {
        name = productPicturePath;
      });
      //  async{
      final response = await http.post(Uri.parse(baseUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // 'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'title': product.title.toString(),
            'price': product.price,
            'description': product.description,
            'photos': name
          }));

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
      ;
    } catch (e) {
      throw Exception(e);
    }
  }
}
