import 'package:flutter/material.dart';
import 'dart:io';
import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

void main() => runApp(NavigatorAdd());

class NavigatorAdd extends StatelessWidget{
  @override
Widget build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData(
        primaryColor: Colors.grey.shade300,
    ),
	initialRoute: '/',
	routes: {
	'/': (context) => addInfoAnimals(),
	'/second': (context) => addInfoVax(),
	'/third': (context) => addInfoPass(),
  '/fourth' : (context) => addInfoDisp(),
	},
);
}
}

double _currentSliderValue = 1;

//campi di aggiunta info animale
final nameController = new TextEditingController();
final dataController = new TextEditingController();
final specieController = new TextEditingController();
final razzaController = new TextEditingController();
final coloreController = new TextEditingController();
final veterinarioController = new TextEditingController();
//campi di aggiunta info vaccino animale
final tipoVaccinoController= new TextEditingController();
final dataSommController= new TextEditingController();
final farmacoSommController= new TextEditingController();
final nomeVeterController= new TextEditingController();
//campi di aggiunta passaporto animale
final descrizioneController= new TextEditingController();
final microchipController= new TextEditingController();
final dataMicrochipController= new TextEditingController();
final enteController= new TextEditingController();

class addInfoAnimals extends StatefulWidget {
@override
_addInfoState createState() => _addInfoState();
}
class _addInfoState extends State<addInfoAnimals> {
File? pickedImage;

void imagePickerOption(){
Get.bottomSheet(
  SingleChildScrollView(
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
        ),
    child: Container(
      color: Colors.white,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Scegli immagine da",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: (){
                  getImage(ImageSource.camera);
                },
                icon: const Icon(Icons.camera_alt_rounded),
                label: const Text("CAMERA"),
              ),
              ElevatedButton.icon(
                onPressed: (){
                  getImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.image),
                label: const Text("GALLERIA"),
              ),
              const SizedBox(height: 10,),
              ElevatedButton.icon(
                onPressed: (){
                  Get.back();
                },
                icon: const Icon(Icons.close),
                label: const Text("CANCEL"),
              ),
          ],
        ),
      ),
    ),
  ),
),
);
}

getImage(ImageSource imageType) async{
try{
  final image =await ImagePicker().pickImage(
  source: imageType);

  if(image == null) return;

  final imageTemp=File(image.path);
  setState(() {
    pickedImage= imageTemp;
  });
  Get.back();
  }catch (err){
  debugPrint(err.toString());
}
}

