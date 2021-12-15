import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pet360/components/appBackground.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

    UserSharedPreferences.init();
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
      textInputAction: TextInputAction.next,

      //email decoration
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          prefixIcon: Icon(Icons.password),
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
      textInputAction: TextInputAction.done,

      //email decoration
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          prefixIcon: Icon(Icons.location_city),
          hintText: "Città",
          ),
    );

    final regButton = Material(
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
          title: Text("Registrazione"),
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
      String surnameName, String cityName, String typeOfUser) async {
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
          final DBRef = FirebaseDatabase.instance.reference().child(typeOfUser);
          //var document = getData();
          // document.getEmail();
          await _auth
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((uid) =>
          {
                    UserSharedPreferences.setTypeOfUser(typeOfUser),
                    user.uid = _auth.currentUser!.uid,
                    //ONLY FOR TESTING!!!!!
                    //print("\n TESTING UID  " + user.uid.toString() + "\n"),
                    DBRef.child(user.uid.toString()).set({
                      'firstName': user.firstName,
                      'surnameName': user.surnameName,
                      'cityName': user.cityName,
                      'address': user.address,
                    }),
                    //print(UserSharedPreferences.getTypeOfUser()),
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen())),
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
          final DBRef = FirebaseDatabase.instance.reference().child(typeOfUser);
          await _auth
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((uid) => {
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
                    }),

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen())),
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
          final DBRef = FirebaseDatabase.instance.reference().child(typeOfUser);
          await _auth
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((uid) => {
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
                    }),
                    print(UserSharedPreferences.getTypeOfUser()),
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
}
