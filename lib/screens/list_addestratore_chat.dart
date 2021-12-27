import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet360/components/widget_list.dart';

class ListAddestratoriChat extends StatefulWidget {
  const ListAddestratoriChat({Key? key}) : super(key: key);

  @override
  _ListAddestratoriChatState createState() => _ListAddestratoriChatState();
}

class _ListAddestratoriChatState extends State<ListAddestratoriChat> {

  /*_listAddestratori() {
    return Positioned(
      top: 310,
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(0,1),
                blurRadius: 20.0,
                spreadRadius: 5,
              ),
            ]),

        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            children: [
              Row(
                children: [
                  Text("Nome"),
                  Text("..."),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
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
                name: "Addestratore 1",
                shopname: "...",
                phonenum: "...",
                indirizzo: "...",
                voto: "...",
              ),
              WidgetList(
                name: "Addestratore 2",
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
}
