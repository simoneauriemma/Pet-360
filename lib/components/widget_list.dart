import 'dart:io';

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
  final String UID;
  final String typeOfUserChat;
  final String photo;

  WidgetList({
    required this.name,
    required this.surname,
    required this.shopname,
    required this.phonenum,
    required this.indirizzo,
    required this.voto,
    required this.UID,
    required this.typeOfUserChat,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          Container(
            //margin: EdgeInsets.only(left: 20, right: 20),
            width: MediaQuery.of(context).size.width / 1.1,
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0, right: 20.0),
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
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                      children:[
                        Container(
                          child: ClipOval(
                            child: Image.file(
                                File(photo),
                              width: 45,
                              height: 45,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                          content: Container(
                            height: MediaQuery.of(context).size.height / 3.2,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      name + " " + surname,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.lightGreen,
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 30)),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.shop,
                                                size: 15,
                                              ),
                                              Text("  Nome negozio: ",
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
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.local_phone_rounded,
                                                size: 15,
                                              ),
                                              Text("  Cellulare: ",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[800],
                                                  )),
                                              Text("+39 " + phonenum,
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.grey[800],
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.apartment_rounded,
                                                size: 15,
                                              ),
                                              Text("  Indirizzo: ",
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
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 15,
                                              ),
                                              Text("  Voto: ",
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
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    ConstrainedBox(
                                      constraints:
                                          const BoxConstraints.tightFor(
                                              width: 140, height: 50),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          UserSharedPreferences.setNameChat(
                                              name.toString());
                                          UserSharedPreferences.setSurnameChat(
                                              surname.toString());
                                          UserSharedPreferences.setUIDOfUser(
                                              UID);
                                          UserSharedPreferences
                                              .setTypeOfUserChat(
                                                  typeOfUserChat);
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Chatting_screen()),
                                                  (route) => false);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                              )),
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.info_outline_rounded,
                    size: 30,
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
        UserSharedPreferences.setSurnameChat(surname.toString());
        UserSharedPreferences.setUIDOfUser(UID);
        UserSharedPreferences.setTypeOfUserChat(typeOfUserChat);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Chatting_screen()),
            (route) => false);
      },
    );
  }
}
