import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';

void main() async {
runApp(viewAnimal());
}

class viewAnimal extends StatelessWidget {
static const _headerStyle = TextStyle(color: Colors.black,fontSize: 25);
static const _contentStyleHeader = TextStyle(color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
static const _contentStyle = TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal);

//visualizza info animale
final  nameHolder ;
final  dataHolder ;
final  specieHolder ;
final  razzaHolder;
final  coloreHolder;
final  veterinarioHolder;

//visualizza info vaccini animale
final tipoVaccinoHolder;
final dataSomminisHolder;
final farmacoSommHolder;
final nomeveterHolder;

//visualizza info passaporto animale
final descrizioneHolder;
final microchipHolder;
final dataMicrochipHolder;
final enteHolder;

//visualizza dispositivi

  viewAnimal({
  this.nameHolder, 
  this.dataHolder, 
  this.specieHolder,
  this.razzaHolder,
  this.coloreHolder,
  this.veterinarioHolder,
  this.tipoVaccinoHolder,
  this.dataSomminisHolder,
  this.farmacoSommHolder,
  this.nomeveterHolder,
  this.descrizioneHolder,
  this.microchipHolder,
  this.dataMicrochipHolder,
  this.enteHolder});

@override
/*Widget build(BuildContext context) {
return MaterialApp(
title: 'Flutter Demo',
theme: ThemeData(
primaryColor: Colors.green.shade200

),
//home: AccordionPage(),

);
}
*/
//class AccordionPage extends StatelessWidget //__
//{



@override
Widget build(BuildContext context) {
return Scaffold(
  //build(context) => Scaffold(
backgroundColor: const Color.fromRGBO(255, 255, 255, 1),

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
paddingListHorizontal: 30,
paddingListTop: 30,
children: [
  //VISUALIZZA INFO ANIMALE
  AccordionSection(
    isOpen: false,
    //leftIcon: Image.asset("assets/icons/pawprint.png"),
    header: const Text("Visualizza le info\ndel tuo animale",style: _headerStyle,textAlign:TextAlign.left),
    content: Column(children: <Widget>[
      //icona di modifica
        Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.only(),
          child: IconButton(
            onPressed: (){ 
            nameHolder.text = "New text";
            }, 
          icon: Image.asset("assets/icons/edit.png"),
          iconSize: 40,
          ),
        ),

    Align(alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300,width: 3),
              borderRadius:const BorderRadius.all(Radius.circular(100)),
            ),
            child: CircleAvatar(
      radius: 50,
      //backgroundImage: image==null? AssetImage("assets/icons/download.jpeg"): FileImage(File(image.path)),
      /*child: ClipOval(
        child: SizedBox(
          width: 50.0,
          height: 50.0,
        ),
        ),*/
    ),
    ),
  ],
),
),
SizedBox(height: 20,),
        Container(            
            child: TextField(
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: nameHolder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              ),
            ),
        ),
SizedBox(height: 10,),
        Container(            
            child: TextField(
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: dataHolder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              ),
            ),
        ),
SizedBox(height: 10,),
        Container(            
            child: TextField(
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: specieHolder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              ),
            ),
        ),
SizedBox(height: 10,),
        Container(            
            child: TextField(
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: razzaHolder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              ),
            ),
        ),
SizedBox(height: 10,),
        Container(            
            child: TextField(
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: coloreHolder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              ),
            ),
        ),
SizedBox(height: 10,),  
        Container(            
            child: TextField(
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: veterinarioHolder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              ),
            ),
        ),
    ],),
    // contentHorizontalPadding: 40,
    contentBorderWidth: 3,
    // rightIcon: Icon(Icons.arrow_forward_ios_sharp, size: 40),
    rightIcon: Image.asset("assets/icons/down-arrow.png"),
  ),
  
  //VISUALIZZA INFO VACCINI ANIMALE
  AccordionSection(
    isOpen: false,
    //leftIcon: Image.asset("assets/icons/vaccine.png"),
    header: const Text('Visualizza le info\nsui vaccini del\ntuo animale', style: _headerStyle, textAlign:TextAlign.left),
    content: Column(children: <Widget>[
      //icona di modifica
        Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.only(),
          child: IconButton(
            onPressed: (){ 
            //
            }, 
          icon: Image.asset("assets/icons/edit.png"),
          iconSize: 40,
          ),
        ),

        Container(            
            child: TextField(
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: tipoVaccinoHolder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              ),
            ),
        ),
SizedBox(height: 10,),
        Container(            
            child: TextField(
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: dataSomminisHolder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              ),
            ),
        ),
