import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet360/components/appBackground.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBackground(
      child: Scaffold(
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
                          Text("Benvenuto!",
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
          ),
        )
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
