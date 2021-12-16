import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          bottom: const TabBar(tabs: [
            Tab(text: 'Veterinari', icon: Icon(Icons.account_circle)),
            Tab(text: 'Addestratori', icon: Icon(Icons.account_circle)),
          ]),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('lista veterinari disponibili')),
            Center(child: Text('lista addestratori disponibili')),
          ],
        ),
      ),
    );
  }
}