@override
Widget build(BuildContext context) {
	return Scaffold(
	appBar: AppBar(
		title: Text('Pet_360'),
		backgroundColor: Colors.green,
	),
	body: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    physics: ScrollPhysics(),
    padding: const EdgeInsets.only(top:35),
      child: Column(
            children:[
      //SLIDER
        Slider.adaptive(
        value: _currentSliderValue,
        min: 1,
        max: 4,
        divisions: 3,
        activeColor: Colors.lightGreen,
        inactiveColor: Colors.grey,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
        ),
        //TITOLO
      Text("Aggiungi le info\ndel tuo animale",textAlign:TextAlign.center,style: TextStyle(fontSize: 25, color: Colors.black),),
        SizedBox(height: 30,),
        Align(alignment: Alignment.center,
      child: Stack(
        children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300,width: 3),
            borderRadius:const BorderRadius.all(Radius.circular(100)),
            color: Colors.lightGreen.shade50,
          ),
          child: ClipOval(
            child: pickedImage != null 
            ? Image.file(
              pickedImage!, 
              width: 100,
              height: 100,
              fit: BoxFit.cover,):
            //child: Image.asset("assets/icons/download.jpeg", width: 50, height: 50, fit: BoxFit.cover),
            SizedBox(
              width: 100.0,
              height: 100.0,
          ),
          ),
          ),
          Positioned(
            bottom: 0, right: 2,
            child: IconButton(
              onPressed: (){
                imagePickerOption();
              },
              icon: const Icon(
                Icons.add_a_photo,
                color: Colors.black,
                size: 25,
              ),
            ),
            ),
      ],
    )
  ),
  SizedBox(height: 20,),
  Container(
    width: 320, height: 450,
    decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(24.0),
                  gradient: new LinearGradient(colors: [
                    //Colors.grey.shade300,
                    //Colors.grey.shade400,
                    Color.fromRGBO(236, 236, 236, 0.0),
                    Color.fromRGBO(236, 236, 236, 1.0)

                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                   ),),    
    child: Column(
      children: [
          SizedBox(width: 280,
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
              labelText: "Nome",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.green.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
)
  ),
  ),
SizedBox(height: 10,),
//Container(
  //width: 300,
  SizedBox(width: 280,
  child: TextFormField(
  autofocus: false,
  controller: dataController,
  keyboardType: TextInputType.name,
  onSaved: (value) {
    dataController.text = value!;
  },
  textInputAction: TextInputAction.next,

  //DataNascita
  decoration: InputDecoration(
              labelText: "Data di nascita",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.green.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
)
  ),
),
SizedBox(height: 10,),
//Container(
  //width: 300,
  SizedBox(width: 280,
  child: TextFormField(
  autofocus: false,
  controller: specieController,
  keyboardType: TextInputType.name,
  onSaved: (value) {
    specieController.text = value!;
  },
  textInputAction: TextInputAction.next,

  //Specie
  decoration: InputDecoration(
              labelText: "Specie",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.green.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
)
  ),
),
SizedBox(height: 10,),
//Container(
 // width: 300,
    SizedBox(width: 280,
  child: TextFormField(
  autofocus: false,
  controller: razzaController,
  keyboardType: TextInputType.name,
  onSaved: (value) {
    razzaController.text = value!;
  },
  textInputAction: TextInputAction.next,

  //Razza
    decoration: InputDecoration(
              labelText: "Razza",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.green.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
)
  ),
),
SizedBox(height: 10,),
//Container(
  //width: 300,
    SizedBox(width: 280,
  child: TextFormField(
  autofocus: false,
  controller: coloreController,
  keyboardType: TextInputType.name,
  onSaved: (value) {
    coloreController.text = value!;
  },
  textInputAction: TextInputAction.next,

  //Colore
  decoration: InputDecoration(
              labelText: "Colore",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.green.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
)
  ),
),
SizedBox(height: 10,),
//Container(
  //width: 300,
  SizedBox(width: 280,
  child: TextFormField(
  autofocus: false,
  controller: veterinarioController,
  keyboardType: TextInputType.name,
  onSaved: (value) {
    veterinarioController.text = value!;
  },
  textInputAction: TextInputAction.next,

  //NomeVeterinario
  decoration: InputDecoration(
              labelText: "Nome veterinario",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.green.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
)
),),
  ],
    )
),

Container(
  alignment: Alignment.bottomRight,
  padding: const EdgeInsets.only(right: 40, top: 20),
child: IconButton(
  //icon: Image.asset("assets/icons/right.png"),
    icon: Icon(Icons.arrow_forward_ios_rounded),

  onPressed:(){
      _currentSliderValue= _currentSliderValue+1;
      Navigator.push(context,MaterialPageRoute(builder: (context) => addInfoVax()),);
  }
  ),
),
]),
),
	);
}
}

