import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pet360/components/show_message.dart';
import 'package:pet360/screens/review_chat_screen.dart';
import 'package:pet360/utils/usersharedpreferences.dart';

import 'home_screen.dart';

class Chatting_screen extends StatefulWidget {
  const Chatting_screen({Key? key}) : super(key: key);

  @override
  _Chatting_screenState createState() => _Chatting_screenState();
}

class _Chatting_screenState extends State<Chatting_screen> {
  final msgController = new TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var pickedImage;
  Future<bool>? fatto;

  var groupId;

  @override
  void initState() {
    super.initState();
    fatto = downloadFoto();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<bool>(
      future: fatto,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final msgText = TextFormField(
            autofocus: false,
            controller: msgController,
            keyboardType: TextInputType.name,
            onSaved: (value) {
              msgController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                hintText: "Scrivi qui...",
                hintStyle: TextStyle(color: Colors.black54),
                border: InputBorder.none),
          );
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              flexibleSpace: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(right: 16),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade300, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          color: Colors.grey.shade200,
                        ),
                        child: ClipOval(
                          child: pickedImage != null
                              ? Image.file(
                                  pickedImage!,
                                  width: 43,
                                  height: 43,
                                  fit: BoxFit.cover,
                                )
                              : SizedBox(
                                  width: 43.0,
                                  height: 43.0,
                                  child: Image.asset(
                                      "assets/icons/user_default.png"),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                UserSharedPreferences.getNameChat().toString() +
                                    " " +
                                    UserSharedPreferences.getSurnameChat()
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Online",
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(width: 70, height: 40),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(32.0))),
                                      title: Text(
                                        'Conferma',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.questrial(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: Text(
                                          'Sei sicuro di voler lasciare la chat?'),
                                      actions: [
                                        //"Si" button
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  if (UserSharedPreferences
                                                              .getTypeOfUser()
                                                          .toString() ==
                                                      "Utente") {
                                                    deleteChat();
                                                    Navigator.pop(context);

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ReviewChat()));
                                                  } else {
                                                    deleteChat();
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomeScreen()));
                                                  }
                                                },
                                                child: Text(
                                                  'Sì',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  // Close the dialog
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'No',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ))
                                          ],
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [                               
                                Icon(Icons.exit_to_app_sharp),
                                /* Text(
                                  "Lascia chat",
                                  style: TextStyle(
                                    fontSize: 11,
                                    //fontFamily: 'Texta',
                                  ),
                                ),*/
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.black,
                              primary: Colors.white,
                              alignment: Alignment.center,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Stack(
              children: <Widget>[
                //Image.asset("assets/icons/background.jpg",fit: BoxFit.cover),
                Padding(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/icons/background.jpg"),
                            fit: BoxFit.cover),
                      ),
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                          reverse: true, child: ShowMessages())),
                ),

                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        /* GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.lightGreen.shade200,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ), */
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: msgText,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            sendMessage();
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                          backgroundColor: Colors.lightGreen.shade200,
                          elevation: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        final msgText = TextFormField(
          autofocus: false,
          controller: msgController,
          keyboardType: TextInputType.name,
          onSaved: (value) {
            msgController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              hintText: "Scrivi qui...",
              hintStyle: TextStyle(color: Colors.black54),
              border: InputBorder.none),
        );
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            flexibleSpace: SafeArea(
              child: Container(
                padding: EdgeInsets.only(right: 16),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        color: Colors.grey.shade200,
                      ),
                      child: ClipOval(
                        child: pickedImage != null
                            ? Image.file(
                                pickedImage!,
                                width: 43,
                                height: 43,
                                fit: BoxFit.cover,
                              )
                            : SizedBox(
                                width: 43.0,
                                height: 43.0,
                                child: Image.asset(
                                    "assets/icons/user_default.png"),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              UserSharedPreferences.getNameChat().toString() +
                                  " " +
                                  UserSharedPreferences.getSurnameChat()
                                      .toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Online",
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 100, height: 40),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                return AlertDialog(
                                  title: Text(
                                    'Conferma',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Text(
                                      'Sei sicuro di voler lasciare la chat?'),
                                  actions: [
                                    //"Si" button
                                    TextButton(
                                        onPressed: () {
                                          // Remove the animal
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReviewChat()));
                                        },
                                        child: Text(
                                          'Sì',
                                          style: TextStyle(fontSize: 20),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          // Close the dialog
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'No',
                                          style: TextStyle(fontSize: 20),
                                        ))
                                  ],
                                );
                              });
                        },
                        /*child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "Lascia chat",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),                           
                          ],
                        ),*/
                         child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [                               
                                Icon(Icons.exit_to_app_sharp),
                                /* Text(
                                  "Lascia chat",
                                  style: TextStyle(
                                    fontSize: 11,
                                    //fontFamily: 'Texta',
                                  ),
                                ),*/
                              ],
                            ),
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.black,
                          primary: Colors.white,
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/icons/background.jpg"),
                        fit: BoxFit.cover),
                  ),
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                      reverse: true, child: ShowMessages())),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.lightGreen.shade200,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: msgText,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          sendMessage();
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                        backgroundColor: Colors.lightGreen.shade200,
                        elevation: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });

  Future<bool> downloadFoto() async {
    var url = Uri.parse(
        "https://pet360-43dfe-default-rtdb.europe-west1.firebasedatabase.app//" +
            UserSharedPreferences.getTypeOfUserChat().toString() +
            "//" +
            UserSharedPreferences.getUIDOfUser().toString() +
            ".json?");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonBody = json.decode(response.body);
      String path = jsonBody['photo'];
      pickedImage = File(path);
      return true;
    } else {
      throw Exception('Failed to load album');
    }
  }

  void deleteChat() async {
    groupId = _auth.currentUser!.uid.toString() +
        UserSharedPreferences.getUIDOfUser().toString();

    if (UserSharedPreferences.getTypeOfUser().toString() != "Utente") {
      groupId = UserSharedPreferences.getUIDOfUser().toString() +
          _auth.currentUser!.uid.toString();
    }
    //print("group id chat...." + groupId.toString());

    var querySnapshot = await _firestore
        .collection("Messages")
        .doc(groupId.toString())
        .collection(groupId.toString())
        .get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //print(allData[0]["time"]);
    // print(snapshot);
    for (int i = 0; i < allData.length; i++) {
      await _firestore
          .collection("Messages")
          .doc(groupId.toString())
          .collection(groupId.toString())
          .doc(allData[i]["time"])
          .delete();
    }

    await _firestore.collection("Messages").doc(groupId.toString()).delete();
  }

  void sendMessage() async {
    if (msgController.text.isNotEmpty) {
      groupId = _auth.currentUser!.uid.toString() +
          UserSharedPreferences.getUIDOfUser().toString();

      if (UserSharedPreferences.getTypeOfUser().toString() != "Utente") {
        groupId = UserSharedPreferences.getUIDOfUser().toString() +
            _auth.currentUser!.uid.toString();
      }

      //print(UserSharedPreferences.getFirstTimeChatting().toString());
      if (UserSharedPreferences.getFirstTimeChatting() == true) {
        await _firestore.collection("Messages").doc((groupId.toString())).set({
          "sender": _auth.currentUser!.uid,
          "receiver": UserSharedPreferences.getUIDOfUser()
        });
        UserSharedPreferences.setFirstTimeChatting(false);
      }

      /*_firestore.collection("Messages").doc(groupId.toString()).delete();*/
      _firestore
          .collection("Messages")
          .doc(groupId.toString())
          .collection(groupId.toString())
          .doc(DateTime.now().millisecondsSinceEpoch.toString())
          .set({
        "message": msgController.text.trim(),
        "sender": _auth.currentUser!.uid,
        "receiver": UserSharedPreferences.getUIDOfUser(),
        "time": DateTime.now().millisecondsSinceEpoch.toString()
      });

      /*_firestore.collection("Messages").doc().set({
        "message": msgController.text.trim(),
        "sender": _auth.currentUser!.uid,
        "receiver": UserSharedPreferences.getUIDOfUser(),
        "time": DateTime.now().toString()
      });*/

      msgController.clear();
    }
  }
}
