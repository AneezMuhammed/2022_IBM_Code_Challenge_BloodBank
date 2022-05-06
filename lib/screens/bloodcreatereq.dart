// import 'package:aider/networking/posts.dart';
// import 'package:aider/screens/blood_reclist.dart';

import 'package:aider/model/request_model.dart';
import 'package:aider/model/user_model.dart';
import 'package:aider/screens/blooddash.dart';
import 'package:aider/screens/bloodlogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:aider/screens/bloodwillbenotified.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:aider/screens/gmap.dart';

// import 'package:geolocator/geolocator.dart';

// void main() {
//   runApp(MaterialApp(home: Bloodcreatereq()));
// }

class Bloodcreatereq extends StatefulWidget {
  @override
  _BloodcreatereqState createState() => _BloodcreatereqState();
}

class _BloodcreatereqState extends State<Bloodcreatereq> {
  final _description = TextEditingController();
  bool _validatedescription = false;
  final _quantity = TextEditingController();
  bool _validatequantity = false;
  final _bloodconreq = TextEditingController();
  bool _validatebld = false;
  int _value = 1;
  bool validate = false;
  String userid;
  bool serviceEnabled;
  String latitude;
  String longitude;
LocationPermission permission;
  List<String> bldgrp = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

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
  final _auth = FirebaseAuth.instance;

  void initState(){
    super.initState();
    print("asdfgh");
    getApi();
  }
  getApi()async{
    final User user=await _auth.currentUser;
    final uid=user.uid;
    userid=user.uid;
    print("$uid");
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //bottom notched bar
        // bottomNavigationBar: new BottomAppBar(
        //   color: Color(0xFF2B2D42),
        //   shape: CircularNotchedRectangle(),
        //   child: new Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: <Widget>[
        //       IconButton(
        //         onPressed: () {},
        //         icon: Icon(
        //           Icons.circle,
        //           color: Color(0xFF2B2D42),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // floatingActionButton: new FloatingActionButton(
        //   backgroundColor: Color(0xFF2B2D42),
        //   child: Icon(Icons.home_outlined),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //bottom notched bar ends
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: BoxDecoration(
                color: Color(0xFFEDF2F4),
                // image: DecorationImage(
                //     image: AssetImage('images/background.jpg'))
                    ),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "CREATE NEW REQUEST",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2B2D42),
                  ),
                ),
                SizedBox(height: 80.0),
                Row(
                  //Row contains Select Type and Dropdown List
                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Select Blood group : ",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2B2D42),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.all(5.0),
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
                            _bloodconreq.text = bldgrp[value - 1];
                          }),
                    )
                  ],
                ), // Select Type ends here
                SizedBox(height: 50),
                // new Divider(),
                Row(
                  //Row contains Description and TextField
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 55.0),
                    Text(
                      "Description : ",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2B2D42),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: _description,
                          maxLines: null,
                          cursorColor: Color(0xFF2B2D42),
                          decoration: InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Color(0x802B2D42)),
                            errorText: _validatedescription
                                ? 'Describe the item.'
                                : null,
                          ),
                        ),
                      ),
                    )
                  ],
                ), // Description ends here
                SizedBox(height: 20.0),
                Row(
                  //Row Contains Quantity and TextField

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 50),
                    Text(
                      "Quantity : ",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2B2D42),
                      ),
                    ),
                    // SizedBox(width: 10.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: _quantity,
                          maxLines: null,
                          cursorColor: Color(0xFF2B2D42),
                          decoration: InputDecoration(
                            hintText: "Quantity",
                            hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Color(0x802B2D42)),
                            errorText: _validatequantity
                                ? 'Enter the quantity.'
                                : null,
                          ),
                        ),
                      ),
                    )
                  ],
                ), //Quantity ends here
                SizedBox(height: 50.0),
              
                ButtonTheme(
                  minWidth: 50.0,
                  height: 60.0,
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Color(0xFF2B2D42),
                      onPressed: () async {
                      
                       position = await _getCurrentLocation();
                        setState(() {
                          if (_description.text.isEmpty) {
                            _validatedescription = true;
                          } else {
                            _validatedescription = false;
                          }
                          if (_quantity.text.isEmpty) {
                            _validatequantity = true;
                          } else {
                            _validatequantity = false;
                          }
                          if (_validatedescription == false &&
                              _validatequantity == false) {
                            validate = true;
                           
                            return null;
                          }
                        });
                        if (validate) {
                          print("Validated");
                          print(position.latitude.runtimeType);
                          print(position.longitude);
                          // latitude=toString(p)
                          postRequestDetailsToFirestore();
                        }
                      
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            )
            ));
  }
  postRequestDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // User user = _auth.currentUser;

    RequestModel requestModel = RequestModel();
    if(_value==1){
      _bloodconreq.text='A+';
    }
    // writing all the values
  
    requestModel.description = _description.text;
   var uuid=Uuid();
requestModel.request_id=uuid.v1(); 
var temp= requestModel.request_id; 
requestModel.quantity = _quantity.text;
requestModel.blood_grp = _bloodconreq.text;
requestModel.latitude=position.latitude;
requestModel.longitude=position.longitude;
requestModel.uid=userid;
    await firebaseFirestore
        .collection("request")
        .doc(temp)
        .set(requestModel.toMap());
    Fluttertoast.showToast(msg: "request created successfully :) ");

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
