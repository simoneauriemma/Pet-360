import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'classifier.dart';
import 'classifier_quant.dart';
import 'package:logger/logger.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:google_fonts/google_fonts.dart';


class IAscreen extends StatefulWidget {
  const IAscreen({Key? key}) : super(key: key);

  @override
  _IAscreenState createState() => _IAscreenState();
}

class _IAscreenState extends State<IAscreen> { 
  late Classifier _classifier;

  var logger = Logger();

  File? _image;
  final picker = ImagePicker();

  Image? _imageWidget;

  img.Image? fox;

  Category? category;

  @override
  void initState() {
    super.initState();
    _classifier = ClassifierQuant();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      _imageWidget = Image.file(_image!);

      _predict();
    });
  }

  void _predict() async {
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);

    setState(() {
      this.category = pred;
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
              /*width: 350,
              height: 600,*/
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height,
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
                    "RICONOSCI LA RAZZA \n DEL TUO ANIMALE",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.questrial(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
               Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(color: Colors.white),
              /*  boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2, 2),
                    spreadRadius: 2,
                    blurRadius: 1,
                  ),
                ],*/
              ),
              child: _image == null
                ? Text('Nessuna immagine è stata ancora selezionata!\nSeleziona una immagine', 
                textAlign: TextAlign.center, 
                style: TextStyle(fontSize: 20),
                )
                : Container(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 2),
                    
                    child: _imageWidget,
                  ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            category != null ? category!.label : '',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800, color: Colors.lightGreen),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            category != null
                ? 'Accuratezza: ${category!.score.toStringAsFixed(3)}'
                : '',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 40),
        ElevatedButton(
              onPressed: (){
                 getImage();
              },
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                    width: 300, 
                    height: 50),
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
        ],
      ),
      
      ),
      
          ]),
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),*/
    );
  }
}
