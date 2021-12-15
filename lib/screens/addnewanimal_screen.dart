import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:pet360/screens/viewAnimal_screen.dart';
import 'package:getwidget/getwidget.dart';

class AddNewAnimalScreen extends StatefulWidget {
  const AddNewAnimalScreen({Key? key}) : super(key: key);

  @override
  _AddNewAnimalScreenState createState() => _AddNewAnimalScreenState();
}

class _AddNewAnimalScreenState extends State<AddNewAnimalScreen> {
  File? pickedImage;

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
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
                    icon: const Icon(Icons.camera_alt_rounded),
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

  getItemAndNavigate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => viewAnimal(
                  nameHolder: nameController.text,
                  dataHolder: dataController.text,
                  specieHolder: specieController.text,
                  razzaHolder: razzaController.text,
                  coloreHolder: coloreController.text,
                  veterinarioHolder: veterinarioController.text,
                  tipoVaccinoHolder: tipoVaccinoController.text,
                  dataSomminisHolder: dataSommController.text,
                  farmacoSommHolder: farmacoSommController.text,
                  nomeveterHolder: nomeVeterController.text,
                  descrizioneHolder: descrizioneController.text,
                  microchipHolder: microchipController.text,
                  dataMicrochipHolder: dataMicrochipController.text,
                  enteHolder: enteController.text,
                )));
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//build(context) => Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          children: <Widget>[
//icona_bottone_back
/*Container(
alignment: Alignment.topLeft,
padding: const EdgeInsets.only(left: 10 ,bottom: 5),
child: IconButton(
onPressed: (){
print("Pressed");
},
icon: Image.asset("assets/icons/back-button.png"),
iconSize: 40,
),
),*/

//lista di accordion
            Accordion(
//maxOpenSections: 3,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              paddingListHorizontal: 30,
              paddingListTop: 30,
              children: [
//AGGIUNTA INFO ANIMALE
                AccordionSection(
                  isOpen: false,
//leftIcon: Image.asset("assets/icons/pawprint.png"),
                  header: const Text("Aggiungi le info\ndel tuo animale",
                      style: _headerStyle, textAlign: TextAlign.left),
                  headerBackgroundColor: Colors.grey.shade300,
                  content: Column(
                    children: <Widget>[
//aggiunta della foto dell'animale
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 3),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  color: Colors.lightGreen.shade50,
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
                                          /*child: IconButton(
      icon : Image.asset("assets/icons/dog.png"),
      color: Color.fromRGBO(10, 10, 10, 1),
      onPressed: (){
        //getImage();
        imagePickerOption();
      },),*/
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
                                    Icons.add_a_photo,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ],
                          )

/*child: CircleAvatar(
radius: 50,
//backgroundImage: image==null? AssetImage("assets/icons/download.jpeg"): FileImage(File(image.path)),
child: ClipOval(
child: SizedBox(
width: 50.0,
height: 50.0,
child: IconButton(
icon : Image.asset("assets/icons/add-photo.png"),
color: Color.fromRGBO(10, 10, 10, 1),
iconSize: 30,
onPressed: (){
getImage();
},),
),
),
),*/
                          ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextField(
                          autofocus: false,
                          controller: nameController,
                          keyboardType: TextInputType.name,
/*onSaved: (value) {
nameController.text = value!;
},
textInputAction: TextInputAction.next,*/

//Nome
                          decoration: InputDecoration(
//prefixIcon: Image.asset("assets/icons/write.png"),
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
                  contentBorderWidth: 3,
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
                  headerBackgroundColor: Colors.grey.shade300,
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
                      SizedBox(
                        height: 30,
                      ),
//aggiungi altro vaccino
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 10, bottom: 5),
                        child: Column(children: <Widget>[
                          Text(
                            "Aggiungi un altro vaccino:",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          IconButton(
                            onPressed: () {
//
                            },
                            icon: Image.asset("assets/icons/plus.png"),
                            iconSize: 40,
                          ),
                        ]),
                      ),
                    ],
                  ),
// contentHorizontalPadding: 40,
                  contentBorderWidth: 3,
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
                  headerBackgroundColor: Colors.grey.shade300,
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
                  contentBorderWidth: 3,
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
                  headerBackgroundColor: Colors.grey.shade300,
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
                          child: ElevatedButton(
                        child: Text("AirTag1"),
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.black,
                          primary: Colors.white70,
                          onSurface: Colors.grey,
                          side: BorderSide(color: Colors.lightGreen, width: 2),
                          elevation: 10,
                          minimumSize: Size(120, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () {
                          GFToast.showToast('Dispositivo 1 aggiunto!', context,
                              toastPosition: GFToastPosition.BOTTOM,
                              textStyle:
                                  TextStyle(fontSize: 16, color: GFColors.DARK),
                              backgroundColor: Colors.green.shade300,
                              trailing: Icon(
                                Icons.notifications,
                                color: Colors.black,
                              ));
                        },
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          child: ElevatedButton(
                        child: Text("AirTag2"),
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.black,
                          primary: Colors.white70,
                          onSurface: Colors.grey,
                          side: BorderSide(color: Colors.lightGreen, width: 2),
                          elevation: 10,
                          minimumSize: Size(120, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () {
                          GFToast.showToast('Dispositivo 2 aggiunto!', context,
                              toastPosition: GFToastPosition.BOTTOM,
                              textStyle:
                                  TextStyle(fontSize: 16, color: GFColors.DARK),
                              backgroundColor: Colors.green.shade300,
                              trailing: Icon(
                                Icons.notifications,
                                color: Colors.black,
                              ));
                        },
                      )),
                    ],
                  ),
                  contentHorizontalPadding: 40,
                  contentBorderWidth: 3,
                  contentBackgroundColor: Color.fromRGBO(236, 236, 236, 0.3),
                  rightIcon: Image.asset("assets/icons/down-arrow.png"),
                ),
              ],
            ),

//bottone 'Salva'
            Container(
                child: ElevatedButton(
              child: Text("Salva"),
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.black,
                primary: Colors.white70,
                onSurface: Colors.grey,
                side: BorderSide(color: Colors.lightGreen, width: 2),
                elevation: 10,
                minimumSize: Size(120, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                getItemAndNavigate(context);
              },
            )),
          ],
        ),
      ),
    );
  }
}
