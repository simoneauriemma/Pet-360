import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:pet360/model/map_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet360/utils/usersharedpreferences.dart';

import 'home_screen.dart';

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

  final List<dynamic> _contacts = [
    {
      "name": "Lilly",
      "position": LatLng(37.42796133580664, -122.085749655962),
      "marker": 'assets/markers/cane1.png',
      "image": 'assets/images/cane1.png',
    },
    {
      "name": "Billie",
      "position": LatLng(37.42484642575639, -122.08309359848501),
      "marker": 'assets/markers/cane2.png',
      "image": 'assets/images/cane2.png',
    },
    {
      "name": "Airon",
      "position": LatLng(37.42381625902441, -122.0928531512618),
      "marker": 'assets/markers/cane3.png',
      "image": 'assets/images/cane3.png',
    },
    {
      "name": "Lucky",
      "position": LatLng(37.41994095849639, -122.08159055560827),
      "marker": 'assets/markers/cane4.png',
      "image": 'assets/images/cane4.png',
    },
    {
      "name": "Laila",
      "position": LatLng(37.413175077529935, -122.10101041942836),
      "marker": 'assets/markers/cane5.png',
      "image": 'assets/images/cane5.png',
    },
    /*{
      "name": "Sara",
      "position": LatLng(37.419013242401576, -122.11134664714336),
      "marker": 'assets/markers/marker-6.png',
      "image": 'assets/images/avatar-6.png',
    },
    {
      "name": "Ronaldo",
      "position": LatLng(37.40260962243491, -122.0976958796382),
      "marker": 'assets/markers/marker-7.png',
      "image": 'assets/images/avatar-7.png',
    },*/
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    createMarkers(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Geolocalizza i tuoi animali"),
          centerTitle: true,
          elevation: 4,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              UserSharedPreferences.setIndex(0);
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
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _controller.moveCamera(
                          CameraUpdate.newLatLng(_contacts[index]["position"]));
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            _contacts[index]['image'],
                            width: 60,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _contacts[index]["name"],
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

  createMarkers(BuildContext context) {
    Marker marker;

    _contacts.forEach((contact) async {
      marker = Marker(
        markerId: MarkerId(contact['name']),
        position: contact['position'],
        icon: await _getAssetIcon(context, contact['marker'])
            .then((value) => value),
        infoWindow: InfoWindow(
          title: contact['name'],
          snippet: 'Street 6 . 2min ago',
        ),
      );

      setState(() {
        _markers.add(marker);
      });
    });
  }

  Future<BitmapDescriptor> _getAssetIcon(
      BuildContext context, String icon) async {
    final Completer<BitmapDescriptor> bitmapIcon =
        Completer<BitmapDescriptor>();
    final ImageConfiguration config =
        createLocalImageConfiguration(context, size: Size(5, 5));

    AssetImage(icon)
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
}