class addInfoVax extends StatefulWidget {
@override
_addInfoVaxState createState() => _addInfoVaxState();
}
class _addInfoVaxState extends State<addInfoVax> {
@override
Widget build(BuildContext context) {
	return Scaffold(
	appBar: AppBar(
		title: Text("Pet_360"),
		backgroundColor: Colors.green,
	),
	body: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    physics: ScrollPhysics(),
    padding: const EdgeInsets.only(top:35),
      child: Column(
            children:[
        //SLIDER
        Slider.adaptive(
        value: _currentSliderValue,
        min: 1,
        max: 4,
        divisions: 3,
        activeColor: Colors.lightGreen,
        inactiveColor: Colors.grey,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
        ),
        //TITOLO
      Text("Aggiungi le info sui\nvaccini del tuo animale",textAlign:TextAlign.center,style: TextStyle(fontSize: 25, color: Colors.black),),
        SizedBox(height: 30,),
        Container(
    width: 320, height: 400,
    decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(24.0),
                  gradient: new LinearGradient(colors: [
                    //Colors.grey.shade300,
                    //Colors.grey.shade400,
                    Color.fromRGBO(236, 236, 236, 0.0),
                    Color.fromRGBO(236, 236, 236, 1.0)

                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                   ),),
    child: Column(
      children:[
        SizedBox(width: 280,
         child: TextFormField(
    autofocus: false,
    controller: tipoVaccinoController,
    keyboardType: TextInputType.name,
    onSaved: (value) {
      tipoVaccinoController.text = value!;
    },
    textInputAction: TextInputAction.next,

  //Tipo vaccino
    decoration: InputDecoration(
              labelText: "Tipo vaccino",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.green.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
),
),
),
  SizedBox(height: 10,),
//Container(
  //width: 300,
  SizedBox(width: 280,
  child:TextFormField(
  autofocus: false,
  controller: dataSommController,
  keyboardType: TextInputType.name,
  onSaved: (value) {
    dataSommController.text = value!;
  },
  textInputAction: TextInputAction.next,

  //Data somministrazione vaccino
  decoration: InputDecoration(
              labelText: "Data somministrazione",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.green.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
)
),
),

SizedBox(height: 10,),
//Container(
  //width: 300,
  SizedBox(width: 280,
  child: TextFormField(
  autofocus: false,
  controller: farmacoSommController,
  keyboardType: TextInputType.name,
  onSaved: (value) {
    farmacoSommController.text = value!;
  },
  textInputAction: TextInputAction.next,

  //Farmaco somministrato
  decoration: InputDecoration(
              labelText: "Farmaco somministrato",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.green.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
)
),
),

SizedBox(height: 10,),
//Container(
  //width: 300,
  SizedBox(width: 280,
  child: TextFormField(
  autofocus: false,
  controller: nomeVeterController,
  keyboardType: TextInputType.name,
  onSaved: (value) {
  nomeVeterController.text = value!;
  },
  textInputAction: TextInputAction.next,

  //Nome veterinario
  decoration: InputDecoration(
              labelText: "Nome veterinario",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.green.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
)
),),
SizedBox(height: 30,),
Text("Aggiungi un altro vaccino:", style: TextStyle(fontStyle: FontStyle.italic),),
  SizedBox(height: 10,),
  IconButton(
    onPressed: (){ 
      //
    }, 
  icon: Image.asset("assets/icons/plus.png"),
  iconSize: 40,
  ),
]),   
),

Container(
  alignment: Alignment.bottomRight,
  padding: const EdgeInsets.only(right: 40, top: 50),
child: IconButton(
  //icon: Image.asset("assets/icons/right.png"),
  icon: Icon(Icons.arrow_forward_ios_rounded),
  onPressed:(){
      _currentSliderValue=_currentSliderValue+1;
       Navigator.push(context,MaterialPageRoute(builder: (context) => addInfoPass()));
  }
  ),
),

]),
  ),
	);
}
}

class addInfoPass extends StatefulWidget {
@override
_addInfoPassState createState() => _addInfoPassState();
}
class _addInfoPassState extends State<addInfoPass> {
@override
Widget build(BuildContext context) {
	return Scaffold(
	appBar: AppBar(
		title: Text("Pet_360"),
		backgroundColor: Colors.green,
	),
  body: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    physics: ScrollPhysics(),
    padding: const EdgeInsets.only(top:35),
      child: Column(
            children:[
            //SLIDER
        Slider.adaptive(
        value: _currentSliderValue,
        min: 1,
        max: 4,
        divisions: 3,
        activeColor: Colors.lightGreen,
        inactiveColor: Colors.grey,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
        ),
        //TITOLO
      Text("Aggiungi le info\nsul passaporto\ndel tuo animale",textAlign:TextAlign.center,style: TextStyle(fontSize: 25, color: Colors.black),),
        SizedBox(height: 30,),
        
        Container(
    width: 320, height: 350,
    decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(24.0),
                  gradient: new LinearGradient(colors: [
                    //Colors.grey.shade300,
                    //Colors.grey.shade400,
                    Color.fromRGBO(236, 236, 236, 0.0),
                    Color.fromRGBO(236, 236, 236, 1.0)

                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                   ),),
    child: Column(
            children:[
              SizedBox(width: 280,
              child: TextFormField(
                autofocus: false,
                controller: descrizioneController,
                 keyboardType: TextInputType.name,
                onSaved: (value) {
                   descrizioneController.text = value!;
                },
                textInputAction: TextInputAction.next,

  //Descrizione animale
    decoration: InputDecoration(
              labelText: "Descrizione animale",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.green.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
)
  ),
  ),
 // ),
SizedBox(height: 10,),
//Container(
  //width: 300,
  SizedBox(width: 280,
    child: TextFormField(
    autofocus: false,
    controller: microchipController,
    keyboardType: TextInputType.name,
    onSaved: (value) {
      microchipController.text = value!;
    },
    textInputAction: TextInputAction.next,

  //Numero microchip 
  decoration: InputDecoration(
              labelText: "N° microchip",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.green.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
)
),
),
//),

SizedBox(height: 10,),
//Container(
  //width: 300,
  SizedBox(width: 280,
  child: TextFormField(
  autofocus: false,
  controller: dataMicrochipController,
  keyboardType: TextInputType.name,
  onSaved: (value) {
    dataMicrochipController.text = value!;
  },
  textInputAction: TextInputAction.next,

  //Data applicazione microchip 
  decoration: InputDecoration(
              labelText: "Data applicazione microchip",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.green.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
)
),
),
//),

SizedBox(height: 10,),
//Container(
  //width: 300,
  SizedBox(width: 280,
  child:TextFormField(
  autofocus: false,
  controller: enteController,
  keyboardType: TextInputType.name,
  onSaved: (value) {
    enteController.text = value!;
  },
  textInputAction: TextInputAction.next,

 //Ente rilasciante 
  decoration: InputDecoration(
              labelText: "Ente rilasciante",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.green.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
)
),
), ]),),

Container(
  alignment: Alignment.bottomRight,
  padding: const EdgeInsets.only(right: 40, top: 20),
child: IconButton(
 // icon: Image.asset("assets/icons/right.png"),
    icon: Icon(Icons.arrow_forward_ios_rounded),

  onPressed:(){
       _currentSliderValue=_currentSliderValue+1;
       Navigator.push(context,MaterialPageRoute(builder: (context) => addInfoDisp()));
  }
  ),
),

]),
  ),
	);
}
}

