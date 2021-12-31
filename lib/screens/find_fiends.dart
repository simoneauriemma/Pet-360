import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet360/model/map_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet360/model/view_animals_home.dart';
import 'package:pet360/utils/usersharedpreferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;
import 'home_screen.dart';
//import 'package:geolocator/geolocator.dart';

class FindFriends extends StatefulWidget {
  const FindFriends({Key? key}) : super(key: key);

  @override
  _FindFriendsState createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Set<Marker> _markers = {};
  late GoogleMapController _controller;
  Future<List<ViewAnimalsHome>>? animalList;
  final _auth = FirebaseAuth.instance;
  //static LatLng _initialPosition = LatLng(37.42796133580664, -122.085749655962);
  double x = 37.42796133580664,y = -122.085749655962;

  @override
  void initState() {
    super.initState();
    final uid = _auth.currentUser!.uid;
    animalList = fetchAnimals(
        UserSharedPreferences.getTypeOfUser().toString(), uid, "Animali");
    //_getUserLocation();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<List<ViewAnimalsHome>>(
      future: animalList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text("Geolocalizza i tuoi animali"),
                centerTitle: true,
                elevation: 4,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
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
                            setMarker(context,snapshot.data![index],x,y);
                            return GestureDetector(
                              onTap: () {
                                _controller.moveCamera(
                                    CameraUpdate.newLatLng(LatLng(37.413175077529935, -122.10101041942836)));
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.only(right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.file(
                                      File(snapshot.data![index].pathImg!),
                                      width: 60,
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
                title: Text("Geolocalizza i tuoi animali"),
                centerTitle: true,
                elevation: 4,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
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
                      child: Text(
                        "Non hai animali da poter tracciare",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  )
                ],
              ));
        }
      });

  /*void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }*/

  setMarker(context,data,x,y) async{
    Marker marker;
    marker = Marker(
      markerId: MarkerId(data.animalName.toString()),
      position: LatLng(x, y),
      icon: await _getAssetIcon(context, data.pathImg.toString())
          .then((value) => value),
      infoWindow: InfoWindow(
        title: data.animalName.toString(),
        snippet: 'Street 6 . 2min ago',
      ),
    );
    setState(() {
      _markers.add(marker);
    });
  }

  Future<BitmapDescriptor> _getAssetIcon(
      BuildContext context, String icon) async {
    final Completer<BitmapDescriptor> bitmapIcon =
    Completer<BitmapDescriptor>();
    final ImageConfiguration config =
    createLocalImageConfiguration(context, size: Size(5, 5));

    FileImage(File(icon))
        .resolve(config)
        .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
      final ByteData? bytes =
      await image.image.toByteData(format: ImageByteFormat.png);
      final BitmapDescriptor bitmap =
      BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
      bitmapIcon.complete(bitmap);
    }));

    return await bitmapIcon.future;
  }

  Future<void> downloadFileExample(String path) async {
    File downloadToFile = File(path);
    if (downloadToFile.existsSync()) {
      return;
    }
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/' + path.split("/").last)
          .writeToFile(downloadToFile);
    } on firebase_storage.FirebaseException catch (e) {}
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
    if (response.statusCode == 200) {
      jsonDecode(response.body).forEach((key, value) async {
        await downloadFileExample(value["Libretto"]["animalFoto"]);
        ViewAnimalsHome animal = ViewAnimalsHome();
        animal.animalName = key;
        animal.pathImg = value["Libretto"]["animalFoto"];
        list.add(animal);
      });
      return list;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
