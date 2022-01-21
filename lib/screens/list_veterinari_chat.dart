import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet360/components/widget_list.dart';
import 'package:pet360/model/veterinary_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ListVeterinariChat extends StatefulWidget {
  const ListVeterinariChat({Key? key}) : super(key: key);

  @override
  _ListVeterinariChatState createState() => _ListVeterinariChatState();
}

class _ListVeterinariChatState extends State<ListVeterinariChat> {
  Future<List<VeterinaryModel>>? futureListVet;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    futureListVet = getVeterinaryList("Veterinario", "", "");
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<List<VeterinaryModel>>(
        future: futureListVet,
        builder: (context, snapshot) {
          //print("Snap: " + snapshot.toString() + jsonBody.toString());
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.grey.shade100,
              body: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 10.0, top: 10.0),
                    primary: false,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Veterinari attualmente online ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 40)),
                          ImageIcon(
                            AssetImage("assets/icons/online.png"),
                            color: Colors.green,
                            size: 15,
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (_, int index) => WidgetList(
                            name: snapshot.data![index].firstName!,
                            surname: snapshot.data![index].surnameName!,
                            shopname: snapshot.data![index].nameShop!,
                            voto: snapshot.data![index].voto!.toString(),
                            phonenum: snapshot.data![index].numberPhone!,
                            indirizzo: snapshot.data![index].addressShop!,
                            UID: snapshot.data![index].uid!,
                            typeOfUserChat: "Veterinario",
                            photo: snapshot.data![index].photo!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 10.0, top: 10.0),
                  primary: false,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Veterinari attualmente online ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 40)),
                        ImageIcon(
                          AssetImage("assets/icons/online.png"),
                          color: Colors.green,
                          size: 15,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Non ci sono veterinari disponibili!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey.shade100),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 1,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

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

  Future<List<VeterinaryModel>> getVeterinaryList(
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
    if (response.statusCode == 200) {
      List<VeterinaryModel> list = List.empty(growable: true);
      jsonDecode(response.body).forEach((key, value) async {
        VeterinaryModel user = VeterinaryModel();
        user.uid = key.toString();
        user.nameShop = value['nameShop'];
        user.firstName = value['firstName'];
        user.surnameName = value['surnameName'];
        user.numberPhone = value['numberPhone'];
        user.addressShop = value['addressShop'];
        user.voto = double.parse(double.parse(value['votes'].toString()).toStringAsFixed(2));
        user.photo = value['photo'];
        await downloadFileExample(value['photo']);
        list.add(user);
      });
      return list;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
