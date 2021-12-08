import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddNewAnimalScreen extends StatefulWidget {
  const AddNewAnimalScreen({Key? key}) : super(key: key);

  @override
  _AddNewAnimalScreenState createState() => _AddNewAnimalScreenState();
}

class _AddNewAnimalScreenState extends State<AddNewAnimalScreen> {
  static const _headerStyle = TextStyle(color: Colors.black, fontSize: 25);
  static const _contentStyleHeader = TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  static const _contentStyle = TextStyle(
      color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal);

  final _formkey = GlobalKey<FormState>();

//campi di aggiunta info animale
  final nameController = new TextEditingController();
  final dataController = new TextEditingController();
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

  File? image;

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);

        if (image == null) return;

        final imageTemp = File(image.path);
        setState(() {
          this.image = imageTemp;
        });
      } on PlatformException catch (e) {
        print("Failed to pick image: $e");
      }
    }

    return Scaffold(
//build(context) => Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            children: <Widget>[
//lista di accordion
              Accordion(
//maxOpenSections: 3,
                headerPadding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                paddingListHorizontal: 40,
                paddingListTop: 30,
                headerBackgroundColor: Colors.grey.shade300,
                children: [
//AGGIUNTA INFO ANIMALE
                  AccordionSection(
                    isOpen: false,
                    //leftIcon: Image.asset("assets/icons/pawprint.png"),
                    header: const Text("Aggiungi le info\ndel tuo animale",
                        style: _headerStyle, textAlign: TextAlign.left),
                    content: Column(
                      children: <Widget>[
                        //aggiunta della foto dell'animale
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey.shade300,
                            child: ClipOval(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: IconButton(
                                  icon:
                                      Image.asset("assets/icons/add-photo.png"),
                                  color: Color.fromRGBO(10, 10, 10, 1),
                                  iconSize: 30,
                                  onPressed: () {
                                    getImage();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
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
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Nome",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
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
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Data di nascita",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
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
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Specie",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
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
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Razza",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
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
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Colore",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
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
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Nome veterinario",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                        ),
                      ],
                    ),
// contentHorizontalPadding: 40,
                    contentBorderWidth: 0,
                    contentBackgroundColor: Color.fromRGBO(236, 236, 236, 0.3),
// rightIcon: Icon(Icons.arrow_forward_ios_sharp, size: 40),
                    rightIcon: Image.asset("assets/icons/down-arrow.png"),
                  ),

//AGGIUNTA INFO VACCINI ANIMALE
                  AccordionSection(
                    isOpen: false,
//leftIcon: Image.asset("assets/icons/vaccine.png"),
                    header: const Text(
                        'Aggiungi le info\nsui vaccini del\ntuo animale',
                        style: _headerStyle,
                        textAlign: TextAlign.left),
                    content: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                            autofocus: false,
                            controller: tipoVaccinoController,
                            keyboardType: TextInputType.name,
                            onSaved: (value) {
                              tipoVaccinoController.text = value!;
                            },
                            textInputAction: TextInputAction.next,

                            //TipoVaccino
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Tipo vaccino",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            autofocus: false,
                            controller: dataSommController,
                            keyboardType: TextInputType.name,
                            onSaved: (value) {
                              dataSommController.text = value!;
                            },
                            textInputAction: TextInputAction.next,

                            //Data somministrazione vaccino
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Data somministrazione",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            autofocus: false,
                            controller: farmacoSommController,
                            keyboardType: TextInputType.name,
                            onSaved: (value) {
                              farmacoSommController.text = value!;
                            },
                            textInputAction: TextInputAction.next,

                            //Farmaco somministrato
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Farmaco somministrato",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            autofocus: false,
                            controller: nomeVeterController,
                            keyboardType: TextInputType.name,
                            onSaved: (value) {
                              nomeVeterController.text = value!;
                            },
                            textInputAction: TextInputAction.next,

                            //Nome veterinario
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Nome veterinario",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                        ),
                      ],
                    ),
// contentHorizontalPadding: 40,
                    contentBorderWidth: 0,
                    contentBackgroundColor: Color.fromRGBO(236, 236, 236, 0.3),
// rightIcon: Icon(Icons.arrow_forward_ios_sharp, size: 40),
                    rightIcon: Image.asset("assets/icons/down-arrow.png"),
                  ),

//AGGIUNTA INFO PASSAPORTO ANIMALE
                  AccordionSection(
                    isOpen: false,
//leftIcon: Image.asset("assets/icons/passport.png"),
                    header: const Text(
                        "Aggiungi le info\nsul passaporto\ndel tuo animale",
                        style: _headerStyle,
                        textAlign: TextAlign.left),
                    content: Column(
                      children: <Widget>[
                        Container(
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
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Descrizione animale",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
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
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "N° microchip",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
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
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Data applicazione microchip",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
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
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Ente rilasciante",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                        ),
                      ],
                    ),
// contentHorizontalPadding: 40,
                    contentBackgroundColor: Color.fromRGBO(236, 236, 236, 0.3),
                    contentBorderWidth: 0,
// rightIcon: Icon(Icons.arrow_forward_ios_sharp, size: 40),
                    rightIcon: Image.asset("assets/icons/down-arrow.png"),
                  ),

//AGGIUNTA DISPOSITIVI GEOLOCALIZZAZIONE
                  AccordionSection(
                    isOpen: false,
//leftIcon: Image.asset("assets/icons/geoloc.png"),
                    header: const Text(
                        "Aggiungi\ndispositivi per la\ngeolocalizzazione",
                        style: _headerStyle,
                        textAlign: TextAlign.left),
                    content: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Dispositivi disponibili:",
                          style: _contentStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextFormField(
                            autofocus: false,
                            controller: descrizioneController,
                            keyboardType: TextInputType.name,
                            onSaved: (value) {
                              descrizioneController.text = value!;
                            },
                            textInputAction: TextInputAction.next,

                            //AirTag1
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "AirTag1 ",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            autofocus: false,
                            controller: microchipController,
                            keyboardType: TextInputType.name,
                            onSaved: (value) {
                              microchipController.text = value!;
                            },
                            textInputAction: TextInputAction.next,

                            //AirTag2
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "AirTag2",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                        ),
                      ],
                    ),
                    contentHorizontalPadding: 40,
                    contentBorderWidth: 0,
                    contentBackgroundColor: Color.fromRGBO(236, 236, 236, 0.3),
                    rightIcon: Image.asset("assets/icons/down-arrow.png"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}