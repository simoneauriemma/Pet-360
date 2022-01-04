import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet360/utils/usersharedpreferences.dart';

class ShowMessages extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(_auth.currentUser!.uid.toString())
          .where('sender', isEqualTo: UserSharedPreferences.getUIDOfUser())
          .where('receiver', isEqualTo: UserSharedPreferences.getUIDOfUser())
          .orderBy("time")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            primary: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, i) {
              QueryDocumentSnapshot x = snapshot.data!.docs[i];
              return ListTile(
                title: Column(
                  crossAxisAlignment:
                      x['receiver']! == _auth.currentUser!.uid.toString()
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                  children: [Text(x['time'])],
                ),
              );
            });
      },
    );
  }
}
