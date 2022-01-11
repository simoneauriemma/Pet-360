import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pet360/model/interface_model.dart';
import 'package:pet360/model/trainer_model.dart';
import 'package:pet360/model/user_model.dart';
import 'package:pet360/model/veterinary_model.dart';
import 'package:pet360/screens/privacy_policy_screen.dart';
import 'package:pet360/screens/termini_condizioni_screen.dart';
import 'package:pet360/utils/usersharedpreferences.dart';
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
  File? pickedImage;
  var stringPathImage;

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

  void imagePickerOption() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Text("Scegli immagine da: "),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Row(children: [
                      Icon(Icons.camera_alt_rounded),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                      Text("Camera"),
                    ]),
                    onTap: () {
                      getImage(ImageSource.camera);
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Row(children: [
                      Icon(Icons.photo),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                      Text("Galleria"),
                    ]),
                    onTap: () {
                      getImage(ImageSource.gallery);
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Divider(
                    color: Colors.black,
                    //height: 20,
                    thickness: 2,
                    indent: 3,
                    endIndent: 3,
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Row(children: [
                      Icon(Icons.remove_circle, color: Colors.red),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                      Text("Rimuovi immagine",
                          style: TextStyle(color: Colors.red)),
                    ]),
                    onTap: () {
                      setState(() {
                        pickedImage = null;
                      });
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  getImage(ImageSource imageType) async {
    try {
      final image = await ImagePicker().pickImage(source: imageType);

      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        pickedImage = imageTemp;
      });
      Get.back();
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    final uid = _auth.currentUser!.uid;
    //print("Type" + UserSharedPreferences.getTypeOfUser().toString());
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
              //initialValue: snapshot.data!.getFirstName(),
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
                labelText: "Nome",
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
                labelText: "Cognome",
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
                labelText: "Email",
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
                labelText: "Città",
              ),
            );

            final modifyButton = ElevatedButton(
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
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width, height: 50),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Salva le modifiche",
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            );

            final cancellaAccount = GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.0))),
                      title: Text(
                        "Sei sicuro/a di voler eliminare questo account?",
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        //"Si" button
                        TextButton(
                          onPressed: () {
                            eliminateAccount();
                          },
                          child: Text(
                            'Sì',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Close the dialog
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'No',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    );
                  },
                );

                eliminateAccount();
              },
              child: Row(
                children: const [
                  Padding(padding: EdgeInsets.only(top: 20,bottom: 20,left: 10)),
                  Text(
                    "Cancella account",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(width: 8),
                  ImageIcon(
                    AssetImage("assets/icons/delete.png"),
                    color: Colors.black,
                    size: 20,
                  ),
                ],
              ),
            );

            /*final logoutButton = GestureDetector(
              onTap: () {
                LogOut();
              },
              child: Row(
                children: const [
                  Text(
                    "Logout",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  ImageIcon(
                    AssetImage("assets/icons/logout.png"),
                    color: Colors.black,
                    size: 18,
                  ),
                ],
              ),
            ); */

            final logoutButton = ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 120, height: 40),
              child: ElevatedButton(
                onPressed: () {
                  LogOut();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Logout  ",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    ImageIcon(
                      AssetImage("assets/icons/logout.png"),
                      color: Colors.black,
                      size: 15,
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  primary: Colors.white,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            );

            final linguaButton = GestureDetector(
              onTap: () {
                //
              },
              child: Row(                
                children: [
                  Padding(padding: EdgeInsets.only(top: 20,bottom: 20,left: 10)),
                  Text(
                    "Lingua",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Image.asset(
                    "assets/icons/italy.png",
                    height: 30,
                    width: 30,
                  ),
                ],
              ),
            );

            bool isSwitched = false;
            final notifiche = Row(
              children: [
                  Padding(padding: EdgeInsets.only(top: 20,bottom: 20,left: 10)),
                Text(
                  "Notifiche",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ],
            );

            final privacy = GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => PrivacyPolicy_screen()));
              },
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(top: 20,bottom: 20,left: 10)),
                  Text(
                    "Privacy & Policy",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  /*Image.asset(
                    "assets/icons/shield.png",
                    height: 22,
                    width: 22,
                  ),*/
                ],
              ),
            );

            final termini = GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => TerminiCodizioni_screen()));
              },
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(top: 20,bottom: 20,left: 10)),
                  Text(
                    "Termini & Condizioni",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  /*Image.asset(
                    "assets/icons/audit.png",
                    height: 22,
                    width: 22,
                  ),*/
                ],
              ),
            );

            final aiuto = Row(
              children: [
                  Padding(padding: EdgeInsets.only(top: 20,bottom: 20,left: 10)),
                Text(
                  "Help",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  width: 8,
                ),
                Image.asset(
                  "assets/icons/help.png",
                  height: 25,
                  width: 25,
                ),
              ],
            );

            final btnImpostazioni = IconButton(
              //key: btnKey,
              icon: Icon(Icons.settings_applications_sharp),
              padding: EdgeInsets.only(right: 15),
              iconSize: 35,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.0))),
                      title: Text(
                        "Impostazioni",
                        textAlign: TextAlign.center,
                      ),
                      content: Container(
                        height: MediaQuery.of(context).size.height * 0.65,
                         width: MediaQuery.of(context).size.width / 1.2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Padding(padding: EdgeInsets.only(bottom: 20)),
                            notifiche,
                            const Divider(
                              color: Colors.black,
                              //height: 20,
                              thickness: 1,
                              indent: 3,
                              endIndent: 3,
                            ),
                            linguaButton,
                            const Divider(
                              color: Colors.black,
                              //height: 20,
                              thickness: 1,
                              indent: 3,
                              endIndent: 3,
                            ),
                            aiuto,
                            const Divider(
                              color: Colors.black,
                              //height: 20,
                              thickness: 1,
                              indent: 3,
                              endIndent: 3,
                            ),
                            privacy,
                            const Divider(
                              color: Colors.black,
                              //height: 20,
                              thickness: 1,
                              indent: 3,
                              endIndent: 3,
                            ),
                            termini,
                            const Divider(
                              color: Colors.black,
                              //height: 20,
                              thickness: 1,
                              indent: 3,
                              endIndent: 3,
                            ),
                            cancellaAccount,
                            SizedBox(
                              height: 60,
                            ),
                            logoutButton,
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );

            if (UserSharedPreferences.getTypeOfUser().toString() == "Utente") {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 4,
                  title: Text("Profilo"),
                  centerTitle: true,
                  actions: <Widget>[
                    btnImpostazioni,
                  ],
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    },
                  ),
                ),
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  //child: Padding
                  //padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Container(                                
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 3),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  color: Colors.grey.shade200,
                                ),
                                child: ClipOval(
                                  child: pickedImage != null
                                      ? Image.file(
                                          pickedImage!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                      :
                                      //child: Image.asset("assets/icons/download.jpeg", width: 50, height: 50, fit: BoxFit.cover),
                                      SizedBox(
                                          width: 100.0,
                                          height: 100.0,
                                        ),
                                ),
                              ),
                              Positioned(
                                top: 60,
                                left: 42,
                                child: RawMaterialButton(
                                  onPressed: () {
                                            imagePickerOption();
                                          },
                                          //elevation: 8,
                                          shape: CircleBorder(),
                                          child: Icon(
                                            Icons.add_a_photo_rounded,
                                            color: Colors.black,
                                            size: 25,
                                          ),
                                          fillColor: Colors.grey.shade300,
                                          padding: EdgeInsets.all(8),
                                        ),
                              ),
                            ],
                          )),
                              Padding(padding: EdgeInsets.only(bottom: 10)),
                              Text(
                                snapshot.data!.getFirstName() +
                                    " " +
                                    snapshot.data!.getSurnameName(),
                                style: GoogleFonts.questrial(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 30)),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1.3,
                                  height: 540,
                                  //sfondo con sfocatura
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 50),
                                      SizedBox(width: 320, child: nameField),
                                      SizedBox(height: 20),
                                      SizedBox(width: 320, child: surnameField),
                                      SizedBox(height: 20),
                                      SizedBox(width: 320, child: emailField),
                                      SizedBox(height: 20),
                                      SizedBox(width: 320, child: cityField),
                                      SizedBox(height: 30),
                                      SizedBox(width: 320, child: modifyButton),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 40),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey.shade200,
                                Colors.grey.shade100,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp,
                            ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                labelText: "Numero di telefono",
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
                labelText: "Nome del negozio",
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
                labelText: "Nome della città",
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
                labelText: "Indirizzo del negozio",
              ),
            );

            if (UserSharedPreferences.getTypeOfUser().toString() ==
                "Veterinario") {
              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 4,
                  title: Text("Profilo"),
                  centerTitle: true,
                  actions: <Widget>[
                    btnImpostazioni,
                  ],
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    },
                  ),
                ),
                body: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade300,
                                            width: 3),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(100)),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: ClipOval(
                                        child: pickedImage != null
                                            ? Image.file(
                                                pickedImage!,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              )
                                            :
                                            //child: Image.asset("assets/icons/download.jpeg", width: 50, height: 50, fit: BoxFit.cover),
                                            SizedBox(
                                                child: Image.asset(
                                                    "assets/icons/user_default.png"),
                                              ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 60,
                                      left: 42,
                                      child: RawMaterialButton(
                                        onPressed: () {
                                          imagePickerOption();
                                        },
                                        //elevation: 8,
                                        shape: CircleBorder(),
                                        child: Icon(
                                          Icons.add_a_photo_rounded,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                        fillColor: Colors.grey.shade300,
                                        padding: EdgeInsets.all(8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 10)),
                              Text(
                                snapshot.data!.getFirstName() +
                                    " " +
                                    snapshot.data!.getSurnameName(),
                                style: GoogleFonts.questrial(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Veterinario",
                                style: GoogleFonts.questrial(
                                  fontSize: 15,
                                  color: Colors.lightGreen.shade300,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 30)),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1.2,
                                  height:
                                      MediaQuery.of(context).size.width * 2.4,
                                  //sfondo con sfocatura
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 50),
                                      SizedBox(width: 320, child: nameField),
                                      SizedBox(height: 20),
                                      SizedBox(width: 320, child: surnameField),
                                      SizedBox(height: 20),
                                      SizedBox(width: 320, child: emailField),
                                      SizedBox(height: 20),
                                      SizedBox(width: 320, child: cityField),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Informazioni aggiuntive",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(width: 320, child: nameShop),
                                      SizedBox(height: 30),
                                      SizedBox(width: 320, child: cityShop),
                                      SizedBox(height: 30),
                                      SizedBox(width: 320, child: phoneNumber),
                                      SizedBox(height: 30),
                                      SizedBox(width: 320, child: addressShop),
                                      SizedBox(height: 30),
                                      SizedBox(width: 320, child: modifyButton),
                                      SizedBox(height: 100),
                                    ],
                                  )),
                            ],
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey.shade200,
                                Colors.grey.shade100,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp,
                            ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            if (UserSharedPreferences.getTypeOfUser().toString() ==
                "Addestratore") {
              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 4,
                  title: Text("Profilo"),
                  centerTitle: true,
                  actions: <Widget>[
                    btnImpostazioni,
                  ],
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    },
                  ),
                ),
                body: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade300,
                                            width: 3),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(100)),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: ClipOval(
                                        child: pickedImage != null
                                            ? Image.file(
                                                pickedImage!,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              )
                                            :
                                            //child: Image.asset("assets/icons/download.jpeg", width: 50, height: 50, fit: BoxFit.cover),
                                            SizedBox(
                                                child: Image.asset(
                                                    "assets/icons/user_default.png"),
                                              ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 60,
                                      left: 42,
                                      child: RawMaterialButton(
                                        onPressed: () {
                                          imagePickerOption();
                                        },
                                        //elevation: 8,
                                        shape: CircleBorder(),
                                        child: Icon(
                                          Icons.add_a_photo_rounded,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                        fillColor: Colors.grey.shade300,
                                        padding: EdgeInsets.all(8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 10)),
                              Text(
                                snapshot.data!.getFirstName() +
                                    " " +
                                    snapshot.data!.getSurnameName(),
                                style: GoogleFonts.questrial(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Addestratore",
                                style: GoogleFonts.questrial(
                                  fontSize: 15,
                                  color: Colors.lightGreen.shade300,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 30)),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1.2,
                                  height:
                                      MediaQuery.of(context).size.width * 2.4,
                                  //sfondo con sfocatura
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 50),
                                      SizedBox(width: 320, child: nameField),
                                      SizedBox(height: 20),
                                      SizedBox(width: 320, child: surnameField),
                                      SizedBox(height: 20),
                                      SizedBox(width: 320, child: emailField),
                                      SizedBox(height: 20),
                                      SizedBox(width: 320, child: cityField),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Informazioni aggiuntive",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(width: 320, child: nameShop),
                                      SizedBox(height: 30),
                                      SizedBox(width: 320, child: cityShop),
                                      SizedBox(height: 30),
                                      SizedBox(width: 320, child: phoneNumber),
                                      SizedBox(height: 30),
                                      SizedBox(width: 320, child: addressShop),
                                      SizedBox(height: 30),
                                      SizedBox(width: 320, child: modifyButton),
                                      SizedBox(height: 100),
                                    ],
                                  )),
                            ],
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.grey.shade200,
                                Colors.grey.shade100,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp,
                            ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Column();
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

  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/' + filePath.split("/").last)
          .putFile(file);
    } on firebase_storage.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> removePhoto(String filePath) async {
    try {
      if (filePath.split("/").last != "user_default.png") {
        await firebase_storage.FirebaseStorage.instance
            .ref('uploads/' + filePath.split("/").last)
            .delete();
      }
    } on firebase_storage.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> downloadFileExample(String path) async {
    File downloadToFile = File(path);
    stringPathImage = path.split("/").last;
    pickedImage = downloadToFile;
    if (downloadToFile.existsSync()) {
      return;
    }
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/' + path.split("/").last)
          .writeToFile(downloadToFile);
    } on firebase_storage.FirebaseException catch (e) {}
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
    String path = "";
    if (pickedImage != null) {
      path = pickedImage!.path;
      uploadFile(path);
      final DBRef = FirebaseDatabase.instance
          .reference()
          .child(UserSharedPreferences.getTypeOfUser().toString());
      DBRef.child(_auth.currentUser!.uid.toString()).update({
        'photo': path,
      });
    }
    if (email != _auth.currentUser!.email) {
      GFToast.showToast('Non è possibile modificare la mail', context,
          toastPosition: GFToastPosition.TOP,
          textStyle: TextStyle(fontSize: 16, color: GFColors.DARK),
          backgroundColor: Colors.grey.shade200,
          trailing: Icon(
            Icons.notifications,
            color: Colors.black,
          ));
      emailController.text = "";
      return;
    }
    bool changes = false;
    if (nome.isNotEmpty) {
      if (nome != jsonBody['firstName'].toString()) {
        changes = true;
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
        changes = true;
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
        changes = true;
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
        changes = true;
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
        changes = true;
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
        changes = true;
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
        changes = true;
        final DBRef = FirebaseDatabase.instance
            .reference()
            .child(UserSharedPreferences.getTypeOfUser().toString());
        DBRef.child(_auth.currentUser!.uid.toString()).update({
          'addressShop': addressShop,
        });
      }
    }
    if (changes) {
      GFToast.showToast('Modifica completata con successo!', context,
          toastPosition: GFToastPosition.TOP,
          toastDuration: 5,
          textStyle: TextStyle(fontSize: 16, color: GFColors.DARK),
          backgroundColor: Colors.grey.shade200,
          trailing: Icon(
            Icons.notifications,
            color: Colors.black,
          ));
    }
    return;
  }

  void eliminateAccount() async {
    final DBRef = FirebaseDatabase.instance.reference();
    removePhoto(stringPathImage);
    await DBRef.child(UserSharedPreferences.getTypeOfUser().toString() +
            "/" +
            _auth.currentUser!.uid)
        .remove()
        .then((value) => {
              FirebaseAuth.instance.currentUser!.delete().then((value) => {
                    UserSharedPreferences.setTypeOfUser(""),
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen())),
                  })
            });
  }

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
          {
            UserModel user = UserModel.fromJson(jsonDecode(response.body));
            nameController.text = user.firstName!;
            surnameController.text = user.surnameName!;
            emailController.text = _auth.currentUser!.email!;
            cityController.text = user.cityName!;
            await downloadFileExample(user.getPhoto());
            return user;
          }
        case "Addestratore":
          {
            TrainerModel user =
                TrainerModel.fromJson(jsonDecode(response.body));
            nameController.text = user.firstName!;
            surnameController.text = user.surnameName!;
            emailController.text = _auth.currentUser!.email!;
            cityController.text = user.cityName!;
            cityShopController.text = user.cityShop!;
            addressShopController.text = user.addressShop!;
            nameShopController.text = user.nameShop!;
            phoneNumberController.text = user.numberPhone!;
            await downloadFileExample(user.getPhoto());
            return user;
          }
        case "Veterinario":
          {
            VeterinaryModel user =
                VeterinaryModel.fromJson(jsonDecode(response.body));
            nameController.text = user.firstName!;
            surnameController.text = user.surnameName!;
            emailController.text = _auth.currentUser!.email!;
            cityController.text = user.cityName!;
            cityShopController.text = user.cityShop!;
            addressShopController.text = user.addressShop!;
            nameShopController.text = user.nameShop!;
            phoneNumberController.text = user.numberPhone!;
            await downloadFileExample(user.getPhoto());
            return user;
          }
        default:
          {
            UserModel user = UserModel.fromJson(jsonDecode(response.body));
            await downloadFileExample(user.getPhoto());
            return user;
          }
      }
    } else {
      throw Exception('Failed to load album');
    }
  }
}
