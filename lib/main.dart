import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:pet360/screens/home_screen.dart';
import 'package:pet360/screens/login_screen.dart';
import 'package:pet360/utils/usersharedpreferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserSharedPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet360',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      initialRoute: "/",
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  var title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
