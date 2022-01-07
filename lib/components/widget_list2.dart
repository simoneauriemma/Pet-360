import 'package:flutter/material.dart';
import 'package:pet360/screens/chatting_screen.dart';
import 'package:pet360/utils/usersharedpreferences.dart';

class WidgetList2 extends StatelessWidget {
  final String name;
  final String surname;
  final String UID;
  final String typeOfUserChat;

  WidgetList2({
    required this.name,
    required this.surname,
    required this.UID,
    required this.typeOfUserChat,
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
                                //fontWeight: FontWeight.bold,
                                color: Colors.black,
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
