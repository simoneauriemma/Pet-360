import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pet360/model/map_style.dart';
import 'package:pet360/model/view_animals_home.dart';
import 'package:pet360/utils/usersharedpreferences.dart';

import 'home_screen.dart';

class FindFriends extends StatefulWidget {
  const FindFriends({Key? key}) : super(key: key);

  @override
  _FindFriendsState createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  Set<Marker> _markers = {};
  late GoogleMapController _controller;
  Future<List<ViewAnimalsHome>>? animalList;
  final _auth = FirebaseAuth.instance;
  LatLng _initialPosition = LatLng(37.42796133580664, -122.085749655962);
  late CameraPosition _kGooglePlex;
  bool aBool1=false,aBool2 = false;
  bool aBool3 = true;
  List<LatLng> cash = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    final uid = _auth.currentUser!.uid;
    if(aBool3){
      animalList = fetchAnimals(
          UserSharedPreferences.getTypeOfUser().toString(), uid, "Animali");
      aBool3 = false;
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<List<ViewAnimalsHome>>(
      future: animalList,
      builder: (context, snapshot) {
        _kGooglePlex = CameraPosition(
          target: _initialPosition,
          zoom: 18,
        );
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  "Geolocalizza i tuoi animali",
                  style: GoogleFonts.questrial(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                elevation: 4,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ),
              body: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: _kGooglePlex,
                    markers: _markers,
                    myLocationButtonEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                      controller.setMapStyle(MapStyle().sliver);
                    },
                  ),
                  Positioned(
                    bottom: 100,
                    left: 20,
                    right: 20,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 140,
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            setMarker(context,snapshot.data![index],snapshot.data![index].latLng.latitude,snapshot.data![index].latLng.longitude);
                            return GestureDetector(
                              onTap: () {
                                _controller.moveCamera(
                                    CameraUpdate.newLatLng(snapshot.data![index].latLng));
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.only(right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                  
                                   child: Image.file(
                                    File(snapshot.data![index].pathImg
                                        .toString()),
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.data![index].animalName!,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                  )
                ],
              ));
        }
        else
        {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  "Geolocalizza i tuoi animali",
                  style: GoogleFonts.questrial(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                elevation: 4,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ),
              body: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: _kGooglePlex,
                    markers: _markers,
                    myLocationButtonEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                      controller.setMapStyle(MapStyle().sliver);
                    },
                  ),
                  Positioned(
                    bottom: 100,
                    left: 20,
                    right: 20,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Non hai ancora animali da poter tracciare!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              ));
        }
      });

  _getUserLocation() async {
    Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    _initialPosition = LatLng(position.latitude, position.longitude);
    _controller.moveCamera(
        CameraUpdate.newLatLng(_initialPosition));
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }

  Future<String> _getAddressFromLatLng(dynamic x, dynamic y) async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          x, y);
      Placemark place = p[0];
      return  "${place.locality}, ${place.country}";
    } catch (e) {
      return 'No address found';
    }
  }

  setMarker(context,data,x,y) async{
    String street = await _getAddressFromLatLng(x,y);

    final Uint8List? markerIcon = await _getText(250, 150, data.animalName);
    Marker marker;
    marker = Marker(
      markerId: MarkerId(data.animalName.toString()),
      position: LatLng(x, y),
      icon: BitmapDescriptor.fromBytes(markerIcon!),
      infoWindow: InfoWindow(
        title: data.animalName.toString(),
        snippet: street,
      ),
    );
    setState(() {
      _markers.add(marker);
    });
  }

  Future<Uint8List?> _getText(int width, int height, String animalName) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = Colors.lightGreen.shade200;
    final Radius radius = Radius.circular(20.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        paint);
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: animalName,
      style: TextStyle(fontSize: 45.0, color: Colors.black),
    );
    painter.layout();
    painter.paint(canvas, Offset((width * 0.5) - painter.width * 0.5, (height * 0.5) - painter.height * 0.5));
    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data?.buffer.asUint8List();
  }

  Future<List<ViewAnimalsHome>> fetchAnimals(
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
    List<ViewAnimalsHome> list = List.empty(growable: true);
    await _getUserLocation();
    if (response.statusCode == 200) {
      jsonDecode(response.body).forEach((key, value) async {
        ViewAnimalsHome animal = ViewAnimalsHome();
        animal.animalName = key;
        animal.pathImg = value["Libretto"]["animalFoto"];
        double convertedX = 0;
        double convertedY = 0;
        Random random = Random();
        String doubleNumberX = "0.00009"+random.nextInt(10).toString();
        String doubleNumberY = "0.00009"+random.nextInt(10).toString();
        aBool1 = random.nextBool();
        aBool2 = random.nextBool();
        if(!aBool1){
          doubleNumberX = "-0.00009"+random.nextInt(10).toString();
        } else {
          doubleNumberX = "0.00009"+random.nextInt(10).toString();
        }
        if(!aBool2){
          doubleNumberY = "-0.00009"+random.nextInt(10).toString();
        } else {
          doubleNumberY = "0.00009"+random.nextInt(10).toString();
        }
        convertedX = double.parse(doubleNumberX);
        convertedY = double.parse(doubleNumberY);
        if(!cash.contains(LatLng(_initialPosition.latitude+convertedX, _initialPosition.longitude+convertedY))){
          animal.latLng = LatLng(_initialPosition.latitude+convertedX, _initialPosition.longitude+convertedY);
        } else {
          aBool1 = random.nextBool();
          aBool2 = random.nextBool();
          if(!aBool1){
            doubleNumberX = "-0.00009"+random.nextInt(10).toString();
          } else {
            doubleNumberX = "0.00009"+random.nextInt(10).toString();
          }
          if(!aBool2){
            doubleNumberY = "-0.00009"+random.nextInt(10).toString();
          } else {
            doubleNumberY = "0.00009"+random.nextInt(10).toString();
          }
          convertedX = double.parse(doubleNumberX);
          convertedY = double.parse(doubleNumberY);
          animal.latLng = LatLng(_initialPosition.latitude+convertedX, _initialPosition.longitude+convertedY);
        }
        list.add(animal);
        cash.add(animal.latLng);
      });
      cash.removeRange(0, cash.length);
      return list;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
