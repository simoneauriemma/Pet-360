import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet360/model/user_model.dart';
import 'package:pet360/utils/usersharedpreferences.dart';

Future<UserModel> fetchUser(
    String typeOfUser, String uidUser, String path) async {
  var url = Uri.parse(
      "https://pet360-43dfe-default-rtdb.europe-west1.firebasedatabase.app//" +
          typeOfUser +
          "//" +
          uidUser +
          "//" +
          path +
          ".json?");
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return UserModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<UserModel>? futureUser;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    final uid = _auth.currentUser!.uid;

    futureUser =
        fetchUser(UserSharedPreferences.getTypeOfUser().toString(), uid, "");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<UserModel>(
            future: futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text("Nome->" +
                    snapshot.data!.firstName.toString() +
                    "\nCognome->" +
                    snapshot.data!.surnameName.toString() +
                    "\nCittà->" +
                    snapshot.data!.cityName.toString());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
