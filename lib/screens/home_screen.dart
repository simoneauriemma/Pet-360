import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet360/model/interface_model.dart';
import 'package:pet360/model/trainer_model.dart';
import 'package:pet360/model/user_model.dart';
import 'package:pet360/model/veterinary_model.dart';
import 'package:pet360/screens/chat_screen.dart';
import 'package:pet360/screens/find_fiends.dart';
import 'package:pet360/screens/navigator_add.dart';
import 'package:pet360/screens/profile_screen.dart';
import 'package:pet360/utils/usersharedpreferences.dart';

import 'dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();
  final _auth = FirebaseAuth.instance;
  Future<InterfaceModel>? futureUser;
  int index = 0;

  var jsonBody;

  @override
  void initState() {
    super.initState();
    final uid = _auth.currentUser!.uid;
    futureUser =
        fetchUser(UserSharedPreferences.getTypeOfUser().toString(), uid, "");
  }

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> screens = [
    Dashboard(),
    FindFriends(),
    NavigatorAdd(),
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) => FutureBuilder<InterfaceModel>(
        future: futureUser,
        builder: (context, snapshot) {
          //print("Snap: " + snapshot.toString() + jsonBody.toString());
          if (snapshot.hasData) {
            UserSharedPreferences.setNameOfUser(snapshot.data!.getFirstName());
            return Scaffold(
              extendBody: true,
              bottomNavigationBar: CurvedNavigationBar(
                // color: Color.fromRGBO(197, 225, 165, 5),
                color: Colors.lightGreen.shade200,
                backgroundColor: Colors.transparent,
                items: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        size: 30,
                        color: Colors.white,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageIcon(
                        AssetImage("assets/icons/location.png"),
                        color: Colors.white,
                        size: 23,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Gps",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                      Text(
                        "Aggiungi",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageIcon(
                        AssetImage("assets/icons/bubble-chat.png"),
                        color: Colors.white,
                        size: 23,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Chat",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 30,
                        color: Colors.white,
                      ),
                      Text(
                        "Profilo",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
                animationCurve: Curves.easeInOut,
                animationDuration: Duration(milliseconds: 600),
                onTap: (index) {
                  setState(() {
                    this.index = index;
                  });
                },
                letIndexChange: (index) => true,
              ),
              body: screens[index],
            );
          }
          // We can show the loading view until the data comes back.
          //debugPrint('Step 1, build loading widget');
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );

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
    }
    //print("Settato: " + typeOfUser);
    //print(jsonBody.toString());
    else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<InterfaceModel> fetchUser(
      String typeOfUser, String uidUser, String path) async {
    //print(UserSharedPreferences.getTypeOfUser() == null);
    if (UserSharedPreferences.getTypeOfUser() == null ||
        UserSharedPreferences.getTypeOfUser().toString() == "") {
      await getData("Utente", uidUser, "");
      typeOfUser = "Utente";
      UserSharedPreferences.setTypeOfUser(typeOfUser);

      if (jsonBody == null) {
        await getData("Addestratore", uidUser, "");
        typeOfUser = "Addestratore";
        UserSharedPreferences.setTypeOfUser(typeOfUser);
      }
      if (jsonBody == null) {
        await getData("Veterinario", uidUser, "");
        typeOfUser = "Veterinario";
        UserSharedPreferences.setTypeOfUser(typeOfUser);
      }
    }

    var url = Uri.parse(
        "https://pet360-43dfe-default-rtdb.europe-west1.firebasedatabase.app//" +
            typeOfUser +
            "//" +
            uidUser +
            "//" +
            path +
            ".json?");
    //print(url);
    final response = await http.get(url);
    /*print("print->>>>" + json.decode(response.body));
    print("TypeOfUser->>" + UserSharedPreferences.getTypeOfUser().toString());*/

    if (response.statusCode == 200) {
      jsonBody = json.decode(response.body);
      //print(json.decode(response.body));
      if (json.decode(response.body) == null) {
        switch (typeOfUser) {
          case "Utente":
            return UserModel.fromJson(jsonDecode(response.body));
          case "Addestratore":
            return TrainerModel.fromJson(jsonDecode(response.body));
          case "Veterinario":
            return VeterinaryModel.fromJson(jsonDecode(response.body));
          default:
            return UserModel.fromJson(jsonDecode(response.body));
        }
      }
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      //print("testingggggg");
      throw Exception('Failed to load album');
    }
  }
}
