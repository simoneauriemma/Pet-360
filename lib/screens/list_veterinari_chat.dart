import 'dart:convert';

import 'package:accordion/accordion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet360/components/widget_list.dart';
import 'package:pet360/model/interface_model.dart';
import 'package:http/http.dart' as http;
import 'package:pet360/model/veterinary_model.dart';

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
                              Image.asset("assets/icons/injection.png",
                                  width: 20, height: 20),
                              //Text(" "+ generateNumber[index]+".", style: TextStyle(color: Colors.black, fontSize: 18.0)),
                              Padding(padding: EdgeInsets.only(left: 13)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data![index].firstName.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(snapshot.data![index].surnameName.toString(),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13.0)),
                                ],
                              )
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
              ),
            );
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
  Future<List<VeterinaryModel>> getVeterinaryList(String typeOfUser, String uidUser, String path) async{
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
        VeterinaryModel user = VeterinaryModel.fromJson(jsonDecode(response.body));
        list.add(user);
      });
      return list;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
