import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pet360/model/new_vaccine.dart';
import 'package:pet360/screens/dashboard.dart';
import 'package:pet360/screens/home_screen.dart';
import 'package:pet360/utils/usersharedpreferences.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

//import 'package:image/image.dart' as Img;
import 'package:path/path.dart' as Bho;

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
final dataController = TextEditingController();
final _auth = FirebaseAuth.instance;

class NavigatorView extends StatefulWidget {
  @override
  _viewInfoState createState() => _viewInfoState();
}

class _viewInfoState extends State<NavigatorView> {
  File? pickedImage;
  List<NewVaccine> lstVaccines = List.empty(growable: true);
  List<String> generateNumber = List.generate(10, (index) => "${index + 1}");
  NewVaccine firstVaccine = NewVaccine();
  var jsonBody, airTag1, airTag2;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  void imagePickerOption() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Scegli immagine da: "),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Row(children: [
                      Icon(Icons.camera_alt_rounded),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                      Text("Camera"),
                    ]),
                    onTap: () {
                      getImage(ImageSource.camera);
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Row(children: [
                      Icon(Icons.photo),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                      Text("Galleria"),
                    ]),
                    onTap: () {
                      getImage(ImageSource.gallery);
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Divider(
                    color: Colors.black,
                    //height: 20,
                    thickness: 2,
                    indent: 3,
                    endIndent: 3,
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Row(children: [
                      Icon(Icons.remove_circle, color: Colors.red),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                      Text("Rimuovi immagine",
                          style: TextStyle(color: Colors.red)),
                    ]),
                    onTap: () {
                      setState(() {
                        pickedImage = null;
                      });
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
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
  bool isLoading = false;

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
                       Row(     
                    mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                    crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,               
                    children:[
                      ElevatedButton(
              onPressed: () {
                showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Conferma'),
            content: Text('Sei sicuro di voler eliminare?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the animal
                  Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => Dashboard()));

                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('No'))
            ],
          );
        });
              },
              child: Row(
                children:  [
                  Text("Elimina animale: ",style: TextStyle(fontSize: 15),),
                      SizedBox(width: 4,),
                      Image.asset("assets/icons/delete.png", width: 23,height: 23,color: Colors.red),
                    ]  
              ),
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.black,
                primary: Colors.white,
                //onSurface: Colors.grey,
                //side: BorderSide(color: Colors.lightGreen, width: 2),
                //elevation: 5,
                minimumSize: Size(120, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
              ]
              ),
              SizedBox(height: 20,),
                  Container(
                      padding: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: 700,
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
                        SizedBox(height: 30,),                                      
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
                                              //child: Image.file(File(snapshot.data![index].pathImg.toString()),),
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
                                        color: Colors.black45,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                             
                                
                                Align(alignment: Alignment.centerRight,                                        
                                child: IconButton(
                                padding: EdgeInsets.only(right: 30),
                                icon: Image.asset("assets/icons/edit.png"),                                
                                onPressed: (){
                                    //
                                },
                                ),  
                              ),
                              
                              
                          
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
              width: MediaQuery.of(context).size.width / 1.1,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
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
                    height: 30,
                  ),
                  Text(
                    "LISTA VACCINI",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: this.lstVaccines.length,
                      shrinkWrap: true,
                      itemBuilder: (_, int index) => Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Card(
                          elevation: 2.0,
                          color: Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 15.0),
                            child: Row(
                              children: [
                                Padding(padding: EdgeInsets.only(left: 7)),
                                Image.asset("assets/icons/vaccine.png",
                                    width: 25, height: 25),
                                //Text(" "+ generateNumber[index]+".", style: TextStyle(color: Colors.black, fontSize: 18.0)),
                                Padding(padding: EdgeInsets.only(left: 13)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        " " +
                                            lstVaccines[index].vaccineType.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                        " " +
                                            lstVaccines[index].date.toString(),
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13.0)),
                                  ],
                                ),
                        SizedBox(width: 10,),                       
                        IconButton(
                         icon: Image.asset("assets/icons/edit.png"),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        SizedBox(
                                          width: 280,
                                          child: TextFormField(
                                              autofocus: false,
                                              controller: tipoVaccinoController,
                                              keyboardType: TextInputType.name,
                                              onSaved: (value) {
                                                tipoVaccinoController.text =
                                                    value!;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,

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
                                            },
                                            textInputAction:
                                                TextInputAction.next,

                                            //Data somministrazione vaccino
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              labelText:
                                                  "Data somministrazione",
                                            ),
                                            onTap: () async {
                                              var date = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime(2100));
                                              dataSommController.text = date
                                                  .toString()
                                                  .substring(0, 10);
                                            },
                                          ),
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
                                                farmacoSommController.text =
                                                    value!;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,

                                              //Farmaco somministrato
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.transparent,
                                                labelText:
                                                    "Farmaco somministrato",
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
                                                nomeVeterController.text =
                                                    value!;
                                              },
                                              textInputAction:
                                                  TextInputAction.next,

                                              //Nome veterinario
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.transparent,
                                                labelText: "Nome veterinario",
                                              )),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints.tightFor(
                                          width: 120, height: 40),
                                        child: ElevatedButton(
                                          onPressed: () {     
                                            //salva modifiche info vaccini                                       
                                            NewVaccine tmp = NewVaccine();
                                            tmp.veterinaryName =
                                                nomeVeterController.text;
                                            tmp.date = dataSommController.text;
                                            tmp.vaccineType =
                                                tipoVaccinoController.text;
                                            tmp.medicine =
                                                farmacoSommController.text;
                                            lstVaccines.add(tmp);
                                            nomeVeterController.text = "";
                                            dataSommController.text = "";
                                            tipoVaccinoController.text = "";
                                            farmacoSommController.text = "";
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          },

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: const [
                                              Text("Salva modifiche  "),
                                              ImageIcon(
                                                AssetImage(
                                                    "assets/icons/save.png"),
                                                color: Colors.black,
                                                size: 17,
                                              ),
                                            ],
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            onPrimary: Colors.black,
                                            primary: Colors.white,
                                            alignment: Alignment.center,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                        ),
                                    ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                                                      
                        ),
                      
                       ],
                       ),
                       ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
        Step(
            isActive: currentStep >= 2,
            title: Text(''),
            content: Column(
              children: [
                //TITOLO
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 440,
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
                      height: 30,
                    ),
                    Text(
                      "PASSAPORTO ANIMALE",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                      
                                Align(alignment: Alignment.centerRight,                                        
                                child: IconButton(
                                padding: EdgeInsets.only(right: 30),
                                icon: Image.asset("assets/icons/edit.png"),                                
                                onPressed: (){
                                    //
                                },
                                ),  
                              ),
                              SizedBox(height: 20,),
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
                        ),
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          dataMicrochipController.text =
                              date.toString().substring(0, 10);
                        },
                      ),
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
                    width: MediaQuery.of(context).size.width / 1.1,
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
                          "Dispositivi collegati:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text("AirTag1"),                         
                          IconButton(
                            icon: Image.asset("assets/icons/delete.png", width: 23,height: 23,color: Colors.red),
                            onPressed: (){
                                //
                          }),
                        ],),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text("AirTag2"),                         
                          IconButton(
                            icon: Image.asset("assets/icons/delete.png", width: 23,height: 23,color: Colors.red),
                            onPressed: (){
                                //
                          }),
                        ],),
                        
                       
                      ])
                    ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    saveData(
                        nameController.text,
                        dataController.text,
                        specieController.text,
                        razzaController.text,
                        coloreController.text,
                        veterinarioController.text,
                        descrizioneController.text,
                        microchipController.text,
                        dataMicrochipController.text,
                        enteController.text);
                    nameController.text = "";
                    dataController.text = "";
                    specieController.text = "";
                    razzaController.text = "";
                    coloreController.text = "";
                    veterinarioController.text = "";
                    descrizioneController.text = "";
                    microchipController.text = "";
                    dataMicrochipController.text = "";
                    enteController.text = "";
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
              ],
            )),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Modifica animale"),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()));
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

  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/'+filePath.split("/").last)
          .putFile(file);
    } on firebase_storage.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  saveData(
      String animalName,
      String animalBirthday,
      String animalSpecie,
      String animalKind,
      String animalColor,
      String animalVeterinaryName,
      String animalDescription,
      String animalMicrochip,
      String animalDateMicrochip,
      String entityIssuingAnimal) {
    String path = "";
    if (pickedImage != null) {
      path = pickedImage!.path;
      uploadFile(path);
    }

    final DBRef = FirebaseDatabase.instance
        .reference()
        .child(UserSharedPreferences.getTypeOfUser().toString());
    DBRef.child(_auth.currentUser!.uid.toString() +
            "/Animali/" +
            animalName +
            "/Libretto")
        .set({
      'animalFoto': path,
      'animalName': animalName,
      'animalBirthday': animalBirthday,
      'animalSpecie': animalSpecie,
      'animalKind': animalKind,
      'animalColor': animalColor,
      'animalVeterinaryName': animalVeterinaryName,
    });
    if (lstVaccines.isNotEmpty) {
      for (int i = 0; i < lstVaccines.length; i++) {
        DBRef.child(_auth.currentUser!.uid.toString() +
                "/Animali/" +
                animalName +
                "/Vaccini/" +
                i.toString())
            .set({
          'vaccineType': lstVaccines[i].vaccineType,
          'medicine': lstVaccines[i].medicine,
          'date': lstVaccines[i].date,
          'veterinaryName': lstVaccines[i].veterinaryName,
        });
      }
      if (nomeVeterController.text != "" ||
          dataSommController.text != "" ||
          tipoVaccinoController.text != "" ||
          farmacoSommController.text != "") {
        DBRef.child(_auth.currentUser!.uid.toString() +
                "/Animali/" +
                animalName +
                "/Vaccini/" +
                lstVaccines.length.toString())
            .set({
          'vaccineType': tipoVaccinoController.text,
          'medicine': farmacoSommController.text,
          'date': dataSommController.text,
          'veterinaryName': nomeVeterController.text,
        });
      }
      lstVaccines.clear();
    } else {
      if (nomeVeterController.text != "" ||
          dataSommController.text != "" ||
          tipoVaccinoController.text != "" ||
          farmacoSommController.text != "") {
        DBRef.child(_auth.currentUser!.uid.toString() +
                "/Animali/" +
                animalName +
                "/Vaccini/" +
                lstVaccines.length.toString())
            .set({
          'vaccineType': tipoVaccinoController.text,
          'medicine': farmacoSommController.text,
          'date': dataSommController.text,
          'veterinaryName': nomeVeterController.text,
        });
      }
    }
    DBRef.child(_auth.currentUser!.uid.toString() +
            "/Animali/" +
            animalName +
            "/Passaporto")
        .set({
      'animalDescription': animalDescription,
      'animalMicrochip': animalMicrochip,
      'animalDateMicrochip': animalDateMicrochip,
      'entityIssuingAnimal': entityIssuingAnimal,
    });
    DBRef.child(_auth.currentUser!.uid.toString() +
            "/Animali/" +
            animalName +
            "/Dispositivi")
        .set({
      'airTag1': airTag1,
      'airTag2': airTag2,
    });
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
