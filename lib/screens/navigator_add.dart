import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet360/model/new_vaccine.dart';
import 'package:pet360/utils/usersharedpreferences.dart';
import 'package:http/http.dart' as http;

void main() => runApp(NavigatorAdd());

class NavigatorAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey.shade300,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.lightGreen,
        ).copyWith(),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => addInfoAnimals(),
        /*'/second': (context) => addInfoVax(),
	'/third': (context) => addInfoPass(),
  '/fourth' : (context) => addInfoDisp(),*/
      },
    );
  }
}

double _currentSliderValue = 1;

//campi di aggiunta info animale
final nameController = new TextEditingController();
final specieController = new TextEditingController();
final razzaController = new TextEditingController();
final coloreController = new TextEditingController();
final veterinarioController = new TextEditingController();
//campi di aggiunta info vaccino animale
final tipoVaccinoController = new TextEditingController();
final dataSommController = new TextEditingController();
final farmacoSommController = new TextEditingController();
final nomeVeterController = new TextEditingController();
//campi di aggiunta passaporto animale
final descrizioneController = new TextEditingController();
final microchipController = new TextEditingController();
final dataMicrochipController = new TextEditingController();
final enteController = new TextEditingController();
final dataController = new TextEditingController();
final _auth = FirebaseAuth.instance;

class addInfoAnimals extends StatefulWidget {
  @override
  _addInfoState createState() => _addInfoState();
}

class _addInfoState extends State<addInfoAnimals> {
  File? pickedImage;
  var lstVaccines = List.empty();
  NewVaccine firstVaccine = NewVaccine();
  var jsonBody;

  /*@override
  void dispose() {
    // Clean up the controller when the widget is removed
    dataController.dispose();
    super.dispose();
  }*/

