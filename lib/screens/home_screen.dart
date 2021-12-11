import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet360/screens/addnewanimal_screen.dart';
import 'package:pet360/screens/chat_screen.dart';
import 'package:pet360/screens/location_screen.dart';
import 'package:pet360/screens/profile_screen.dart';
import 'package:pet360/utils/usersharedpreferences.dart';
import 'dart:convert';
import 'dashboard.dart';
import 'package:http/http.dart' as http;
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();
  final _auth = FirebaseAuth.instance;
  var jsonBody;

  @override
  void initState() {
    super.initState();
    final uid = _auth.currentUser!.uid;
    if (UserSharedPreferences.getTypeOfUser() == "") {
      getData("Utente", uid.toString(), "");
      if (jsonBody == null) {
        getData("Addestratore", uid.toString(), "");
      }
      if (jsonBody == null) {
        getData("Veterinario", uid.toString(), "");
      }
    }
  }

  int index = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final List<Widget> screens = [
    Dashboard(),
    LocationScreen(),
    AddNewAnimalScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        color: Color.fromRGBO(197 ,225, 165, 5),
        backgroundColor: Colors.transparent,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white,),
          Icon(Icons.map, size: 30, color: Colors.white,),
          Icon(Icons.add, size: 30, color: Colors.white,),
          Icon(Icons.chat, size: 30, color: Colors.white,),
          Icon(Icons.account_box_rounded, size: 30, color: Colors.white,),
        ],
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            this.index=index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: screens[index],
    );
  }

  void LogOut() async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  //getData("User","uid","surnameName")
  getData(String typeOfUser, String uidUser, String path) async {
    var url = Uri.parse(
        "https://pet360-43dfe-default-rtdb.europe-west1.firebasedatabase.app//" +
            typeOfUser +
            "//" +
            uidUser +
            "//" +
            path +
            ".json?");
    //print("URL->>>>>>>" + url.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      jsonBody = json.decode(response.body);
      if (jsonBody != null) {
        UserSharedPreferences.setTypeOfUser(typeOfUser);
        //print("Settato: " + typeOfUser);
      }
      //print(jsonBody.toString());
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
