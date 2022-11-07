// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cropperImage.dart';
import 'cropper_image2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => 
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cropped Imagens',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const HomePage(),
    );
}