SizedBox(height: 10,),
        Container(            
            child: TextField(
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: farmacoSommHolder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              ),
            ),
        ),
SizedBox(height: 10,),
        Container(            
            child: TextField(
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: nomeveterHolder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              ),
            ),
        ),
    ],),
    // contentHorizontalPadding: 40,
    contentBorderWidth: 3,
    // rightIcon: Icon(Icons.arrow_forward_ios_sharp, size: 40),
    rightIcon: Image.asset("assets/icons/down-arrow.png"),
  ),
  
  //VISUALIZZA INFO PASSAPORTO ANIMALE
  AccordionSection(
    isOpen: false,
    //leftIcon: Image.asset("assets/icons/passport.png"),
    header: const Text("Visualizza le info\nsul passaporto\ndel tuo animale", style: _headerStyle, textAlign:TextAlign.left),
   content: Column(children: <Widget>[
      //icona di modifica
        Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.only(),
          child: IconButton(
            onPressed: (){ 
            //
            }, 
          icon: Image.asset("assets/icons/edit.png"),
          iconSize: 40,
          ),
        ),

        Container(            
            child: TextField(
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: descrizioneHolder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              ),
            ),
        ),
SizedBox(height: 10,),
        Container(            
            child: TextField(
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: microchipHolder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              ),
            ),
        ),
SizedBox(height: 10,),
        Container(            
            child: TextField(
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: dataMicrochipHolder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              ),
            ),
        ),
SizedBox(height: 10,),
        Container(            
            child: TextField(
              decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: enteHolder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              ),
            ),
        ),
    ],),
    // contentHorizontalPadding: 40,
    contentBorderWidth: 3,
    // rightIcon: Icon(Icons.arrow_forward_ios_sharp, size: 40),
    rightIcon: Image.asset("assets/icons/down-arrow.png"),
  ),
  
  //VISUALIZZA DISPOSITIVI
  AccordionSection(
    isOpen: false,
    //leftIcon: Image.asset("assets/icons/geoloc.png"),
    header: const Text("Visualizza dispositivi per la\ngeolocalizzazione", style: _headerStyle, textAlign:TextAlign.left),
    content: 
     Column(children: <Widget>[
SizedBox(height: 20,),
Text("Dispositivi disponibili:", style: _contentStyle,),
SizedBox(height: 20,),
Container(
  child: ElevatedButton(
              child: Text("AirTag1"),
              style: ElevatedButton.styleFrom(
                 onPrimary: Colors.black,
                 primary: Colors.white70,
                 onSurface: Colors.grey,
                 side: BorderSide(color: Colors.lightGreen, width: 2),
                 elevation: 10,
                 minimumSize: Size(120,40),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
               ),
              onPressed:() {
                  //
              },
            )
),
SizedBox(height: 10,),
Container(
  child: ElevatedButton(
              child: Text("AirTag2"),
              style: ElevatedButton.styleFrom(
                 onPrimary: Colors.black,
                 primary: Colors.white70,
                 onSurface: Colors.grey,
                 side: BorderSide(color: Colors.lightGreen, width: 2),
                 elevation: 10,
                 minimumSize: Size(120,40),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
               ),
              onPressed:() {
                  //
              },
            )
),
],
),
    contentHorizontalPadding: 40,
    contentBorderWidth: 3,
    rightIcon: Image.asset("assets/icons/down-arrow.png"),
  ),
  ],
),

Container(
child: ElevatedButton(
              child: Text("Salva"),
              style: ElevatedButton.styleFrom(
                 onPrimary: Colors.black,
                 primary: Colors.white70,
                 onSurface: Colors.grey,
                 side: BorderSide(color: Colors.lightGreen, width: 2),
                 elevation: 10,
                 minimumSize: Size(120,40),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
               ),
              onPressed:() {
                 // getItemAndNavigate(context);
              },
            )
),

],),
),
);
}
} 