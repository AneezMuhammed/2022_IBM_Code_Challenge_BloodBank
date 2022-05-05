import 'dart:convert';

import 'package:aider/screens/blood_donor.dart';
import 'package:aider/screens/bloodlogin.dart';

// import 'package:aider/screens/chathome.dart';
import 'package:aider/screens/blooddash.dart';
import 'package:aider/screens/blood_donor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import 'package:aider/networking/posts.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:aider/widgets/bloodrowelement.dart';

// Position position;

class BloodRecipientList extends StatefulWidget {
  @override
  _BloodRecipientListState createState() => _BloodRecipientListState();
}

class _BloodRecipientListState extends State<BloodRecipientList> {
  int val = 1;
  List<Widget> list = [];
  List<Widget> l = [];
  var requestquery;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // fetchposts();

    super.initState();
    getApi();
  }

  var list1 = [];
  getApi() async {
    final User user = await _auth.currentUser;
    final uid = user.uid;
    print(uid);

    FirebaseFirestore.instance
        .collection('request')
        .where('uid', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      requestquery = querySnapshot.docs;

      setState(() {
        list1 = requestquery;
      });

      // if (querySnapshot.exists) {
      //   print('Request exists on the database');
      // final temp=documentSnapshot.data();
      // querySnapshot.docs.forEach((doc) {
      //     // requestquery.add(doc);
      //     // Map<String, dynamic>.from(doc.data());
      //     // requestquery.add(json.decode(doc.data()));
      //     // // print(doc.data().runtimeType);
      //     // var a=json.decode(doc.data());
      //     print(doc.data());
      //     print(doc["uid"]);
      //     print("Haiiiiiiiii");

      // });

      // print(requestquery);
      // Map<String, dynamic> data = documentSnapshot.data();
      // setState(() {
      //  username=data['name'];
      //  bloodgrp=data['blood_grp'];
      //  useremail=data['email'];
      //  userphone=data['phone'];
      //  userisWilling=data['isWilling'];
      // });

      // print(bloodgrp);
      // print(documentSnapshot.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: AppBar(
                automaticallyImplyLeading: false,
                title: Center(
                    child: Text(
                  'Request',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                )),
                backgroundColor: Color(0xFF2B2D42),
              ),
            ),
            body: ListView.builder(
                itemCount: list1.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DonorList(
                                  request_id: list1[index]['request_id'],
                                  latitude: list1[index]['latitude'],
                                  longitude: list1[index]['longitude'],
                                  blood_grp: list1[index]['blood_grp'])),
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.white10, // Set border color
                                  width: 3.0), // Set border width
                              borderRadius: BorderRadius.all(Radius.circular(
                                  10.0)), // Set rounded corner radius
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    color: Colors.grey,
                                    offset: Offset(1, 1))
                              ] // Make rounded corner of border
                              ),
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(30),
                          child: Row(
                            children: [
                              Text(
                                '${list1[index]['blood_grp']}',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 80,
                              ),
                              Text(
                                '${list1[index]['quantity']}',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(width: 100),
                              IconButton(
                                icon: new Icon(Icons.delete),
                                onPressed: () async {
                                  CollectionReference users = FirebaseFirestore
                                      .instance
                                      .collection('request');
                                  await users
                                      .doc(list1[index]['request_id'])
                                      .delete()
                                      .then((value) => print("Request Deleted"))
                                      .catchError((error) => print(
                                          "Failed to delete request: $error"));
                                          setState(() {
                                            getApi();
                                          });
                                },
                              )
                            ],
                          )));
                })));
  }
}
