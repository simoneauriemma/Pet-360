import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet360/screens/chatting_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pet360/utils/usersharedpreferences.dart';


import 'home_screen.dart';

class ReviewChat extends StatefulWidget {
  const ReviewChat({Key? key}) : super(key: key);

  @override
  _ReviewChatState createState() => _ReviewChatState();
}

class _ReviewChatState extends State<ReviewChat> {
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Valuta la conversazione"),
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Chatting_screen()));
          },
        ),
      ),
      
      body:  Column(children: [      
                      Padding(padding: EdgeInsets.only(top: 40)),
                      Align(alignment: Alignment.topCenter,
                      child: Container(                      
                      padding: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: 430,
                      //sfondo con sfocatura
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
        child: Column(children: [
          SizedBox(height: 30,), 
                                               
                          Text(
                            "LASCIA UN VOTO A",textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            UserSharedPreferences.getNameChat().toString(),textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black45),
                          ),
                          SizedBox(
                            height: 30,
                          ),
          Padding(padding: EdgeInsets.only(top: 50)),
          Text(
            'VOTO: $rating',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20,),
          RatingBar(
          initialRating: 0.0,
          minRating: 0.0,
          itemSize: 45,
          allowHalfRating: true,
          ratingWidget: RatingWidget(
          full: Icon(Icons.star, color: Colors.amber),
          half: Icon(Icons.star_half,color: Colors.amber),
          empty: Icon(Icons.star_border, color: Colors.black45),
          ),
          itemPadding: EdgeInsets.symmetric(horizontal:4),
          //itemBuilder: (context,_) => Icon(Icons.star, color: Colors.amber), 
          updateOnDrag: true,
          onRatingUpdate: (rating) => setState(() {
            this.rating= rating;
          }),
          ),
          SizedBox(height: 70,),  
          ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                 child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                    width: 300, height: 50),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Abbandona",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ),
                style: ElevatedButton.styleFrom(
                onPrimary: Colors.black,
                primary: Colors.white,
                onSurface: Colors.grey,
                side: BorderSide(color: Colors.lightGreen.shade200, width: 2),
                elevation: 5,
                //minimumSize: Size(100, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              ),
              
        ]
        ),
        ),
                      ),
        ],),
      
    );
  }
}
