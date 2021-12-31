import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class ReviewChat extends StatefulWidget {
  const ReviewChat({Key? key}) : super(key: key);

  @override
  _ReviewChatState createState() => _ReviewChatState();
}

class _ReviewChatState extends State<ReviewChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Valuta la conversazione"),
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
    );
  }
}
