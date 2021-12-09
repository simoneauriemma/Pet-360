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

  String typeOfUser = '';

  var jsonBody;

  @override
  void initState() {
    super.initState();

    typeOfUser = UserSharedPreferences.getTypeOfUser() ?? '';
    final uid = _auth.currentUser!.uid;

    print("type Of User->" + typeOfUser.toString() + " \t UID ->" + uid);
    jsonBody = getData(typeOfUser, uid, "");
  }

  Widget build(BuildContext context) {
    /*print("jsonBody-->" + jsonBody.toString());
    print(jsonBody['firstName'].toString());*/

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
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.supervised_user_circle_outlined),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: jsonBody['firstName'].toString(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
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
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.supervised_user_circle_outlined),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: jsonBody['surnameName'].toString(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
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
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: _auth.currentUser!.email,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
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
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.password),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
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
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.location_city),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: jsonBody['cityName'].toString(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
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
  }

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
}
