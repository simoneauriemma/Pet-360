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

  Row textAccuratezza = Row(
    children: [
      Text(
        "Ciao sono Pepper!\n Ti aiuterò a capire qual è la razza\n del tuo animale.",
        textAlign: TextAlign.center,
        style: GoogleFonts.questrial(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );

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

    if (category!.score <= 0.4) {
      textAccuratezza = Row(
        children: [
          Text(
            "Non sono affatto sicuro\n di aver capito la razza del tuo animale!\n Ho provato comuqnue ad indovinare.",
            textAlign: TextAlign.center,
            style: GoogleFonts.questrial(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),

          //Icon(Icons.sentiment_dissatisfied_outlined),
        ],
      );
    } else if (category!.score > 0.4 && category!.score <= 0.6) {
      textAccuratezza = Row(
        children: [
          Text(
            "Sono mediamente sicuro di aver\n capito la razza del tuo animale,\n ma potrei aver sbagliato.",
            textAlign: TextAlign.center,
            style: GoogleFonts.questrial(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),

          //Icon(Icons.sentiment_neutral_outlined ),
        ],
      );
    } else if (category!.score > 0.6 && category!.score <= 0.9) {
      textAccuratezza = Row(
        children: [
          Text(
            "Sono abbastanza sicuro di aver\n capito la razza del tuo animale!",
            textAlign: TextAlign.center,
            style: GoogleFonts.questrial(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),

          //Icon(Icons.sentiment_satisfied ),
        ],
      );
    } else if (category!.score > 0.9) {
      textAccuratezza = Row(
        children: [
          Text(
            "Sono sicuro di aver azzeccato\n la razza del tuo aniamale!",
            textAlign: TextAlign.center,
            style: GoogleFonts.questrial(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),

          //Icon(Icons.sentiment_satisfied_alt_rounded ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text(
          "Riconoscimento razza animale",
          style: GoogleFonts.questrial(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
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
              SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 40, top: 60),
                    child: Image.asset(
                      "assets/storyset/robot.png",
                      height: size.width / 2.1,
                      width: size.width / 2.1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 0),
                    child: Container(
                        width: 300,
                        padding: EdgeInsets.all(21),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(40)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: textAccuratezza,
                            )
                          ],
                        )),
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          //margin: EdgeInsets.all(25),
                          padding: EdgeInsets.only(
                              left: 20, right: 20, bottom: 20, top: 40),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0)),
                            border: Border.all(color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                                            'Clicca qui per selezionare\n un\'immagine!',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Image.asset(
                                              "assets/storyset/set_img.png",
                                              height: size.width / 1.9,
                                              width: size.width / 1.9,
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
                                        child: _imageWidget,
                                      ),
                                      onTap: () {
                                        getImage();
                                      },
                                    ),
                              SizedBox(
                                height: 40,
                              ),
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
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
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
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.add_a_photo,
                size: 30,
                color: Colors.grey.shade800,
              ),
              Text(
                "Foto",
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.bold),
              ),
            ],
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
