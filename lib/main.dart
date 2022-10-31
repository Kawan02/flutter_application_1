// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class GaleriaCropper extends StatefulWidget {
  const GaleriaCropper({super.key});


  @override
  State<GaleriaCropper> createState() => _GaleriaCropperState();
}

class _GaleriaCropperState extends State<GaleriaCropper> {

  late File imageFile;

 pickCropImage() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery) as File;


    cropImage();
  }

  cropImage() async {
    File? CroppedFile = await ImageCropper().cropImage(sourcePath: imageFile.path,
    
    aspectRatioPresets: [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio16x9,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.square
    ],
    androidUiSettings: AndroidUiSettings(
      toolbarTitle: 'Crop',
      toolbarColor: const Color(0xffc69f50),
      toolbarWidgetColor: Colors.white,
      initAspectRatio: CropAspectRatioPreset.original,
      lockAspectRatio: false,
    )
    
    );

    if(CroppedFile != null) {
      setState(() {
        imageFile = CroppedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe5ded6),
      appBar: AppBar(
        backgroundColor: Color(0xffc69f50),
        title:  Text("Image cropper",

        ),
      ),
      body: Column(
        children: [
          // ignore: unnecessary_null_comparison
          imageFile == null ? Container() : Image.file(imageFile),
          ElevatedButton(
            onPressed: () {
              pickCropImage();
            }, 
          
          child: Text("Botão",
          style: TextStyle(
            fontSize: 20,
            height: 100
          ),
          ),
          
          )
        ],
      ),
    );
  }
}