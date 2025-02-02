import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet360/screens/list_addestratore_chat.dart';
import 'package:pet360/screens/list_utenti.dart';
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
    if (UserSharedPreferences.getTypeOfUser().toString() == "Utente") {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Chat",
              style: GoogleFonts.questrial(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            elevation: 4,
            backgroundColor: Colors.white,
            bottom: TabBar(tabs: [
              Tab(
                  child: Text(
                    "Veterinari",
                    style: GoogleFonts.questrial(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: Image.asset(
                    "assets/icons/veterinario.png",
                    height: 25,
                    width: 25,
                  )),
              Tab(
                  child: Text(
                    "Addestratori",
                    style: GoogleFonts.questrial(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: Image.asset(
                    "assets/icons/addestratore.png",
                    height: 25,
                    width: 25,
                  )),
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

    if (UserSharedPreferences.getTypeOfUser().toString() == "Veterinario") {
      return Scaffold(
        appBar: AppBar(
          title: Text("Chat"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          elevation: 4,
          backgroundColor: Colors.white,
        ),
        body: ListUtenti(),
      );
    }

    if (UserSharedPreferences.getTypeOfUser().toString() == "Addestratore") {
      return Scaffold(
        appBar: AppBar(
          title: Text("Chat"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          elevation: 4,
          backgroundColor: Colors.white,
        ),
        body: ListUtenti(),
      );
    }

    return Container();
  }
}