class addInfoDisp extends StatefulWidget {
@override
_addInfoDispState createState() => _addInfoDispState();
}
class _addInfoDispState extends State<addInfoDisp> {
@override
Widget build(BuildContext context) {
	return Scaffold(
	appBar: AppBar(
		title: Text("Pet_360"),
		backgroundColor: Colors.green,
	),
  body: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    physics: ScrollPhysics(),
    padding: const EdgeInsets.only(top:35),
      child: Column(
            children:[
                    //SLIDER
        Slider.adaptive(
        value: _currentSliderValue,
        min: 1,
        max: 4,
        divisions: 3,
        activeColor: Colors.lightGreen,
        inactiveColor: Colors.grey,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
        ),
              Container(width: 500,
              child: Text("Aggiungi\ndispositivi per la\ngeolocalizzazione",textAlign:TextAlign.center,style: TextStyle(fontSize: 25, color: Colors.black),),
              ),
              SizedBox(height: 80,),
              Container(width: 500,
              child: Text("Dispositivi disponibili:",textAlign:TextAlign.center,style: TextStyle(fontSize: 15, color: Colors.black),),
              ),
              SizedBox(height: 15,),
              Container( width:300,height: 200, 
              padding: EdgeInsets.only(top:40),
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(24.0),
                  gradient: new LinearGradient(colors: [
                    //Colors.grey.shade300,
                    //Colors.grey.shade400,
                    Color.fromRGBO(236, 236, 236, 0.0),
                    Color.fromRGBO(236, 236, 236, 1.0)

                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                   ),
                   ),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                  ElevatedButton(
              child: Text("AirTag1"),
              style: ElevatedButton.styleFrom(
                 onPrimary: Colors.black,
                 primary: Colors.white70,
                 onSurface: Colors.grey,
                 side: BorderSide(color: Colors.lightGreen, width: 2),
                 elevation: 10,
                 minimumSize: Size(140,40),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
               ),
              onPressed:() {
                  GFToast.showToast('Dispositivo 1 aggiunto!',context,
                  toastPosition: GFToastPosition.BOTTOM,
                  textStyle: TextStyle(fontSize: 16, color: GFColors.DARK),
                  backgroundColor: Colors.green.shade300,
                  trailing: Icon(
                    Icons.notifications,
                    color: Colors.black,
                  ));                    
              },
            ),

            ElevatedButton(
              child: Text("AirTag2"),
              style: ElevatedButton.styleFrom(
                 onPrimary: Colors.black,
                 primary: Colors.white70,
                 onSurface: Colors.grey,
                 side: BorderSide(color: Colors.lightGreen, width: 2),
                 elevation: 10,
                 minimumSize: Size(140,40),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
               ),
              onPressed:() {
                  GFToast.showToast('Dispositivo 2 aggiunto!',context,
                  toastPosition: GFToastPosition.BOTTOM,
                  textStyle: TextStyle(fontSize: 16, color: GFColors.DARK),
                  backgroundColor: Colors.green.shade300,
                  trailing: Icon(
                    Icons.notifications,
                    color: Colors.black,
                  )); 
              },
            )
            ],)
            ),

              SizedBox(height: 100,),
              Align(alignment: Alignment.bottomCenter,
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
                  //
              },
            )
            ),
  ]),  
  ),
	);
}
}