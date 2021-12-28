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
      if (true){
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
                primary: false,
                children: <Widget>[
                  WidgetList(
                    name: "Veterinario 1",
                    shopname: "...",
                    phonenum: "...",
                    indirizzo: "...",
                    voto: "....",
                  ),
                  WidgetList(
                    name: "Veterinatio 2",
                    shopname: "...",
                    phonenum: "...",
                    indirizzo: "...",
                    voto: "...",
                  ),

                ],
              ),
            ),
          ),
        );
      }
      // We can show the loading view until the data comes back.
      //debugPrint('Step 1, build loading widget');
      return SizedBox(
        height: MediaQuery.of(context).size.height / 1,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}
