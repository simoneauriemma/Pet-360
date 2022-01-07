import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet360/components/widget_list2.dart';
import 'package:pet360/model/user_model.dart';

class ListUtenti extends StatefulWidget {
  const ListUtenti({Key? key}) : super(key: key);

  @override
  _ListUtentiState createState() => _ListUtentiState();
}

class _ListUtentiState extends State<ListUtenti> {
  Future<List<UserModel>>? futureListUser;

  @override
  void initState() {
    super.initState();
    futureListUser = getUserList("Utente", "", "");
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<List<UserModel>>(
      future: futureListUser,
      builder: (context, snapshot) {
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
                          "Utenti online in attesa di una risposta ",
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
                        itemBuilder: (_, int index) => WidgetList2(
                          name: snapshot.data![index].firstName!,
                          surname: snapshot.data![index].surnameName!,
                          UID: snapshot.data![index].uid!,
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
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Non ci sono richieste!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              color: Colors.black),
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
      });

  Future<List<UserModel>> getUserList(
      String typeOfUser, String uidUser, String path) async {
    var snapshot = await FirebaseFirestore.instance
        .collection("Messages")
        .where("receiver", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots();

    //print("snappppp" + snapshot.length.toString());
    List<String> chatOn = List.empty(growable: true);
    snapshot.forEach((element) {
      List<QueryDocumentSnapshot> x = element.docs;
      for (int i = 0; i < x.length; i++) {
        QueryDocumentSnapshot element = x[i];
        print(element["sender"]);
        chatOn.add(element["sender"].toString());
      }
    });

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
      List<UserModel> list = List.empty(growable: true);
      jsonDecode(response.body).forEach((key, value) {
        if (chatOn.contains(key.toString())) {
          UserModel user = UserModel();
          user.uid = key.toString();
          user.firstName = value['firstName'];
          user.surnameName = value['surnameName'];
          list.add(user);
        }
      });
      return list;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
