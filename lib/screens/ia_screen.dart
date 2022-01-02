import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';

class IAscreen extends StatefulWidget {
  const IAscreen({Key? key}) : super(key: key);

  @override
  _IAscreenState createState() => _IAscreenState();
}

class _IAscreenState extends State<IAscreen> {
  File? _imageFile;
  List? _classifiedResult; //per memorizzare il risultato della classificazione

  
  @override
  void initState() {
    super.initState();
    loadImageModel();
  }

  Future selectImage() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery, maxHeight: 300);
    setState(() {
      if (image != null) {
        _imageFile = File(image.path);
      } else {
        print('No image selected.');
      }
    });
    classifyImage(image!.path);
  }

  Future loadImageModel() async {
  var result = await Tflite.loadModel(
    model: "assets/mobilenet_v1_1.0_224_quant.tflite",
    labels: "assets/labels_mobilenet_quant_v1_224.txt",
  );
  print("result: $result");
}


Future classifyImage(image) async {
    _classifiedResult = null;
    // Run tensorflowlite image classification model on the image
    print("classification start $image");
     final List? result = await Tflite.runModelOnImage(
      path: image,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    print("classification done");
    setState(() {
      if (image != null) {
        _imageFile = File(image.path);
        _classifiedResult = result;
      } else {
        print('No image selected.');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Riconoscimento"),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: 350,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "RICONOSCI LA RAZZA DEL TUO CANE",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30,),
               Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2, 2),
                    spreadRadius: 2,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: (_imageFile != null)?
              Image.file(_imageFile!) :
              Image.asset("assets/icons/razza_cane.jpg")
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                 selectImage();
              },
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width, height: 50),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Seleziona immagine",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.black,
                primary: Colors.white,
                onSurface: Colors.grey,
                side: BorderSide(color: Colors.lightGreen.shade200, width: 2),
                elevation: 5,
                //minimumSize: Size(100, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  child: Column(
                    children: 
                    _classifiedResult!=null ? _classifiedResult!.map((result) {
                        return Card(
                          elevation: 0.0,
                          color: Colors.lightGreen,
                          child: Container(
                            width: 300,
                            margin: EdgeInsets.all(10),
                            child: Center(
                              child: Text("${result["label"]} :  ${(result["confidence"] * 100).toStringAsFixed(1)}%",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                    } ).toList()
                   :[],
                  ),
                )
                ]
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
