
import 'package:aider/model/user_model.dart';
import 'package:aider/screens/bloodcreateacc.dart';
import 'package:aider/screens/blooddash.dart';
import 'package:aider/welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

//import 'package:http/http.dart';

String bloodloggeduser = "NA";
String bloodgrp = "NA";
String username = "NA";
String useremail = "NA";
String userphone = "NA";
String bloodloginid = 'NA';
String bloodcontact = 'NA';
bool iswilling = false;
bool userisWilling;
class Bloodlogin extends StatefulWidget {
  @override
  _BloodloginState createState() => _BloodloginState();
}

class _BloodloginState extends State<Bloodlogin> {
  final _bloodlogemail = TextEditingController();
  final _bloodlogpass = TextEditingController();
  bool _validateBloodemail = false;
  bool _validateBloodpass = false;
  bool validated = false;
final _auth = FirebaseAuth.instance;
  String errorMessage;
bool serviceEnabled;
  LocationPermission permission;
Position position;
  Future<Position> _getCurrentLocation() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
if (!serviceEnabled) {
  return Future.error('Location services are disabled');
}

permission = await Geolocator.checkPermission();
if (permission == LocationPermission.denied) {
  permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
    return Future.error('Location permissions are denied');
  }
}

if (permission == LocationPermission.deniedForever) {
  return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
}

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
    //print("inside function $position"); //longitude and latitude
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFEDF2F4),
          
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(),
            Text(
              'BLOOD BANK LOG IN',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 72.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0x802B2D42), width: 2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 5, spreadRadius: 4)
                ],
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _bloodlogemail,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Color(0xFF2B2D42),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                  suffixIcon: Icon(
                    Icons.mail,
                    size: 20.0,
                    color: Color(0xFF2B2D42),
                  ),
                  hintStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Color(0x802B2D42)),
                  errorText:
                      _validateBloodemail ? 'Enter a valid email.' : null,
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0x802B2D42), width: 2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 5, spreadRadius: 4)
                ],
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _bloodlogpass,
                obscureText: true,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Color(0xFF2B2D42),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                  suffixIcon: Icon(
                    Icons.lock,
                    size: 20.0,
                    color: Color(0xFF2B2D42),
                  ),
                  hintStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Color(0x802B2D42)),
                  errorText: _validateBloodpass ? 'Enter a valid password' : null,
                ),
              ),
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      //GO TO CREATE NEW ACC
                      onPressed: () {
                       
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => BloodcreateAcc(),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          'New user? Create an account.',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Color(0xFF2B2D42)),
                        ),
                      ),
                    ),
                    // FlatButton(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(20.0)),
                    //     onPressed: () {
                    //       print('Pressed forgot password');
                    //     },
                    //     child: Text(
                    //       'Forgot password?',
                    //       style: TextStyle(
                    //           fontFamily: 'Montserrat',
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 12.0,
                    //           color: Color(0xFF2B2D42)),
                    //     )),
                  ]),
            ),
            SizedBox(
              height: 72.0,
            ),
            //SizedBox(),
            FlatButton(
              minWidth: 50.0,
              height: 60.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: Color(0xFF2B2D42),
              onPressed: () async {
                position = await _getCurrentLocation();
                  setState(() {
                                    //validating for password
                                    if (_bloodlogpass.text.isEmpty ||
                                        _bloodlogpass.text.length < 8) {
                                      _validateBloodpass= true;
                                    } else {
                                      _validateBloodpass = false;
                                    }
                                    //validating for email
                                     if (_bloodlogemail.text.isEmpty ||
                                         !RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                          .hasMatch(_bloodlogemail.text)) {
                                       _validateBloodemail= true;
                                    } else {
                                      _validateBloodemail = false;
                                    }
                                   
                                    // only goes to success page if all validators are false.
                                    if (_validateBloodemail== false &&
                                       
                                        _validateBloodpass == false
                                        ) {
                                      validated = true;
                                 
                                      print("Login entered");

                                      return null;
                                    }
                                  });
                                  if (!validated) {
                                    signIn(_bloodlogemail.text, _bloodlogpass.text);
                                    signIn('aneezmuhammed11@gmail.com', '12345678');
                                  
                                  }
             
              },
              child: Text(
                'Log In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
           
          ],
        ),
      ),
    );
  }
  void postLatitudeLongitude() async{
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = _auth.currentUser;

    UserModel userModel = UserModel();
     userModel.latitude=position.latitude;
  userModel.longitude=position.longitude;
  await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .update({'latitude':position.latitude});
 await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .update({'longitude':position.longitude});
  }
  void signIn(String email,String password) async{
     try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  postLatitudeLongitude(),


                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Blooddash())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage);
        print(error.code);
      }
  }
}

// createdialogbox(BuildContext context, String text) {
//   return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//             backgroundColor: Colors.redAccent[600],
//             title: Text(
//               "Alert",
//               style: TextStyle(fontFamily: "Montserrat-Bold.ttf"),
//             ),
//             content: Text(
//               text,
//               style: TextStyle(fontFamily: "Montserrat-Bold.ttf"),
//             ));
//       });
// }
