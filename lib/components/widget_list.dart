import 'package:flutter/material.dart';
import 'package:pet360/screens/chatting_screen.dart';
import 'package:pet360/utils/usersharedpreferences.dart';

class WidgetList extends StatelessWidget {
  final String name;
  final String surname;
  final String shopname;
  final String voto;
  final String phonenum;
  final String indirizzo;

  WidgetList({
    required this.name,
    required this.surname,
    required this.shopname,
    required this.phonenum,
    required this.indirizzo,
    required this.voto,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          Container(
            //margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0, right: 20),
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
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Icon(
                    Icons.account_circle,
                    size: 40.0,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              name + " " + surname,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text("Nome negozio: ",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                    )),
                                Text("$shopname",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey[800],
                                    )),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text("Voto: ",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                    )),
                                Text("$voto",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey[800],
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /*ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 60, height: 40),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            Chatting_screen()),
                        (route) => false);
              },
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage("assets/icons/messager2.png"),
                    color: Colors.black,
                    size: 25,
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
               // onPrimary: Colors.black,
                shadowColor: Colors.transparent,
                primary: Colors.white,
              ),
            ),
          ), */
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 50, height: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            //title: Text("Informazioni"),
                            content: Container(
                              height: 190.0,
                              child: Column(
                                children: [
                                  Text(
                                    name + " " + surname,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.lightGreen,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 30)),
                                  Row(
                                    children: [
                                      Text("Nome negozio:",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800],
                                          )),
                                      Text(shopname,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.grey[800],
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Cellulare: ",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800],
                                          )),
                                      Text(phonenum,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.grey[800],
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Indirizzo: ",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800],
                                          )),
                                      Text(indirizzo,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.grey[800],
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Voto: ",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800],
                                          )),
                                      Text(voto,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.grey[800],
                                          )),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                  ),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints.tightFor(
                                        width: 120, height: 40),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        UserSharedPreferences.setNameChat(
                                            name.toString());
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Chatting_screen()),
                                                (route) => false);
                                      },
                                      child: Row(
                                        children: const [
                                          Text("Chatta ora  "),
                                          ImageIcon(
                                            AssetImage(
                                                "assets/icons/messager2.png"),
                                            color: Colors.black,
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        onPrimary: Colors.black,
                                        primary: Colors.white,
                                        minimumSize: Size(40, 40),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      children: const [
                        ImageIcon(
                          AssetImage("assets/icons/information.png"),
                          color: Colors.black,
                          size: 18,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
        ],
      ),
      onTap: () {
        UserSharedPreferences.setNameChat(name.toString());
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Chatting_screen()),
            (route) => false);
      },
    );
  }
}
