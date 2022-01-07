import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet360/utils/usersharedpreferences.dart';

class ShowMessages extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var groupId = _auth.currentUser!.uid.toString() +
        UserSharedPreferences.getUIDOfUser().toString();

    if (UserSharedPreferences.getTypeOfUser().toString() != "Utente") {
      groupId = UserSharedPreferences.getUIDOfUser().toString() +
          _auth.currentUser!.uid.toString();
    }

    //print(groupId);

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Messages")
          .doc(groupId.toString())
          .collection(groupId.toString())
          .orderBy("time", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        /*print("Shared...." +
            UserSharedPreferences.getFirstTimeChatting().toString() +
            "Snap..." +
            snapshot.data!.docs.length.toString());*/

        if (snapshot.data!.docs.length == 0) {
          UserSharedPreferences.setFirstTimeChatting(true);
        } else {
          UserSharedPreferences.setFirstTimeChatting(false);
        }

        /*print("Shared...." +
            UserSharedPreferences.getFirstTimeChatting().toString());*/

        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            primary: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, i) {
              QueryDocumentSnapshot x = snapshot.data!.docs[i];
              //print(x);
              return ListTile(
                  title: Column(
                crossAxisAlignment:
                    x['receiver']! == _auth.currentUser!.uid.toString()
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      x['message'],
                    ),
                    decoration: BoxDecoration(
                      color: x['receiver']! == _auth.currentUser!.uid.toString()
                          ? Colors.green.withOpacity(0.2)
                          : Colors.blue.withOpacity(0.2),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                  ),
                ],
              ));
            });
      },
    );
  }
}
