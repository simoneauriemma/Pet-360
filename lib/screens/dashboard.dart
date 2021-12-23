import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet360/components/appBackground.dart';

import 'ia_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  final List<dynamic> _contacts = [
    {
      "name": "Lilly",
      "image": 'assets/images/cane1.png',
    },
    {
      "name": "Billie",
      "image": 'assets/images/cane2.png',
    },
    {
      "name": "Airon",
      "image": 'assets/images/cane3.png',
    },
    {
      "name": "Lucky",
      "image": 'assets/images/cane4.png',
    },
    {
      "name": "Laila",
      "image": 'assets/images/cane5.png',
    },
  ];

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          children: [
            Container(
              height: size.height * 0.3,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 40,
                      right: 40,
                    ),
                    height: size.height * 0.3 - 27,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Benvenuto!",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => IAscreen()));
                              },
                              // Image tapped
                              child: Image.asset(
                                "assets/icons/ped-id.png",
                                width: 55,
                                height: 50,
                                colorBlendMode: BlendMode.multiply,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            /* Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 150,

                  //LISTA ANIMALI AGGIUNTI
                  decoration: BoxDecoration(

                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
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

                ),
              ],
              //sfondo con sfocatura
            ), */
            Positioned(

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
                          //
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
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/storyset/homeimg.png",
                height: size.width / 2,
                width: size.width / 2,
              ),
            ),
            const Padding(
                padding:
                    EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 80)),
          ],
        ),
      ),
    );
  }

/*Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.3,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                ),
                height: size.height * 0.3 - 27,
                decoration: BoxDecoration(
                    color: Colors.lightGreen.shade200,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    )),
                child: Row(
                  children: <Widget>[
                    Text("Benvenuto Utente!",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Image.asset("assets/icons/ped-id.png", width: 55, height: 50,),

                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  } */
}
