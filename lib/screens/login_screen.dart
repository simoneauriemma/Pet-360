import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pet360/components/appbackground.dart';
import 'package:pet360/screens/home_screen.dart';
import 'package:pet360/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

/* bool _initialized = false;
bool _error = false;

// Define an async function to initialize FlutterFire
void initializeFlutterFire() async {
  try {
    // Wait for Firebase to initialize and set `_initialized` state to true
    await Firebase.initializeApp();
    setState(() {
      _initialized = true;
    });
  } catch (e) {
    // Set `_error` state to true if Firebase initialization fails
    setState(() {
      _error = true;
    });
  }
} */

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //email
    final emailFilds = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Inserisci una e-mail!");
        }
        //reg expr
        if (!RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-z]+").hasMatch(value)) {
          return ("Inserisci una e-mail valida!");
        }
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      //email decoration
      decoration: InputDecoration(
        filled: true,
        labelText: "Email",
        fillColor: Colors.transparent,
        prefixIcon: Icon(Icons.mail),
      ),
    );
    //password
    final passwordFilds = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      validator: (value) {
        RegExp regE = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Inserisci la password!");
        }
        if (!regE.hasMatch(value)) {
          return ("Inserisci una passoword valida (Almeno 6 caratteri)");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,

      //password decoration
      decoration: InputDecoration(
        filled: true,
        labelText: "Password",
        fillColor: Colors.transparent,
        prefixIcon: Icon(Icons.password_rounded),
      ),
    );

    /* final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: Colors.lightGreen.shade300,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          SignIn(emailController.text, passwordController.text);
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ); */

    final loginButton = ElevatedButton(
      onPressed: () {
        SignIn(emailController.text, passwordController.text);
      },
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
            width: MediaQuery.of(context).size.width, height: 50),
        child: const Align(
          alignment: Alignment.center,
          child: Text(
            "Login",
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

    if (_auth.currentUser != null) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      });
    }

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                    key: _formKey,
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
                          SizedBox(height: 45),
                          emailFilds,
                          SizedBox(height: 25),
                          passwordFilds,
                          SizedBox(height: 35),
                          loginButton,
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Non hai un account? ",
                                style: TextStyle(fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationScreen()));
                                },
                                child: Text(
                                  "Clicca qui!",
                                  style: TextStyle(
                                      color: Colors.lightGreen,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ])),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void SignIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen())),
              })
          .catchError((e) {
        GFToast.showToast(
          'Email o password errate, riprova',
          context,
          toastPosition: GFToastPosition.BOTTOM,
          textStyle: TextStyle(fontSize: 16, color: GFColors.DARK),
          backgroundColor: Colors.grey.shade200,
          /*trailing: Icon(
              Icons.notifications,
              color: Colors.black,
            ),*/
        );
      });
    }
  }
}
