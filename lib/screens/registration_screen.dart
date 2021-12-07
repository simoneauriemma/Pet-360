import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pet360/components/appBackground.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet360/model/trainer_model.dart';
import 'package:pet360/model/user_model.dart';
import 'package:pet360/model/veterinary_model.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController controllerUsername = new TextEditingController();

  var jsonBody;

  @override
  void initState() {
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  final nameController = new TextEditingController();
  final surnameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final cityController = new TextEditingController();
  final _auth = FirebaseAuth.instance;
  final shopNameController = new TextEditingController();
  final phoneNumberController = new TextEditingController();
  final cityShopController = new TextEditingController();
  final shopAddressController = new TextEditingController();

  //Radio buttons
  //final TextEditingController _textEditingController= new TextEditingController();
  bool radioChecked = false;
  var userType = 'veterinario';
  bool checkBoxChecked = false;
  bool checkBoxChecked2 = false;

  //TextEditingController controllerUsername = new TextEditingController();

  Widget build(BuildContext context) {
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
          hintText: "Nome",
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
          hintText: "Cognome",
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
          hintText: "Email",
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
          hintText: "Città",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );

    final regButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: Colors.lightGreen,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 15, 20),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          //String email, String password, String firstName,
          //       String surnameName, String cityName, typeOfUser
          var typeOfUser;
          if (checkBoxChecked) {
            typeOfUser = 1;
          } else if (checkBoxChecked2) {
            typeOfUser = 2;
          } else {
            typeOfUser = 0;
          }
          SignUp(
              emailController.text,
              passwordController.text,
              nameController.text,
              surnameController.text,
              cityController.text,
              typeOfUser);
        },
        child: Text(
          "Registrati",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final shopNameField = TextFormField(
      autofocus: false,
      controller: shopNameController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        shopNameController.text = value!;
      },
      textInputAction: TextInputAction.next,

      //email decoration
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.shop),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Nome negozio",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );

    final phoneNumberField = TextFormField(
      autofocus: false,
      controller: phoneNumberController,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        phoneNumberController.text = value!;
      },
      textInputAction: TextInputAction.next,

      //email decoration
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Numero di telefono",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );

    final cityShopField = TextFormField(
      autofocus: false,
      controller: cityShopController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        cityShopController.text = value!;
      },
      textInputAction: TextInputAction.next,

      //email decoration
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.apartment_rounded),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Città",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );

    final shopAddressField = TextFormField(
      autofocus: false,
      controller: shopAddressController,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        shopAddressController.text = value!;
      },
      textInputAction: TextInputAction.done,

      //email decoration
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.home),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Indirizzo",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );

    return AppBackground(
      child: Scaffold(
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
                      SizedBox(
                          height: 200,
                          child: Image.asset(
                            "assets/icons/logoPet360.png",
                            fit: BoxFit.contain,
                          )),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Registrazione",
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
                      SizedBox(height: 20),
                      Wrap(
                        children: [
                          Row(children: [
                            Checkbox(
                              value: this.checkBoxChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  this.checkBoxChecked = value!;
                                  checkBoxChecked2 = false;
                                });
                              },
                            ),
                            Text(
                              "Sono un veterinario",
                              style: TextStyle(fontSize: 18),
                            ),
                          ]),
                          Row(children: [
                            Checkbox(
                              value: this.checkBoxChecked2,
                              onChanged: (bool? value) {
                                setState(() {
                                  this.checkBoxChecked2 = value!;
                                  checkBoxChecked = false;
                                });
                              },
                            ),
                            Text(
                              "Sono un addestratore",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ]),

                          (checkBoxChecked || checkBoxChecked2)
                              ? Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(height: 20),
                                      Text(
                                        "Informazioni aggiuntive",
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
                                      SizedBox(height: 10),
                                      shopNameField,
                                      SizedBox(height: 20),
                                      phoneNumberField,
                                      SizedBox(height: 20),
                                      cityShopField,
                                      SizedBox(height: 20),
                                      shopAddressField,
                                      SizedBox(height: 40)
                                    ],
                                  ),
                                )
                              : Column(),

                          //bottone "registrazione"

                          regButton,
                        ],
                      ),
                    ])),
          ),
        ),
      ),
    );
  }

  void SignUp(String email, String password, String firstName,
      String surnameName, String cityName, typeOfUser) async {
    switch (typeOfUser) {
      case 0:
        {
          UserModel user = UserModel(
              email: email,
              firstName: firstName,
              surnameName: surnameName,
              cityName: cityName,
              address: "prova",
              //TODO DA CAMBIARE
              typeOfUser: typeOfUser);
          final DBRef = FirebaseDatabase.instance.reference().child("Utente");
          getData();
          //var document = getData();
          // document.getEmail();
          await _auth
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((uid) => {
                    user.uid = _auth.currentUser!.uid,
                    //ONLY FOR TESTING!!!!!
                    print("\n TESTING UID  " + user.uid.toString() + "\n"),
                    DBRef.child(user.uid.toString()).set({
                      'firstName': user.firstName,
                      'surnameName': user.surnameName,
                      'cityName': user.cityName,
                      'address': user.address,
                    }),

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen())),
                  })
              .catchError((e) {});
        }
        break;
      case 1:
        {
          VeterinaryModel veterinaryModel = VeterinaryModel(
              email: email,
              firstName: firstName,
              surnameName: surnameName,
              cityName: cityName,
              typeOfUser: typeOfUser,
              nameShop: shopNameController.text,
              numberPhone: phoneNumberController.text,
              cityShop: cityShopController.text,
              addressShop: shopAddressController.text);
          final DBRef =
              FirebaseDatabase.instance.reference().child("Veterinario");
          await _auth
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((uid) => {
                    veterinaryModel.uid = _auth.currentUser!.uid,
                    //ONLY FOR TESTING!!!!!
                    print("\n TESTING UID  " +
                        veterinaryModel.uid.toString() +
                        "\n"),
                    DBRef.child(veterinaryModel.uid.toString()).set({
                      'firstName': veterinaryModel.firstName,
                      'surnameName': veterinaryModel.surnameName,
                      'cityName': veterinaryModel.cityName,
                      'address': veterinaryModel.address,
                      'nameShop': veterinaryModel.nameShop,
                      'numberPhone': veterinaryModel.numberPhone,
                      'cityShop': veterinaryModel.cityShop,
                      'addressShop': veterinaryModel.addressShop,
                    }),

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen())),
                  })
              .catchError((e) {});
        }
        break;
      case 2:
        {
          TrainerModel trainerModel = TrainerModel(
              email: email,
              firstName: firstName,
              surnameName: surnameName,
              cityName: cityName,
              typeOfUser: typeOfUser,
              nameShop: shopNameController.text,
              numberPhone: phoneNumberController.text,
              cityShop: cityShopController.text,
              addressShop: shopAddressController.text);
          final DBRef =
              FirebaseDatabase.instance.reference().child("Addestratore");
          await _auth
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((uid) => {
                    trainerModel.uid = _auth.currentUser!.uid,
                    //ONLY FOR TESTING!!!!!
                    print("\n TESTING UID  " +
                        trainerModel.uid.toString() +
                        "\n"),
                    DBRef.child(trainerModel.uid.toString()).set({
                      'firstName': trainerModel.firstName,
                      'surnameName': trainerModel.surnameName,
                      'cityName': trainerModel.cityName,
                      'address': trainerModel.address,
                      'nameShop': trainerModel.nameShop,
                      'numberPhone': trainerModel.numberPhone,
                      'cityShop': trainerModel.cityShop,
                      'addressShop': trainerModel.addressShop,
                    }),
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen())),
                  })
              .catchError((e) {});
        }
        break;
      default:
        {
          print("This is default case");
        }
        break;
    }
  }

  //SINGOLO ELEMENTO
  /*Future<String> getEmail() async {
    String result = (await FirebaseDatabase.instance
            .reference()
            .child("Addestratore/UKvCMmDzogfmMiFTubQRwgCYyoj1/cityName")
            .once())
        .value;
    print(result);
    return result;
  }*/

  getData() async {
    var url = Uri.parse(
        "https://pet360-43dfe-default-rtdb.europe-west1.firebasedatabase.app//Addestratore//UKvCMmDzogfmMiFTubQRwgCYyoj1.json?");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      jsonBody = json.decode(response.body);

      print(jsonBody['cityName']);
      //var jsonResponse = convert.jsonDecode(response.body) as JSON;
      // print(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
