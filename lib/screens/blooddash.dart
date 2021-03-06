// import 'package:aider/screens/aboutsection-receiver.dart';
// import 'package:aider/screens/blood_accountdetails.dart';
// import 'package:aider/screens/bloodcreatereq.dart';
import 'package:aider/screens/blood_accountdetails.dart';
import 'package:aider/screens/blood_reclist.dart';
import 'package:aider/screens/bloodcreatereq.dart';
import 'package:aider/screens/bloodlogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:aider/screens/bloodprereq.dart';
// import 'package:aider/screens/blood_reclist.dart';
import 'package:flutter/material.dart';
// import 'package:aider/screens/chooseSection.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as store;

class Blooddash extends StatefulWidget {
  @override
  _BlooddashState createState() => _BlooddashState();
}

class _BlooddashState extends State<Blooddash> {
  final _auth = FirebaseAuth.instance;
final _firestore = store.FirebaseFirestore.instance;


  void initState(){
    super.initState();
    print("asdfgh");
    getApi();
  }
  getApi()async{
    final User user=await _auth.currentUser;
    final uid=user.uid;
    print("$uid");
    
    // FirebaseFirestore.instance
    // .collection('users')
    // .get()
    // .then((QuerySnapshot querySnapshot) {
    //     querySnapshot.docs.forEach((doc) {
    //         print(doc["name"]);
    //     });
    // });
    FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .get()
    .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        final temp=documentSnapshot.data();
        print(temp);
        Map<String, dynamic> data = documentSnapshot.data();
        setState(() {
                                         username=data['name'];
                                         bloodgrp=data['blood_grp']; 
                                         useremail=data['email'];
                                         userphone=data['phone'];
                                         userisWilling=data['isWilling'];
                                      });
       
        print(bloodgrp);
        // print(documentSnapshot.data());
      }
    });
  

  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   title: Image.asset('images/logo.png',),
          //   backgroundColor: Color(0xFFEDF2F4),
          // ),
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage("images/background.jpg"),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: deviceHeight * 0.30,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 5,
                              blurRadius: 4)
                        ],
                        color: Color(0xFF2B2D42),
                        // borderRadius: new BorderRadius.only(
                        //   bottomLeft: const Radius.circular(50.0),
                        //   bottomRight: const Radius.circular(50.0),
                        // )
                        ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Center(
                          child: Text(
                            'Welcome!',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 60.0,
                                color: Color(0xFFFFFFFF)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '$username',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Color(0xFFFFFFFF)),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              '$bloodgrp ve',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Color(0xFFFFFFFF)),
                            ),
                            SizedBox(
                              width: 40.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              alignment: Alignment.topRight,
                              child: FlatButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Bloodlogin()),
                                        (route) => false);
                                  },
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 30.0),
                        //**************************************add and list button*****************************************
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //*************************************BUTTONS********************************************
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                color: Color(0xFF2B2D42),
                                //GO TO create request
                                onPressed: () async {
                                  print("hello pressed");
                                  Navigator.push(
                                    
                                  context,
                                  MaterialPageRoute(builder: (context) => Bloodcreatereq()),
                                    );
                                },
                                padding: EdgeInsets.all(25.0),
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ),
                              SizedBox(width: 70.0),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                color: Color(0xFF2B2D42),
                                //GO TO PREVIOUS requests
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BloodRecipientList(),
                                    ),
                                  );
                                },
                                padding: EdgeInsets.all(25.0),

                                child: Icon(
                                  Icons.format_list_bulleted,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ),
                            ]),
                        SizedBox(height: 10.0),
                        //**********************************************TEXT********************************* */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //SizedBox(width: 20.0),
                            Text(
                              'Post Request',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Color(0xFF2B2D42)),
                            ),
                            SizedBox(width: 75.0),
                            Text(
                              'Requests',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Color(0xFF2B2D42)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        //******************************bottom one button section****************************************************
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 50.0),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                color: Color(0xFF2B2D42),
                                //GO TO My Account
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BloodAccountDetails(),
                                    ),
                                  );
                                },
                                padding: EdgeInsets.all(25.0),
                                child: Icon(
                                  Icons.account_box,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ),
                              SizedBox(width: 50.0),
                            ]),
                        SizedBox(height: 10.0),
                        Row(
                          //******************************************TEXT FOR BOTTOM one BUTTONS******************** */
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 40.0),
                            Text(
                              'My Account',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Color(0xFF2B2D42)),
                            ),
                            SizedBox(width: 35.0),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  //*******************************blood donation******************************
                  /* ButtonTheme(
                    minWidth: 50.0,
                    height: 60.0,
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        color: Color(0xFF2B2D42),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BloodRecipientList(),
                            ),
                          );
                        },
                        child: Text(
                          'I want to donate',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        )),
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
