import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import 'classifier.dart';
import 'classifier_quant.dart';

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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Sezione intelligenza artificiale"),
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey.shade300,
                      Colors.grey.shade300,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      "RICONOSCI LA RAZZA DEL\n TUO ANIMALE",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.questrial(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ), */
              SizedBox(height: 50),
              Text(
                "RICONOSCI LA RAZZA DEL\n TUO ANIMALE",
                textAlign: TextAlign.center,
                style: GoogleFonts.questrial(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(
                height: 40,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            //height: MediaQuery.of(context).size.height * 0.6,
                            //margin: EdgeInsets.all(25),
                            padding: EdgeInsets.only(left: 25, right: 25,top: 25,bottom: 25),
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
                            child: Column(
                              children: [
                                _image == null
                                    ? InkWell(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 73),
                                            Text(
                                              'Seleziona un\'immagine!',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Image.asset(
                                                "assets/storyset/set_img.png",
                                                height: size.width / 1.8,
                                                width: size.width / 1.8,
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          getImage();
                                        },
                                      )
                                    : InkWell(
                                        child: Container(
                                          /*constraints: BoxConstraints(
                                              maxHeight: MediaQuery.of(context)
                                                      .size
                                                      .height / 2),*/
                                          child: _imageWidget,
                                        ),
                                        onTap: () {
                                          getImage();
                                        },
                                      ),
                                SizedBox(height: 15,),
                                Text(
                                  category != null ? category!.label : '',
                                  style: GoogleFonts.questrial(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.lightGreen.shade300,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  category != null
                                      ? 'ACCURATEZZA: ${category!.score.toStringAsFixed(3)}'
                                      : '',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        SizedBox(height: 20),
                        /*ElevatedButton(
                        onPressed: () {
                          getImage();
                        },
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints.tightFor(width: 260, height: 50),
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
                          side: BorderSide(
                              color: Colors.lightGreen.shade200, width: 2),
                          elevation: 5,
                          //minimumSize: Size(100, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ), */
                        /*FloatingActionButton(
                          clipBehavior: Clip.antiAlias,
                          onPressed: getImage,
                          tooltip: 'Scegli immagine',
                          //child: Icon(Icons.add_a_photo, color: Colors.white,),
                          elevation: 5,
                          child: Container(
                            width: 56,
                            height: 56,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.black87,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.lightGreen.shade100,
                                  Colors.lightGreen.shade200,
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp,
                              ),
                            ),
                          ),
                        ),*/
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
                          clipBehavior: Clip.antiAlias,
                          onPressed: getImage,
                          tooltip: 'Scegli immagine',
                          //child: Icon(Icons.add_a_photo, color: Colors.white,),
                          elevation: 5,
                          child: Container(
                            width: 56,
                            height: 56,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.black87,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.lightGreen.shade100,
                                  Colors.lightGreen.shade200,
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp,
                              ),
                            ),
                          ),
                        ),
    );
  }
}
