import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet360/components/widget_list.dart';
import 'package:pet360/model/trainer_model.dart';

class ListAddestratoriChat extends StatefulWidget {
  const ListAddestratoriChat({Key? key}) : super(key: key);

  @override
  _ListAddestratoriChatState createState() => _ListAddestratoriChatState();
}

class _ListAddestratoriChatState extends State<ListAddestratoriChat> {
  Future<List<TrainerModel>>? futureListVet;

  @override
  void initState() {
    super.initState();
    futureListVet = getAddestratoriList("Addestratore", "", "");
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<List<TrainerModel>>(
        future: futureListVet,
        builder: (context, snapshot) {
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
                            "Addestratori attualmente online ",
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
                            typeOfUserChat: "Addestratore",
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
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 10.0, top: 10.0),
                  primary: false,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Addestratori attualmente online ",
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
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Non ci sono addestratori disponibili!",
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
        },
      );

  Future<List<TrainerModel>> getAddestratoriList(
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
      List<TrainerModel> list = List.empty(growable: true);
      jsonDecode(response.body).forEach((key, value) {
        TrainerModel user = TrainerModel();
        //print(key.toString());
        user.uid = key.toString();
        user.nameShop = value['nameShop'];
        user.surnameName = value['surnameName'];
        user.firstName = value['firstName'];
        user.numberPhone = value['numberPhone'];
        user.addressShop = value['addressShop'];
        user.voto = double.parse(double.parse(value['votes'].toString()).toStringAsFixed(2));
        list.add(user);
      });
      return list;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
