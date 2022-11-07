import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:html' as html;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


final ImagePicker imagePicker = ImagePicker();
File? imagemSelecionada;
Uint8List webImagem = Uint8List(8);
// html.File? imagemSelecionada;

// Função image_cropper
_cortarImagem(File filePath) async {
    File croppedImage = (await ImageCropper().cropImage(
      sourcePath: filePath.path,
      maxWidth: 1280,
      maxHeight: 220,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      cropStyle: CropStyle.rectangle,
      uiSettings: [
        WebUiSettings(context: context,
        barrierColor: Colors.transparent,
        customClass: "",
        enableOrientation: true,
        enableResize: false,
        enforceBoundary: true,
          presentStyle: CropperPresentStyle.dialog,
          boundary: const CroppieBoundary(
            width: 1000,
            height: 220
          ), 
          viewPort: const CroppieViewPort(width: 1280, height: 220, type: "rectangle"),
          enableExif: true,
          enableZoom: true,
          mouseWheelZoom: true,
          showZoomer: true,
        //   customDialogBuilder: (cropper, crop, rotate) {
        //   return Dialog(
        //     child: Builder(builder: (context) {
        //       return Column(
        //         children: [
        //           TextButton(onPressed: () async {
        //             final result = await crop();
        //             Navigator.of(context).pop(result);
        //           }, 
        //           child: const Text("Editar capa"))
        //         ],
        //       );
        //     }),
        //   );
        // },
        )
      ]
    )) as File;
    // if (croppedImage != null) {
    //   imagemSelecionada = croppedImage;
    //   setState(() {});
    // }
  }

_pegarImagemGaleria () async {
  // ignore: deprecated_member_use
  PickedFile? imagemTemporaria = await ImagePicker().getImage(source: ImageSource.gallery, maxWidth: 1280,
      maxHeight: 220);


  _cortarImagem(File(imagemTemporaria!.path));
  
  if(imagemTemporaria != null) {
    
     var selected = File(imagemTemporaria.path);
    setState(() {
      imagemSelecionada = selected;
    });
  } else {
    Get.snackbar("Atenção",
          "Ocorreu um problema! Tente novamente em alguns instantes.");
  } if (imagemTemporaria != null) {
      var f = await imagemTemporaria.readAsBytes();
      setState(() {
        webImagem =  f;
        imagemSelecionada =  File('a');
      });
    } else {
      Get.snackbar("Atenção",
          "Ocorreu um problema! Tente novamente em alguns instantes.");
    }
}

_pegarImagemCamera() async {

  XFile? imagemTemporaria = await ImagePicker().pickImage(source: ImageSource.camera);


  _cortarImagem(File(imagemTemporaria!.path));
  
  if(imagemTemporaria != null) {
     var selected = File(imagemTemporaria.path);
    setState(() {
      imagemSelecionada = selected;
    });
  } else {
    Get.snackbar("Atenção",
          "Ocorreu um problema! Tente novamente em alguns instantes.");
  } if (imagemTemporaria != null) {
      var f = await imagemTemporaria.readAsBytes();
      setState(() {
        webImagem =  f;
        imagemSelecionada =  File('a');
      });
    } else {
      Get.snackbar("Atenção",
          "Ocorreu um problema! Tente novamente em alguns instantes.");
    }
}

 _clear() {
    setState(() {
      imagemSelecionada = null;
    });
  }


  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;
    var sizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cropper'),
      ),
      body: ListView(
        children: 
          [Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 20.0),
                     child: IconButton(onPressed: () {
                        _pegarImagemGaleria();
                  }, 
                      icon: const Icon(Icons.add_photo_alternate_outlined, color: Colors.green, size: 30, semanticLabel: "Upload")
                  ),
                   ),
      
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0, top: 20.0),
                    child: IconButton(onPressed: () {
                      _pegarImagemCamera();
                    }, 
                      icon: const Icon(Icons.add_a_photo_outlined, color: Colors.blue, size: 30, semanticLabel: "Upload")
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 100.0, top: 20.0),
                      child: IconButton(onPressed: () {
                        _clear();
                      }, 
                        icon: const Icon(Icons.delete, color: Colors.red, size: 30, semanticLabel: "Remover")
                      ),
                    ),
                ],
              ),

              imagemSelecionada == null ?
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                            const Text("Faça upload de uma imagem", style: TextStyle(fontSize: 30, color: Colors.black),
                          ),
                        ],
                      ),
                ) : const Padding(
                  padding: EdgeInsets.all(20.0),
                  child:  Text("Imagem carregada", style: TextStyle(fontSize: 30, color: Colors.black)),
                ),

              imagemSelecionada == null ?  Center(
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset('img/sem_foto.png', fit: BoxFit.cover),
                  ),
                ) : SizedBox(
                  width: sizeWidth * 1280,
                  height: sizeHeight * .320,
                  child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: kIsWeb ? Image.memory(webImagem, fit: BoxFit.cover) : Image.file((imagemSelecionada!), fit: BoxFit.cover),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}