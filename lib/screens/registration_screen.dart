import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
  }

class _RegistrationScreenState extends State<RegistrationScreen> {

  bool checkBoxChecked = false;
  TextEditingController controllerUsername = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final _formkey= GlobalKey<FormState>();
  final nameController = new TextEditingController();
  final surnameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final cityController = new TextEditingController();

  //Radio buttons
  final TextEditingController _textEditingController= new TextEditingController();
  

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
          prefixIcon: Icon(Icons.location_city),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );

    final regButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: Colors.lightGreen,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 15, 10),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        child: Text(
          "Registrati",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

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
                          "assets/logoPet360.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 45),

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

                    Row(
                      children: [
                        Checkbox(
                          value: this.checkBoxChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              this.checkBoxChecked = value!;
                              controllerUsername.clear();
                            });
                          },
                        ),
                        (checkBoxChecked)? Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: controllerUsername,
                              decoration: const InputDecoration(
                                hintText: "Enter some text",
                                isDense: true,
                              ),
                            ),
                          ),
                        ): Container(),
                      ],
                    ),


                    regButton,
                    SizedBox(height: 40),
                  ]
              )
          ),
        ),
      ),

    );

  }
}