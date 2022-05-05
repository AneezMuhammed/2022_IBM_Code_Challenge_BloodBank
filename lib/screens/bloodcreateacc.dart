// import 'package:aider/networking/auth.dart';
// import 'package:aider/screens/BloodregSuccess.dart';
import 'package:aider/screens/blooddash.dart';
import 'package:aider/welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import '../model/user_model.dart';

class BloodcreateAcc extends StatefulWidget {
  @override
  _BloodcreateAccState createState() => _BloodcreateAccState();
}

class _BloodcreateAccState extends State<BloodcreateAcc> {
  //Text editing controllers and validators for verification
  final _passcon = TextEditingController();
  final _mailcon = TextEditingController();
  final _confirmpasscon = TextEditingController();
  final _phonecon = TextEditingController();
  final _addresscon = TextEditingController();
  final _namecon = TextEditingController();
  final _bloodcon = TextEditingController();
  //bool _validateBlood = false;
  bool _validatePass = false;
  bool _validateEmail = false;
  bool _validateConPass = false;
  bool _validatePhone = false;
  bool _validateAddress = false;
  bool _validateName = false;
  int _value = 1;
  bool validated = false;

  List<String> bldgrp = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

   final _auth = FirebaseAuth.instance;
  
  // string for displaying the error Message
  String  errorMessage;
  //Aneez  chnage
  // Position position;
  // Future<Position> _getCurrentLocation() async {
  //   final position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   return position;
    
