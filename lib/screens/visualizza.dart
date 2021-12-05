import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';

void main() async {
runApp(Visualizza());
}

class Visualizza extends StatelessWidget {
// This widget is the root of your application.



@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Flutter Demo',
theme: ThemeData(
primaryColor: Colors.green.shade200

),
home: AccordionPage(),

);
}
}

class AccordionPage extends StatelessWidget //__
{
static const _headerStyle = TextStyle(color: Colors.black,fontSize: 25, fontFamily: 'Montserrat');
static const _contentStyleHeader = TextStyle(color: Color(0xff999999), fontFamily: 'Montserrat',fontSize: 14, fontWeight: FontWeight.w700);
static const _contentStyle = TextStyle(color: Colors.black, fontFamily: 'Montserrat',fontSize: 20, fontWeight: FontWeight.normal);


final _formkey= GlobalKey<FormState>();
final nameController = new TextEditingController();
final surnameController = new TextEditingController();
final emailController = new TextEditingController();
final passwordController = new TextEditingController();
final cityController = new TextEditingController();

build(context) => Scaffold(
backgroundColor: const Color.fromRGBO(236,236, 236, 4),

body: SingleChildScrollView(
scrollDirection: Axis.vertical,
padding: const EdgeInsets.only(top:60),
child: Column(children: <Widget>[
//icona_bottone_back
/*Container(
alignment: Alignment.topLeft,
padding: const EdgeInsets.only(left: 10 ,bottom: 5),
child: IconButton(
    onPressed: (){ 
    print("Pressed");
    }, 
    icon: Image.asset("assets/icons/back-button.png"),
    iconSize: 40,
),
),*/
//lista di accordion 
Accordion(
//maxOpenSections: 3,
headerPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
children: [
  AccordionSection(
    isOpen: false,
    //leftIcon: Image.asset("assets/icons/pawprint.png"),
    header: const Text("Visualizza le info\ndel tuo animale",style: _headerStyle,textAlign:TextAlign.center),
    // content: const Text("Info animale", style: _contentStyle),
  content: Column(children: <Widget>[
  Container(
  child: TextFormField(
  autofocus: false,
  controller: nameController,
  keyboardType: TextInputType.name,
  onSaved: (value) {
    nameController.text = value!;
  },
  textInputAction: TextInputAction.next,

  //Nome
  decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: "Nome",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      )),
),
),
  Container(

  )
],
),  
    // contentHorizontalPadding: 40,
    contentBorderWidth: 3,
    // rightIcon: Icon(Icons.arrow_forward_ios_sharp, size: 40),
    rightIcon: Image.asset("assets/icons/down-arrow.png"),
  ),
  AccordionSection(
    isOpen: false,
    //leftIcon: Image.asset("assets/icons/vaccine.png"),
    header: const Text('Visualizza le info\nsui vaccini del\ntuo animale', style: _headerStyle, textAlign:TextAlign.center),
    content: const Text("Vaccini animale", style: _contentStyle),




    contentHorizontalPadding: 40,
    contentBorderWidth: 3,
    rightIcon: Image.asset("assets/icons/down-arrow.png"),
  ),
  AccordionSection(
    isOpen: false,
    //leftIcon: Image.asset("assets/icons/passport.png"),
    header: const Text("Visualizza le info\nsul passaporto\ndel tuo animale", style: _headerStyle, textAlign:TextAlign.center),
    content: const Text("Passaporto animale", style: _contentStyle),
    contentHorizontalPadding: 40,
    contentBorderWidth: 3,
    rightIcon: Image.asset("assets/icons/down-arrow.png"),
  ),
  AccordionSection(
    isOpen: false,
    //leftIcon: Image.asset("assets/icons/geoloc.png"),
    header: const Text("Visualizza dispositivi per la\ngeolocalizzazione", style: _headerStyle, textAlign:TextAlign.center),
    content: const Text("Geolocalizzazione animale", style: _contentStyle),
    contentHorizontalPadding: 40,
    contentBorderWidth: 3,
    rightIcon: Image.asset("assets/icons/down-arrow.png"),
  ),
  ],
),
],),
),
);
} 