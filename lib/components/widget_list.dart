import 'package:flutter/material.dart';

class WidgetList extends StatelessWidget {
  final String name;
  final String shopname;
  final String phonenum;
  final String indirizzo;
  final String voto;

  WidgetList({
    required this.name,
    required this.shopname,
    required this.phonenum,
    required this.indirizzo,
    required this.voto,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: () => print("tapped"),
        child: Container(
          //margin: EdgeInsets.only(left: 20, right: 20),
          padding:
              EdgeInsets.only(top: 20.0, bottom: 20.0, right: 20.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 20.0),
                child: Icon(
                  Icons.account_circle,
                  size: 40.0,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightGreen,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text("Nome negozio: ",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  )),
                              Text("$shopname",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[800],
                                  )),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text("Cellulare: ",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  )),
                              Text("$phonenum",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[800],
                                  )),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text("Indirizzo: ",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  )),
                              Text("$indirizzo",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[800],
                                  )),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text("Voto: ",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  )),
                              Text("$voto",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[800],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Chatta ora"),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  primary: Colors.white,
                  minimumSize: Size(100, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