  // }
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
    
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      
      child: SafeArea(
        child: Scaffold(
      
          resizeToAvoidBottomInset: true,
          body: Container(
            decoration: BoxDecoration(
            
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      ' REGISTER',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                          color: Color(0xFF2B2D42)),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40.0,
                          ),

                          //****************************************************Name****************************************
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(0x802B2D42), width: 2),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    spreadRadius: 4)
                              ],
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 40,
                            ),
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              //text controller
                              controller: _namecon,
                              cursorColor: Color(0xFF2B2D42),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Name",
                                labelStyle: TextStyle(
                                  color: Color(0xFF2B2D42),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                ),
                                //error checking message
                                errorText:
                                    _validateName ? 'Enter a name.' : null,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          //************************************blood*********************************************** */
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 0,
                              ),
                              Text(
                                "Blood group :",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Color(0x802B2D42), width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        spreadRadius: 4)
                                  ],
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 40,
                                ),
                                padding: EdgeInsets.all(8),
                                child: DropdownButton(

                                    //  focusColor: Color(0x802B2D42),
                                    value: _value,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text(
                                          "A+",
                                          style: TextStyle(
                                            color: Color(0x802B2D42),
                                            fontSize: 15.0,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          "A-",
                                          style: TextStyle(
                                            color: Color(0x802B2D42),
                                            fontSize: 15.0,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        value: 2,
                                      ),
                                      DropdownMenuItem(
                                          child: Text(
                                            "B+",
                                            style: TextStyle(
                                              color: Color(0x802B2D42),
                                              fontSize: 15.0,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          value: 3),
                                      DropdownMenuItem(
                                          child: Text(
                                            "B-",
                                            style: TextStyle(
                                              color: Color(0x802B2D42),
                                              fontSize: 15.0,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          value: 4),
                                      DropdownMenuItem(
                                          child: Text(
                                            "AB+",
                                            style: TextStyle(
                                              color: Color(0x802B2D42),
                                              fontSize: 15.0,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          value: 5),
                                      DropdownMenuItem(
                                          child: Text(
                                            "AB-",
                                            style: TextStyle(
                                              color: Color(0x802B2D42),
                                              fontSize: 15.0,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          value: 6),
                                      DropdownMenuItem(
                                          child: Text(
                                            "O+",
                                            style: TextStyle(
                                              color: Color(0x802B2D42),
                                              fontSize: 15.0,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          value: 7),
                                      DropdownMenuItem(
                                          child: Text(
                                            "O-",
                                            style: TextStyle(
                                              color: Color(0x802B2D42),
                                              fontSize: 15.0,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          value: 8),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value;
                                      });
                                      
                                      _bloodcon.text = bldgrp[value - 1];
                                      print(_bloodcon.text);
                                    }),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          //***************************************Phone*************************************************
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(0x802B2D42), width: 2),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    spreadRadius: 4)
                              ],
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 40,
                            ),
                            padding: EdgeInsets.all(10),
                            child: TextField(
                                //text controller
                                controller: _phonecon,
                                keyboardType: TextInputType.number,
                                cursorColor: Color(0xFF2B2D42),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Phone",
                                  labelStyle: TextStyle(
                                    color: Color(0xFF2B2D42),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                  //error checking message
                                  errorText: _validatePhone
                                      ? 'Enter a valid mobile number.'
                                      : null,
                                )),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          //*****************************************Email**************************************************
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(0x802B2D42), width: 2),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    spreadRadius: 4)
                              ],
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 40,
                            ),
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              //controller
                              controller: _mailcon,
                              cursorColor: Color(0xFF2B2D42),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Email",
                                labelStyle: TextStyle(
                                  color: Color(0xFF2B2D42),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                ),
                                //error message
                                errorText: _validateEmail
                                    ? 'Enter a valid Email.'
                                    : null,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          //*******************************************Address***********************************************
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(0x802B2D42), width: 2),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    spreadRadius: 4)
                              ],
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 40,
                            ),
                            padding: EdgeInsets.all(10),
                            // to scroll down
                            child: new SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              reverse: true,
                              child: TextField(
                                //controller
                                controller: _addresscon,
                                //for multiple lines
                                maxLines: null,
                                cursorColor: Color(0xFF2B2D42),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Address",
                                  labelStyle: TextStyle(
                                    color: Color(0xFF2B2D42),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                  //error message
                                  errorText: _validateAddress
                                      ? 'Enter a valid address.'
                                      : null,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          //*******************************************password*******************************************************************
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(0x802B2D42), width: 2),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    spreadRadius: 4)
                              ],
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 40,
                            ),
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              //controller
                              controller: _passcon,
                              obscureText: true,
                              cursorColor: Color(0xFF2B2D42),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Password",
                                labelStyle: TextStyle(
                                  color: Color(0xFF2B2D42),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                ),
                                //error message
                                errorText: _validatePass
                                    ? 'Password should be atleast 8 characters long.'
                                    : null,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          //************************************confirm password***********************************************************
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(0x802B2D42), width: 2),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    spreadRadius: 4)
                              ],
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 40,
                            ),
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              //controller
                              controller: _confirmpasscon,
                              obscureText: true,
                              cursorColor: Color(0xFF2B2D42),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Confirm Password",
                                labelStyle: TextStyle(
                                  color: Color(0xFF2B2D42),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                ),
                                //error message
                                errorText: _validateConPass
                                    ? 'Passwords do not match.'
                                    : null,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          //*******************************************Create acc button*************************************************
                          ButtonTheme(
                            minWidth: 50.0,
                            height: 60.0,
                            child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                color: Color(0xFF2B2D42),
                                onPressed: () async {
                                  // Aneez change
                                  
                                 position = await _getCurrentLocation();
                                  setState(() {
                                    //validating for password
                                    if (_passcon.text.isEmpty ||
                                        _passcon.text.length < 8) {
                                      _validatePass = true;
                                    } else {
                                      _validatePass = false;
                                    }
                                    
                                    //validating for email
                                    if (_mailcon.text.isEmpty ||
                                         !RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                          .hasMatch(_mailcon.text)) {
                                      _validateEmail = true;
                                    } else {
                                      _validateEmail = false;
                                    }
                                    //validating for confirm password
                                    if ((_confirmpasscon.text !=
                                            _passcon.text) ||
                                        _confirmpasscon.text.length < 8) {
                                      _validateConPass = true;
                                    } else {
                                      _validateConPass = false;
                                    }
                                    //validating for phone number
                                    if (_phonecon.text.length < 10 ||
                                        _phonecon.text.isEmpty ||_phonecon.text.contains('.')||_phonecon.text.contains(' ')||_phonecon.text.contains(',')||_phonecon.text.contains('-')) {
                                       
                                      _validatePhone = true;
                                    } else {
                                      _validatePhone = false;
                                    }
                                    //validating for address
                                    if (_addresscon.text.isEmpty) {
                                      _validateAddress = true;
                                    } else {
                                      _validateAddress = false;
                                    }
                                    if (_namecon.text.isEmpty) {
                                      _validateName = true;
                                    } else {
                                      _validateName = false;
                                    }
                                    // only goes to success page if all validators are false.
                                    if (_validateAddress == false &&
                                        _validateName == false &&
                                        _validatePhone == false &&
                                        _validateConPass == false &&
                                        _validatePass == false &&
                                        _validateEmail == false) {
                                      validated = true;
                                 
                                      print(_namecon.text.characters);

                                      return null;
                                    }
                                  });
                                  if (validated) {
                                    signUp(_mailcon.text, _passcon.text);
                                  
                                  }
                                },
                                child: Text(
                                  'Create Account',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.white),
                                )),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

   void signUp(String email, String password) async {
    print(email);
    print(password);
    print("Hello signup");
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e.message);
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

   postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = _auth.currentUser;

    UserModel userModel = UserModel();
    if(_value==1){
      _bloodcon.text='A+';
    }
    // writing all the values
    userModel.email = user.email;
    userModel.uid = user.uid;
    userModel.name = _namecon.text;
    userModel.phone = _phonecon.text;
    userModel.address=_addresscon.text;
    userModel.blood_grp=_bloodcon.text;
  userModel.isWilling=false;
  userModel.latitude=position.latitude;
  userModel.longitude=position.longitude;
  
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => Blooddash()),
        (route) => false);
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
