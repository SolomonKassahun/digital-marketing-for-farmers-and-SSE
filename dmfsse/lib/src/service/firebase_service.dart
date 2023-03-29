import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseTaskManager {
  static Future<String?>  uploadImage(String picture, String folderName) async{
    final fileName = basename(picture);
    try {
      Reference reference =  FirebaseStorage.instance.ref(folderName).child(fileName);
      print(reference.putFile(File(picture)));
      await  reference.putFile(File(picture));
      
      return Future.value(reference.fullPath);
    } catch (e) {
      throw Exception(e);
    }
  } 
  static Future<String> downloadImage(String pictureName, String folderName){
   try {
      Reference reference = FirebaseStorage.instance.ref(folderName).child(pictureName);
    return reference.getDownloadURL();
  
   } catch (e) {
     throw Exception(e);
   }
  }
 static Future<String> getImage(String fileName, String folder, int subStringLength) async{
    String imgUrl = await downloadImage(fileName.substring(subStringLength), folder);
    print('image url is $imgUrl');
    return imgUrl;
  }
}