import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet360/components/appbackground.dart';
import 'package:pet360/model/trainer_model.dart';
import 'package:pet360/model/user_model.dart';
import 'package:pet360/model/veterinary_model.dart';
import 'package:pet360/utils/usersharedpreferences.dart';

import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController controllerUsername = new TextEditingController();

  @override
  void initState() {
    super.initState();
    //UserSharedPreferences.init();
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
      validator: (value) {
        RegExp regE = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Inserisci il nome!");
        }
        if (!regE.hasMatch(value)) {
          return ("Inserisci un nome valido!");
        }
      },
      textInputAction: TextInputAction.next,

      //email decoration
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: Icon(Icons.supervised_user_circle_outlined),
        hintText: "Nome",
      ),
    );

    final surnameField = TextFormField(
      autofocus: false,
      controller: surnameController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        surnameController.text = value!;
      },
      validator: (value) {
        RegExp regE = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Inserisci il tuo cognome");
        }
        if (!regE.hasMatch(value)) {
          return ("Inserisci un cognome valido (Almeno 3 caratteri)");
        }
      },
      textInputAction: TextInputAction.next,

      //email decoration
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: Icon(Icons.supervised_user_circle_outlined),
        hintText: "Cognome",
      ),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("Inserisci una e-mail!");
        }
        //reg expr
        if (!RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-z]+").hasMatch(value)) {
          return ("Inserisci una e-mail valida!");
        }
      },
      textInputAction: TextInputAction.next,

      //email decoration
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: Icon(Icons.mail),
        hintText: "Email",
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      onSaved: (value) {
        passwordController.text = value!;
      },
      validator: (value) {
        RegExp regE = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Inserisci la password!");
        }
        if (!regE.hasMatch(value)) {
          return ("Inserisci una passoword valida (Almeno 6 caratteri)");
        }
      },

      textInputAction: TextInputAction.next,

      //email decoration
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: Icon(Icons.lock_rounded),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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
      validator: (value) {
        if (value!.isEmpty) {
          return ("Inserisci una Città");
        }
        //reg expr
        if (!RegExp("[0-9a-zA-Z]{3,}").hasMatch(value)) {
          return ("Inserisci una città valida!");
        }
      },
      textInputAction: TextInputAction.done,

      //email decoration
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: Icon(Icons.location_city),
        hintText: "Città",
      ),
    );

    /*final regButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: Colors.lightGreen.shade300,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 15, 20),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          //String email, String password, String firstName,
          //       String surnameName, String cityName, typeOfUser

          var typeOfUser;
          if (checkBoxChecked) {
            typeOfUser = "Veterinario";
          } else if (checkBoxChecked2) {
            typeOfUser = "Addestratore";
          } else {
            typeOfUser = "Utente";
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
    ); */

    final regButton = ElevatedButton(
      onPressed: () {
        var typeOfUser;
        if (checkBoxChecked) {
          typeOfUser = "Veterinario";
        } else if (checkBoxChecked2) {
          typeOfUser = "Addestratore";
        } else {
          typeOfUser = "Utente";
        }
        SignUp(
            emailController.text,
            passwordController.text,
            nameController.text,
            surnameController.text,
            cityController.text,
            typeOfUser);
      },
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
            width: MediaQuery.of(context).size.width, height: 50),
        child: const Align(
          alignment: Alignment.center,
          child: Text(
            "Registrati",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.black,
        primary: Colors.white,
        onSurface: Colors.grey,
        side: BorderSide(color: Colors.lightGreen.shade200, width: 2),
        elevation: 5,
        //minimumSize: Size(100, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );

    final shopNameField = TextFormField(
      autofocus: false,
      controller: shopNameController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        shopNameController.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("Inserisci una Città");
        }
        //reg expr
        if (!RegExp("[a-zA-Z]{3,}").hasMatch(value)) {
          return ("Inserisci una città valida!");
        }
      },
      textInputAction: TextInputAction.next,

      //email decoration
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: Icon(Icons.shop),
        hintText: "Nome negozio",
      ),
    );

    final phoneNumberField = TextFormField(
      autofocus: false,
      controller: phoneNumberController,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        phoneNumberController.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("Inserisci un numero di telefono valido");
        }
        //reg expr
        if (!RegExp("[0-9]{9,}").hasMatch(value)) {
          return ("Inserisci un numero di telefono valido!");
        }
      },
      textInputAction: TextInputAction.next,
      //email decoration
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: Icon(Icons.phone),
        hintText: "Numero di telefono",
      ),
    );

    final cityShopField = TextFormField(
      autofocus: false,
      controller: cityShopController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        cityShopController.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("Inserisci una Città per il tuo shop valida");
        }
        //reg expr
        if (!RegExp("[a-zA-Z]{3,}").hasMatch(value)) {
          return ("Inserisci una città del tuo shop valida!");
        }
      },
      textInputAction: TextInputAction.next,

      //email decoration
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: Icon(Icons.apartment_rounded),
        hintText: "Città",
      ),
    );

    final shopAddressField = TextFormField(
      autofocus: false,
      controller: shopAddressController,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        shopAddressController.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("Inserisci un indirizzo per il tuo shop valido");
        }
        //reg expr
        if (!RegExp("[a-z A-Z]{5,}").hasMatch(value)) {
          return ("Inserisci un indirizzo del tuo shop valido!");
        }
      },
      textInputAction: TextInputAction.done,

      //email decoration
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon: Icon(Icons.home),
        hintText: "Indirizzo",
      ),
    );

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Registrazione",
            textAlign: TextAlign.center,
            style: GoogleFonts.questrial(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
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
                      /*Row(
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
                      ), */
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
                                      SizedBox(height: 30),
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
                                      SizedBox(height: 30),
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
      String surnameName, String cityName, String typeOfUser) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        });
    if (_formkey.currentState!.validate()) {
      //UserSharedPreferences.setIndex(0);

      switch (typeOfUser) {
        case "Utente":
          {
            UserModel user = UserModel(
                email: email,
                firstName: firstName,
                surnameName: surnameName,
                cityName: cityName,
                address: "prova",
                //TODO DA CAMBIARE
                typeOfUser: typeOfUser);
            final DBRef =
                FirebaseDatabase.instance.reference().child(typeOfUser);
            //var document = getData();
            // document.getEmail();
            await _auth
                .createUserWithEmailAndPassword(
                    email: email, password: password)
                .then((uid) async => {
                      UserSharedPreferences.setTypeOfUser(typeOfUser),
                      user.uid = _auth.currentUser!.uid,
                      //ONLY FOR TESTING!!!!!
                      //print("\n TESTING UID  " + user.uid.toString() + "\n"),
                      DBRef.child(user.uid.toString()).set({
                        'firstName': user.firstName,
                        'surnameName': user.surnameName,
                        'cityName': user.cityName,
                        'address': user.address,
                        'photo':
                            "/data/user/0/com.example.pet360/cache/user_default.png",
                      }),
                      //print("aspetto il future...."),
                      //print(UserSharedPreferences.getTypeOfUser()),
                      await Future.delayed(Duration(seconds: 3), () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      }),
                    })
                .catchError((e) {});
          }
          break;
        case "Veterinario":
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
                FirebaseDatabase.instance.reference().child(typeOfUser);
            await _auth
                .createUserWithEmailAndPassword(
                    email: email, password: password)
                .then((uid) async => {
                      UserSharedPreferences.setTypeOfUser(typeOfUser),
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
                        'votes': 0.1,
                        'photo':
                            "/data/user/0/com.example.pet360/cache/user_default.png",
                      }),
                      //print("aspetto il future...."),
                      //print(UserSharedPreferences.getTypeOfUser()),
                      await Future.delayed(Duration(seconds: 5), () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      }),
                    })
                .catchError((e) {});
          }
          break;
        case "Addestratore":
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
                FirebaseDatabase.instance.reference().child(typeOfUser);
            await _auth
                .createUserWithEmailAndPassword(
                    email: email, password: password)
                .then((uid) async => {
                      UserSharedPreferences.setTypeOfUser(typeOfUser),
                      trainerModel.uid = _auth.currentUser!.uid,
                      //ONLY FOR TESTING!!!!!
                      /*print("\n TESTING UID  " +
                        trainerModel.uid.toString() +
                        "\n"),*/
                      DBRef.child(trainerModel.uid.toString()).set({
                        'firstName': trainerModel.firstName,
                        'surnameName': trainerModel.surnameName,
                        'cityName': trainerModel.cityName,
                        'address': trainerModel.address,
                        'nameShop': trainerModel.nameShop,
                        'numberPhone': trainerModel.numberPhone,
                        'cityShop': trainerModel.cityShop,
                        'addressShop': trainerModel.addressShop,
                        'votes': 0.1,
                        'photo':
                            "/data/user/0/com.example.pet360/cache/user_default.png",
                      }),

                      //print("aspetto il future...."),
                      //print(UserSharedPreferences.getTypeOfUser()),
                      await Future.delayed(Duration(seconds: 3), () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      }),
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
  }
}
