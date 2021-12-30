import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet360/screens/list_addestratore_chat.dart';
import 'package:pet360/screens/list_veterinari_chat.dart';
import 'package:pet360/utils/usersharedpreferences.dart';

import 'home_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chat"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          elevation: 4,
          backgroundColor: Colors.white,
          bottom: TabBar(tabs: [
            Tab(text: 'Veterinari', icon: Image.asset("assets/icons/veterinario.png", height: 25, width: 25,)),
            Tab(text: 'Addestratori', icon: Image.asset("assets/icons/addestratore.png", height: 25, width: 25,)),
          ]),
        ),
        body: const TabBarView(
          children: [
            ListVeterinariChat(),
            ListAddestratoriChat(),
          ],
        ),
      ),
    );
  }
}
