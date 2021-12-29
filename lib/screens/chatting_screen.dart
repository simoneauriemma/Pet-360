import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chatting_screen extends StatefulWidget {
  const Chatting_screen({Key? key}) : super(key: key);

  @override
  _Chatting_screenState createState() => _Chatting_screenState();
}

class _Chatting_screenState extends State<Chatting_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Chat"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
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
                children: <Widget>[
                  Text("Scrivi qui..."),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
