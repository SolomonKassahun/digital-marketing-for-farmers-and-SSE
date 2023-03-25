import 'dart:convert';

import 'package:dmfsse/src/models/product.dart';
import 'package:dmfsse/src/service/firebase_service.dart';
import 'package:http/http.dart' as http;

class ProductDataProvider {
   final baseUrl = 'http://10.5.224.86:5000/api/addproduct';
   String? name;
   Future<bool> addProduct(Product product) async{
    print('login click with ${product.title} and ${product.photos} ');
    try {
      if(product.photos == null){
         throw  Exception("Product picture is required");
      }
    await FirebaseTaskManager.uploadImage(product.photos.toString(), '/product')
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
            'price':product.price,
            'description':product.description,
            'photos':name
          })
      );
      print("the response values  is ${response.statusCode}");
    if(response.statusCode == 201){
      print("================");
      return true;
    }
      else{
        print("yimetal aymitam");
    return false;
      // }
     };
      
    } catch (e) {
       print("yimetal aymitam $e");
       throw Exception(e);
    return false;

    }
    // print("==================================");
    // return false;

   }
}