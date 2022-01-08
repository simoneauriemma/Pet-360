import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pet360/model/view_animals_home.dart';
import 'package:pet360/utils/usersharedpreferences.dart';
import 'package:pet360/screens/home_screen.dart';
import 'ia_screen.dart';
import 'navigator_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<List<ViewAnimalsHome>>? futureAnimal;
  File? pickedImage;
  final _auth = FirebaseAuth.instance;
  String _firstName = "Utente";

  @override
  void initState() {
    super.initState();
    final uid = _auth.currentUser!.uid;
    futureAnimal = fetchAnimals(
        UserSharedPreferences.getTypeOfUser().toString(), uid, "Animali");
    downloadFileExample("/data/user/0/com.example.pet360/cache/dog.png");
    _firstName = UserSharedPreferences.getNameOfUser()!;
  }

  Future<void> removePhoto(String filePath) async {
    try {
      if (filePath.split("/").last != "dog.png") {
        await firebase_storage.FirebaseStorage.instance
            .ref('uploads/' + filePath.split("/").last)
            .delete();
      }
    } on firebase_storage.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

   removeAnimal() {
    final DBRef = FirebaseDatabase.instance
        .reference()
        .child(UserSharedPreferences.getTypeOfUser().toString());
    DBRef.child(_auth.currentUser!.uid.toString() +
            "/Animali/" +
            UserSharedPreferences.getAnimalName().toString())
        .remove();
    if (pickedImage != null) {
      removePhoto(pickedImage!.path);
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<List<ViewAnimalsHome>>(
      future: futureAnimal,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Size size = MediaQuery.of(context).size;
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.lightGreen.shade200,
                          Colors.lightGreen.shade100,
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
                    height: size.height * 0.25,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          height: size.height * 0.3 - 27,
                          child: Row(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 60)),
                                  Text(
                                    "Bentornato",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.questrial(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                      _firstName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      IAscreen()));
                                        },
                                        // Image tapped
                                        child: Image.asset(
                                          "assets/icons/ped-id.png",
                                          width: 55,
                                          height: 50,
                                          colorBlendMode: BlendMode.multiply,
                                        ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 55,
                  ),
                  Text(
                    "Lista dei tuoi animali",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.questrial(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NavigatorView()));
                              UserSharedPreferences.setAnimalName(
                                  snapshot.data![index].animalName!);
                            },
                            onLongPress: (){
                              showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(32.0))),
                                title: Text(
                                  'Eliminazione animale',
                                  textAlign: TextAlign.center,
                                ),
                                content: Text(
                                  'Sei sicuro di voler eliminare?',
                                  textAlign: TextAlign.center,
                                ),
                                actions: [
                                  // The "Yes" button
                                  TextButton(
                                    onPressed: () {
                                      // Remove the animal
                                     /* removeAnimal();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));*/
                                        setState(() {
                                          snapshot.data!.removeAt(index);
                                          Navigator.of(context).pop();
                                        });
                                    },
                                    child: Text(
                                      'Sì',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        // Close the dialog
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'No',
                                        style: TextStyle(fontSize: 20),
                                      ))
                                ],
                              );
                            });
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: Image.file(
                                      File(snapshot.data![index].pathImg
                                          .toString()),
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  //child: Image.asset("assets/icons/download.jpeg", width: 50, height: 50, fit: BoxFit.cover),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data![index].animalName.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        "assets/storyset/homeimg.png",
                        height: size.width / 2,
                        width: size.width / 2,
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.only(
                            left: 0, right: 0, top: 0, bottom: 80)),
                  ],
                ),
              ),
          );
        }
        Size size = MediaQuery.of(context).size;
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.lightGreen.shade200,
                        Colors.lightGreen.shade100,
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
                  height: size.height * 0.25,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        height: size.height * 0.3 - 27,
                        child: Row(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(top: 60)),
                                Text(
                                  "Benvenuto",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.questrial(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                    _firstName,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 20),
                                ),
                                ],
                              ),
                              Spacer(),
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    IAscreen()));
                                      },
                                      // Image tapped
                                      child: Image.asset(
                                        "assets/icons/ped-id.png",
                                        width: 55,
                                        height: 50,
                                        colorBlendMode: BlendMode.multiply,
                                      ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 55,
                ),
                Text(
                  "Lista dei tuoi animali",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.questrial(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Clicca su '+' per aggiungere un animale da gestire!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      "assets/storyset/homeimg.png",
                      height: size.width / 2,
                      width: size.width / 2,
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(
                          left: 0, right: 0, top: 0, bottom: 80)),
                ],
              ),
            ),
        );
      });
}

Future<void> downloadFileExample(String path) async {
  File downloadToFile = File(path);
  if (downloadToFile.existsSync()) {
    return;
  }
  try {
    await firebase_storage.FirebaseStorage.instance
        .ref('uploads/' + path.split("/").last)
        .writeToFile(downloadToFile);
  } on firebase_storage.FirebaseException catch (e) {}
}

Future<List<ViewAnimalsHome>> fetchAnimals(
    String typeOfUser, String uidUser, String path) async {
  var url = Uri.parse(
      "https://pet360-43dfe-default-rtdb.europe-west1.firebasedatabase.app//" +
          typeOfUser +
          "//" +
          uidUser +
          "//" +
          path +
          ".json?");
  final response = await http.get(url);
  List<ViewAnimalsHome> list = List.empty(growable: true);
  if (response.statusCode == 200) {
    jsonDecode(response.body).forEach((key, value) async {
      await downloadFileExample(value["Libretto"]["animalFoto"]);
      ViewAnimalsHome animal = ViewAnimalsHome();
      animal.animalName = key;
      animal.pathImg = value["Libretto"]["animalFoto"];
      list.add(animal);
    });
    return list;
  } else {
    throw Exception('Failed to load album');
  }
}
