import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet360/utils/usersharedpreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();
  final nameController = new TextEditingController();
  final surnameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final cityController = new TextEditingController();

  var jsonBody;
  @override
  void initState() {
    super.initState();
    final uid = _auth.currentUser!.uid;
    //per il click continuo
    if(jsonBody == null){
      getData(UserSharedPreferences.getTypeOfUser().toString(), uid, "");
    }
  }

  @override
  Widget build(BuildContext context)  => FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //debugPrint('Step 3, build widget: ${snapshot.data}');
          final nameField = TextFormField(
            autofocus: false,
            controller: nameController,
            keyboardType: TextInputType.name,
            onSaved: (value) {
              nameController.text = value!;
            },
            textInputAction: TextInputAction.next,

            //email decoration
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                prefixIcon: Icon(Icons.supervised_user_circle_outlined),
                hintText: jsonBody['firstName'].toString(),
                ),
          );

          final surnameField = TextFormField(
            autofocus: false,
            controller: surnameController,
            keyboardType: TextInputType.name,
            onSaved: (value) {
              surnameController.text = value!;
            },
            textInputAction: TextInputAction.next,

            //email decoration
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                prefixIcon: Icon(Icons.supervised_user_circle_outlined),
                hintText: jsonBody['surnameName'].toString(),
                ),
          );

          final emailField = TextFormField(
            autofocus: false,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) {
              emailController.text = value!;
            },
            textInputAction: TextInputAction.next,

            //email decoration
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                prefixIcon: Icon(Icons.mail),
                hintText: _auth.currentUser!.email,
                ),
          );

          final passwordField = TextFormField(
            autofocus: false,
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            onSaved: (value) {
              passwordController.text = value!;
            },
            textInputAction: TextInputAction.next,

            //email decoration
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                prefixIcon: Icon(Icons.password),
                hintText: "Password",
                ),
          );

          final cityField = TextFormField(
            autofocus: false,
            controller: cityController,
            keyboardType: TextInputType.name,
            onSaved: (value) {
              cityController.text = value!;
            },
            textInputAction: TextInputAction.done,

            //email decoration
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                prefixIcon: Icon(Icons.location_city),
                hintText: jsonBody['cityName'].toString(),
            ),
          );

          final logoutButton = Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            color: Colors.lightGreen.shade300,
            child: MaterialButton(
              padding: EdgeInsets.fromLTRB(20, 15, 15, 20),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {
                LogOut();
              },
              child: const Text(
                "Logout",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          );

          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                    key: _formkey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Profilo",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.lightGreen.shade100,
                                      offset: Offset(5.0, 5.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          nameField,
                          SizedBox(height: 20),
                          surnameField,
                          SizedBox(height: 20),
                          emailField,
                          SizedBox(height: 20),
                          passwordField,
                          SizedBox(height: 20),
                          cityField,
                          SizedBox(height: 40),
                          logoutButton,
                        ])),
              ),
            ),
          );
        } else {
          // We can show the loading view until the data comes back.
          //debugPrint('Step 1, build loading widget');
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );//TODO DA CAMBIARE
        }
     },
  );

  void LogOut() async {
    await _auth.signOut();
    UserSharedPreferences.setTypeOfUser("");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  getData(String typeOfUser, String uidUser, String path) async {
    var url = Uri.parse(
        "https://pet360-43dfe-default-rtdb.europe-west1.firebasedatabase.app//" +
            typeOfUser +
            "//" +
            uidUser +
            "//" +
            path +
            ".json?");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      //print(url);
      jsonBody = json.decode(response.body);
      //print(jsonBody);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  Future<bool> fetchData() => Future.delayed(Duration(seconds: 4), () {
    //debugPrint('Step 2, fetch data');
    return true;
  });
}
