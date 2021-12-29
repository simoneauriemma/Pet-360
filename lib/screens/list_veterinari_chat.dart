import 'package:accordion/accordion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet360/components/widget_list.dart';
import 'package:pet360/model/interface_model.dart';

class ListVeterinariChat extends StatefulWidget {
  const ListVeterinariChat({Key? key}) : super(key: key);

  @override
  _ListVeterinariChatState createState() => _ListVeterinariChatState();
}

class _ListVeterinariChatState extends State<ListVeterinariChat> {
  Future<InterfaceModel>? futureListVet;

  @override
  Widget build(BuildContext context) => FutureBuilder<InterfaceModel>(
        future: futureListVet,
        builder: (context, snapshot) {
          //print("Snap: " + snapshot.toString() + jsonBody.toString());
          if (true) {
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
                      WidgetList(
                        name: "Veterinario 1",
                        shopname: "...",
                        voto: "...",
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      );
}
