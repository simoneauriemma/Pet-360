import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet360/model/interface_model.dart';
import 'package:pet360/model/trainer_model.dart';
import 'package:pet360/model/user_model.dart';
import 'package:pet360/model/veterinary_model.dart';
import 'package:pet360/utils/usersharedpreferences.dart';
import 'package:getwidget/getwidget.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  Future<InterfaceModel>? futureUser;

  final _formkey = GlobalKey<FormState>();
  final nameController = new TextEditingController();
  final surnameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final cityController = new TextEditingController();
  final phoneNumberController = new TextEditingController();
  final nameShopController = new TextEditingController();
  final cityShopController = new TextEditingController();
  final addressShopController = new TextEditingController();

  var jsonBody;

  @override
  void initState() {
    super.initState();
    final uid = _auth.currentUser!.uid;

    futureUser =
        fetchUser(UserSharedPreferences.getTypeOfUser().toString(), uid, "");
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<InterfaceModel>(
        future: futureUser,
        builder: (context, snapshot) {
          //print("Snap: " + snapshot.toString() + jsonBody.toString());
          if (snapshot.hasData) {
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
                hintText: snapshot.data!.getFirstName(),
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
                hintText: snapshot.data!.getSurnameName(),
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
                hintText: snapshot.data!.getCityName(),
              ),
            );

            final modifyButton = Material(
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  Modify(
                      nameController.text,
                      surnameController.text,
                      emailController.text,
                      cityController.text,
                      phoneNumberController.text,
                      nameShopController.text,
                      cityShopController.text,
                      addressShopController.text);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.border_color_rounded, color: Colors.black54),
                    onPressed: () {
                      Modify(
                          nameController.text,
                          surnameController.text,
                          emailController.text,
                          cityController.text,
                          phoneNumberController.text,
                          nameShopController.text,
                          cityShopController.text,
                          addressShopController.text);
                    },
                  ),
                ),
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
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );

            if (UserSharedPreferences.getTypeOfUser().toString() == "Utente") {
              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: Text("Profilo"),
                  centerTitle: true,
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
                              modifyButton,
                              SizedBox(height: 20),
                              nameField,
                              SizedBox(height: 20),
                              surnameField,
                              SizedBox(height: 20),
                              emailField,
                              SizedBox(height: 20),
                              cityField,
                              SizedBox(height: 60),
                              logoutButton,
                            ])),
                  ),
                ),
              );
            }

            final phoneNumber = TextFormField(
              autofocus: false,
              controller: phoneNumberController,
              keyboardType: TextInputType.name,
              onSaved: (value) {
                phoneNumberController.text = value!;
              },
              textInputAction: TextInputAction.done,

              //email decoration
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                prefixIcon: Icon(Icons.phone),
                hintText: snapshot.data!.getPhoneNumber(),
              ),
            );

            final nameShop = TextFormField(
              autofocus: false,
              controller: nameShopController,
              keyboardType: TextInputType.name,
              onSaved: (value) {
                nameShopController.text = value!;
              },
              textInputAction: TextInputAction.done,

              //email decoration
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                prefixIcon: Icon(Icons.shop),
                hintText: snapshot.data!.getNameShop(),
              ),
            );

            final cityShop = TextFormField(
              autofocus: false,
              controller: cityShopController,
              keyboardType: TextInputType.name,
              onSaved: (value) {
                cityShopController.text = value!;
              },
              textInputAction: TextInputAction.done,

              //email decoration
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                prefixIcon: Icon(Icons.apartment_rounded),
                hintText: snapshot.data!.getCityShop(),
              ),
            );

            final addressShop = TextFormField(
              autofocus: false,
              controller: addressShopController,
              keyboardType: TextInputType.name,
              onSaved: (value) {
                addressShopController.text = value!;
              },
              textInputAction: TextInputAction.done,

              //email decoration
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                prefixIcon: Icon(Icons.home),
                hintText: snapshot.data!.getAddressShop(),
              ),
            );

            if (UserSharedPreferences.getTypeOfUser().toString() ==
                "Veterinario") {
              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text("Profilo"),
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
                              modifyButton,
                              SizedBox(height: 20),
                              nameField,
                              SizedBox(height: 20),
                              surnameField,
                              SizedBox(height: 20),
                              emailField,
                              SizedBox(height: 20),
                              cityField,
                              SizedBox(height: 20),
                              phoneNumber,
                              SizedBox(height: 20),
                              nameShop,
                              SizedBox(height: 20),
                              cityShop,
                              SizedBox(height: 20),
                              addressShop,
                              SizedBox(height: 40),
                              logoutButton,
                            ])),
                  ),
                ),
              );
            }
            if (UserSharedPreferences.getTypeOfUser().toString() ==
                "Addestratore") {
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
                              modifyButton,
                              SizedBox(height: 20),
                              nameField,
                              SizedBox(height: 20),
                              surnameField,
                              SizedBox(height: 20),
                              emailField,
                              SizedBox(height: 20),
                              cityField,
                              SizedBox(height: 20),
                              phoneNumber,
                              SizedBox(height: 20),
                              nameShop,
                              SizedBox(height: 20),
                              cityShop,
                              SizedBox(height: 20),
                              addressShop,
                              SizedBox(height: 60),
                              logoutButton,
                            ])),
                  ),
                ),
              );
            }
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
                            modifyButton,
                            SizedBox(height: 20),
                            nameField,
                            SizedBox(height: 20),
                            surnameField,
                            SizedBox(height: 20),
                            emailField,
                            SizedBox(height: 20),
                            cityField,
                            SizedBox(height: 60),
                            logoutButton,
                          ])),
                ),
              ),
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

  void LogOut() async {
    await _auth.signOut();
    UserSharedPreferences.setTypeOfUser("");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void Modify(
      String nome,
      String cognome,
      String email,
      String citta,
      String numberPhone,
      String nameShop,
      String cityShop,
      String addressShop) async {
    if (email != "") {
      GFToast.showToast('Non è possibile modificare la mail', context,
          toastPosition: GFToastPosition.BOTTOM,
          textStyle: TextStyle(fontSize: 16, color: GFColors.DARK),
          backgroundColor: Colors.red,
          trailing: Icon(
            Icons.notifications,
            color: Colors.black,
          ));
      emailController.text = "";
      return;
    }
    if (nome.isNotEmpty) {
      if (nome != jsonBody['firstName'].toString()) {
        final DBRef = FirebaseDatabase.instance
            .reference()
            .child(UserSharedPreferences.getTypeOfUser().toString());
        DBRef.child(_auth.currentUser!.uid.toString()).update({
          'firstName': nome,
        });
      }
    }
    if (cognome.isNotEmpty) {
      if (cognome != jsonBody['surnameName'].toString()) {
        final DBRef = FirebaseDatabase.instance
            .reference()
            .child(UserSharedPreferences.getTypeOfUser().toString());
        DBRef.child(_auth.currentUser!.uid.toString()).update({
          'surnameName': cognome,
        });
      }
    }
    if (citta.isNotEmpty) {
      if (citta != jsonBody['cityName'].toString()) {
        final DBRef = FirebaseDatabase.instance
            .reference()
            .child(UserSharedPreferences.getTypeOfUser().toString());
        DBRef.child(_auth.currentUser!.uid.toString()).update({
          'cityName': citta,
        });
      }
    }
    if (numberPhone.isNotEmpty) {
      if (numberPhone != jsonBody['numberPhone'].toString()) {
        final DBRef = FirebaseDatabase.instance
            .reference()
            .child(UserSharedPreferences.getTypeOfUser().toString());
        DBRef.child(_auth.currentUser!.uid.toString()).update({
          'numberPhone': numberPhone,
        });
      }
    }
    if (nameShop.isNotEmpty) {
      if (nameShop != jsonBody['nameShop'].toString()) {
        final DBRef = FirebaseDatabase.instance
            .reference()
            .child(UserSharedPreferences.getTypeOfUser().toString());
        DBRef.child(_auth.currentUser!.uid.toString()).update({
          'nameShop': nameShop,
        });
      }
    }
    if (cityShop.isNotEmpty) {
      if (cityShop != jsonBody['cityShop'].toString()) {
        final DBRef = FirebaseDatabase.instance
            .reference()
            .child(UserSharedPreferences.getTypeOfUser().toString());
        DBRef.child(_auth.currentUser!.uid.toString()).update({
          'cityShop': cityShop,
        });
      }
    }
    if (addressShop.isNotEmpty) {
      if (addressShop != jsonBody['addressShop'].toString()) {
        final DBRef = FirebaseDatabase.instance
            .reference()
            .child(UserSharedPreferences.getTypeOfUser().toString());
        DBRef.child(_auth.currentUser!.uid.toString()).update({
          'addressShop': addressShop,
        });
      }
    }
    //TODO COME REFRESHO?
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    return;
  }

  /*getData(String typeOfUser, String uidUser, String path) async {
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
  }*/

  Future<InterfaceModel> fetchUser(
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
      jsonBody = json.decode(response.body);
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
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<bool> fetchData() => Future.delayed(Duration(seconds: 5), () {
        //debugPrint('Step 2, fetch data');
        return true;
      });
}
