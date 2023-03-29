import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  final ValueChanged<File> pickImage;
  const UploadImage({required this.pickImage, Key? key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? file;
  final _pickerImage = ImagePicker();
  _uploadImage() async {
    try {
      final pickedFile =
          await _pickerImage.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;
      setState(() {
        file = File(pickedFile.path);
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        await _uploadImage();
        if (file != null) widget.pickImage(file!);
      },
      child: Container(
        height: size.width * 0.5,
        width: size.width * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: file == null
            ? Container(
                child: Center(
                child: Icon(
                  Icons.add_photo_alternate_outlined,
                  color: Colors.blue,
                  size: size.width * 0.2,
                ),
              ))
            : Container(
                height: 120.0,
                width: 120.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: FileImage(
                      file!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
      ),
    );
  }
}