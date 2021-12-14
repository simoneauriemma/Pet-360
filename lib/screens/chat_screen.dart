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
          backgroundColor: Colors.white,
          bottom: const TabBar(tabs: [
            Tab(text: 'Veterinari', icon: Icon(Icons.d)),
            Tab(text: 'Addestratori', icon: Icon(Icons.account_circle)),
          ]),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('ciao')),
            Center(child: Text('ciao1')),
          ],
        ),
      ),
    );
  }
}