  void imagePickerOption() {
    Get.bottomSheet(
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: Container(
          color: Colors.white,
          height: 250,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Scegli immagine da",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("CAMERA"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text("GALLERIA"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                  label: const Text("CANCEL"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getImage(ImageSource imageType) async {
    try {
      final image = await ImagePicker().pickImage(source: imageType);

      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        pickedImage = imageTemp;
      });
      Get.back();
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  int currentStep = 0;

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: Text(''),
          content: Container(
            //color: Colors.transparent.withOpacity(0.5),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 20),
                      width: 400,
                      height: 620,
                      //sfondo con sfocatura
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
                          Text(
                            "DATI LIBRETTO ANIMALE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 3),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: ClipOval(
                                      child: pickedImage != null
                                          ? Image.file(
                                              pickedImage!,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            )
                                          :
                                          //child: Image.asset("assets/icons/download.jpeg", width: 50, height: 50, fit: BoxFit.cover),
                                          SizedBox(
                                              width: 100.0,
                                              height: 100.0,
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 2,
                                    child: IconButton(
                                      onPressed: () {
                                        imagePickerOption();
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.black,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            width: 280,
                            child: TextFormField(
                                autofocus: false,
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                onSaved: (value) {
                                  nameController.text = value!;
                                },
                                textInputAction: TextInputAction.next,
                                //Nome
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  labelText: "Nome",
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              width: 280,
                              child: TextFormField(
                                autofocus: false,
                                controller: dataController,
                                keyboardType: TextInputType.name,
                                onSaved: (value) {
                                  dataController.text = value!;
                                },

                                textInputAction: TextInputAction.next,

                                //DataNascita
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  labelText: "Data di nascita",
                                ),
                                onTap: () async {
                                  var date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100));
                                  dataController.text =
                                      date.toString().substring(0, 10);
                                },
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 280,
                            child: TextFormField(
                                autofocus: false,
                                controller: specieController,
                                keyboardType: TextInputType.name,
                                onSaved: (value) {
                                  specieController.text = value!;
                                },
                                textInputAction: TextInputAction.next,

                                //Specie
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  labelText: "Specie",
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 280,
                            child: TextFormField(
                                autofocus: false,
                                controller: razzaController,
                                keyboardType: TextInputType.name,
                                onSaved: (value) {
                                  razzaController.text = value!;
                                },
                                textInputAction: TextInputAction.next,

                                //Razza
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  labelText: "Razza",
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 280,
                            child: TextFormField(
                                autofocus: false,
                                controller: coloreController,
                                keyboardType: TextInputType.name,
                                onSaved: (value) {
                                  coloreController.text = value!;
                                },
                                textInputAction: TextInputAction.next,

                                //Colore
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  labelText: "Colore",
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 280,
                            child: TextFormField(
                                autofocus: false,
                                controller: veterinarioController,
                                keyboardType: TextInputType.name,
                                onSaved: (value) {
                                  veterinarioController.text = value!;
                                },
                                textInputAction: TextInputAction.next,

                                //NomeVeterinario
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  labelText: "Nome veterinario",
                                )),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: Text(''),
          content: Column(children: [
            Container(
              width: 400,
              height: 350,
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "LISTA VACCINI",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 280,
                    child: TextFormField(
                        autofocus: false,
                        controller: tipoVaccinoController,
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          tipoVaccinoController.text = value!;
                          firstVaccine.vaccineType = value;
                        },
                        textInputAction: TextInputAction.next,

                        //Tipo vaccino
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          labelText: "Tipo vaccino",
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 280,
                    child: TextFormField(
                        autofocus: false,
                        controller: dataSommController,
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          dataSommController.text = value!;
                          firstVaccine.date = value;
                        },
                        textInputAction: TextInputAction.next,

                        //Data somministrazione vaccino
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          labelText: "Data somministrazione",
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 280,
                    child: TextFormField(
                        autofocus: false,
                        controller: farmacoSommController,
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          farmacoSommController.text = value!;
                          firstVaccine.medicine = value;
                        },
                        textInputAction: TextInputAction.next,

                        //Farmaco somministrato
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          labelText: "Farmaco somministrato",
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 280,
                    child: TextFormField(
                        autofocus: false,
                        controller: nomeVeterController,
                        keyboardType: TextInputType.name,
                        onSaved: (value) {
                          nomeVeterController.text = value!;
                          firstVaccine.veterinaryName = value;
                        },
                        textInputAction: TextInputAction.next,

                        //Nome veterinario
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          labelText: "Nome veterinario",
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              width: 400,
              height: 100,
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
                  Text(
                    "Aggiungi un altro vaccino",
                    //style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  IconButton(
                    onPressed: () {
                      NewVaccine tmp = NewVaccine();
                      tmp.veterinaryName = firstVaccine.veterinaryName;
                      tmp.date = firstVaccine.date;
                      tmp.vaccineType = firstVaccine.vaccineType;
                      tmp.medicine = firstVaccine.medicine;
                      lstVaccines = List.filled(1, 0);
                      lstVaccines[0]=firstVaccine;
                    },
                    icon: Icon(Icons.add_circle_outline, color: Colors.black),
                    iconSize: 40,
                  ),
                ],
              ),
            )
          ]),
        ),
        Step(
            isActive: currentStep >= 2,
            title: Text(''),
            content: Column(
              children: [
                //TITOLO
                Container(
                  width: 400,
                  height: 350,
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
                  child: Column(children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "PASSAPORTO ANIMALE",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 280,
                      child: TextFormField(
                          autofocus: false,
                          controller: descrizioneController,
                          keyboardType: TextInputType.name,
                          onSaved: (value) {
                            descrizioneController.text = value!;
                          },
                          textInputAction: TextInputAction.next,

                          //Descrizione animale
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            labelText: "Descrizione animale",
                          )),
                    ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 280,
                      child: TextFormField(
                          autofocus: false,
                          controller: microchipController,
                          keyboardType: TextInputType.name,
                          onSaved: (value) {
                            microchipController.text = value!;
                          },
                          textInputAction: TextInputAction.next,

                          //Numero microchip
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            labelText: "N° microchip",
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      width: 280,
                      child: TextFormField(
                          autofocus: false,
                          controller: dataMicrochipController,
                          keyboardType: TextInputType.name,
                          onSaved: (value) {
                            dataMicrochipController.text = value!;
                          },
                          textInputAction: TextInputAction.next,

                          //Data applicazione microchip
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            labelText: "Data applicazione microchip",
                          )),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      width: 280,
                      child: TextFormField(
                          autofocus: false,
                          controller: enteController,
                          keyboardType: TextInputType.name,
                          onSaved: (value) {
                            enteController.text = value!;
                          },
                          textInputAction: TextInputAction.next,

                          //Ente rilasciante
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            labelText: "Ente rilasciante",
                          )),
                    ),
                  ]),
                ),
              ],
            )),
        Step(
            isActive: currentStep >= 3,
            title: Text(''),
            content: Column(
              children: [
                Container(
                    width: 400,
                    height: 300,
                    padding: EdgeInsets.only(top: 30),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "LOCALIZZAZIONE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Dispositivi disponibili:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          child: Text("AirTag1"),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.black,
                            primary: Colors.white,
                            side:
                                BorderSide(color: Colors.lightGreen, width: 1),
                            elevation: 5,
                            minimumSize: Size(140, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () {
                            Fluttertoast.showToast(
                                msg: "Dispositivo aggiunto correttamente!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey.shade200,
                                textColor: Colors.black,
                                fontSize: 15.0);
                          },
                        ),
                        ElevatedButton(
                          child: Text("AirTag2"),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.black,
                            primary: Colors.white,
                            onSurface: Colors.grey,
                            side:
                                BorderSide(color: Colors.lightGreen, width: 1),
                            elevation: 5,
                            minimumSize: Size(140, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () {
                            Fluttertoast.showToast(
                                msg: "Dispositivo aggiunto correttamente!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey.shade200,
                                textColor: Colors.black,
                                fontSize: 15.0);
                          },
                        )
                      ],
                    )),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    saveData(
                        nameController.text,
                        dataController.text,
                        specieController.text,
                        razzaController.text,
                        coloreController.text,
                        veterinarioController.text);
                  },
                  child: Text(
                    "Salva tutto",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen.shade300,
                    //side: BorderSide(color: Colors.grey.shade300, width: 2),
                    elevation: 5,
                    minimumSize: Size(400, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                //  )
              ],
            )),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Aggiungi animale"),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: null,
          onStepCancel: null,
          onStepTapped: (step) => setState(() {
                currentStep = step;
              }),
          controlsBuilder: (context, {onStepContinue, onStepCancel}) {
            return Container(child: null);
          }),
    );
  }

  saveData(String animalName, String animalBirthday, String animalSpecie,
      String animalKind, String animalColor, String animalVeterinaryName) {
    final DBRef = FirebaseDatabase.instance
        .reference()
        .child(UserSharedPreferences.getTypeOfUser().toString());
    DBRef.child(_auth.currentUser!.uid.toString() + "/Animali/"+animalName).set({
      'animalName': animalName,
      'animalBirthday': animalBirthday,
      'animalSpecie': animalSpecie,
      'animalKind': animalKind,
      'animalColor': animalColor,
      'animalVeterinaryName': animalVeterinaryName,
    });
    if (lstVaccines.isNotEmpty) {
      for (int i=0;i<lstVaccines.length;i++) {
        DBRef.child(_auth.currentUser!.uid.toString() +
                "/Animali/" + animalName + "/Vaccini/"+i.toString())
            .set({
          'vaccineType': lstVaccines[i].vaccineType,
          'medicine': lstVaccines[i].medicine,
          'date': lstVaccines[i].date,
          'veterinaryName': lstVaccines[i].veterinaryName,
        });
      }
    } else {
      print(_auth.currentUser!.uid.toString() +
          "/Animali/" + animalName + "/Vaccini/"+0.toString());
      DBRef.child(_auth.currentUser!.uid.toString() +
          "/Animali/" + animalName + "/Vaccini/"+0.toString())
          .set({
        'vaccineType': firstVaccine.vaccineType,
        'medicine': firstVaccine.medicine,
        'date': firstVaccine.date,
        'veterinaryName': firstVaccine.veterinaryName,
      });
    }
  }
}
