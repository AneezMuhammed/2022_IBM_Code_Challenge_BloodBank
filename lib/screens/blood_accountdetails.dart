// import 'package:aider/networking/posts.dart';

import 'package:aider/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aider/screens/blooddash.dart';
import 'package:aider/screens/bloodlogin.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:aider/networking/auth.dart';

class BloodAccountDetails extends StatefulWidget {
  @override
  _BloodAccountDetailsState createState() => _BloodAccountDetailsState();
}

List<Widget> postlist = [];

//class _BloodDetailsState extends State<BloodDetails> {
bool isswitched = iswilling;

class _BloodAccountDetailsState extends State<BloodAccountDetails> {
  int getPageIndex = 0;
  final _description = TextEditingController();
  bool _validatedescription = false;
  final _quantity = TextEditingController();
  bool _validatequantity = false;
  int _value = 1;
  String userid;
  PageController pageController;
  whenPageChanges(int pageIndex) {
    setState(() {
      print(pageIndex);
      this.getPageIndex = pageIndex;
    });
  }
final _auth = FirebaseAuth.instance;

 
  getApi()async{
    final User user=await _auth.currentUser;
    final uid=user.uid;
    userid=user.uid;
    print("$uid");
    }

  void initState() {
    super.initState();
    getApi();
    pageController = PageController();
  }

  onTabChangePage(int pageIndex) {
    print(pageIndex);

    pageController.jumpToPage(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: new BottomAppBar(
        color: Color(0xFF2B2D42),
        shape: CircularNotchedRectangle(),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.circle,
            //     color: Color(0xFF2B2D42),
            //   ),
            // ),
          ],
        ),
      ),
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
            // image: DecorationImage(
            //   image: AssetImage("images/background.jpg"),
            //   fit: BoxFit.cover,
            // ),
          ),
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "MY ACCOUNT",
                style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40.0),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width - 50,
                child: Column(
                  children: <Widget>[                 
                    Container(
                      child: Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFF2B2D42), width: 2),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          child: PageView(
                            children: <Widget>[details()],
                            controller: pageController,
                            onPageChanged: whenPageChanges,
                            
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  details() {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // SizedBox(height: 30),
        Row(
          children: [
            SizedBox(width: 38.0),
            Text(
              "Name : $username",
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                color: Color(0xFF2B2D42),
              ),
            ),
          ],
        ),
        //sized box might have to remove while actual name is displayed

        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 38.0),
            Text(
              "Blood Group : $bloodgrp",
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                color: Color(0xFF2B2D42),
              ),
            ),
            //sized box might have to remove while actual name is displayed
          ],
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 38),
            Text(
              "Phone : $userphone",
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                color: Color(0xFF2B2D42),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 38),
            Text(
              "Email :\n $useremail",
              style: TextStyle(
                fontSize: 17.0,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                color: Color(0xFF2B2D42),
              ),
            ),
            /* SizedBox(width: 202.0),
                    SizedBox(width: 16.7)*/
          ],
        ),
        SizedBox(height: 20.0),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(width: 38),
              Text(
                "I want to donate ",
                style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2B2D42),
                ),
              ),
              Switch(
                activeColor: Color(0xFF2B2D42),
                value: userisWilling,
                onChanged: (value) async {
                  print("hai vhfg");
                  var response=changeStatus();
                  // var response = await becomedonor(bloodloginid, value);
                  // if (response["status"] == 200) {
                    setState(() {
                      userisWilling = userisWilling;
                      print(userisWilling);
                    });
                  // }
                },
              ),
            ],
          ),
        )
      ],
    );
   
  }
   changeStatus() async{
     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
     UserModel userModel = UserModel();
     userisWilling=!userisWilling;
     await firebaseFirestore
        .collection("users")
        .doc(userid)
        .update({'isWilling':userisWilling});
    Fluttertoast.showToast(msg: "Status updated successfully :) ");
  }
}

int i = 0;

// class Posts extends StatefulWidget {
//   @override
//   _PostsState createState() => _PostsState();
// }

// class _PostsState extends State<Posts> {
//   @override
//   void initState() {
//     fetchpost(bloodloginid);
//     super.initState();
//   }

//   Function refresh() {
//     fetchpost(bloodloginid);
//   }

//   fetchpost(email) async {
  
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(children: postlist);
//   }
// }

// class Posttile extends StatelessWidget {
//   final String name;
//   final int id;
//   final Function refresh;
//   Posttile({this.name, this.id, this.refresh});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 1),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Color(0xFFEDF2F4),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 10,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               children: [
//                 Text(
//                   name,
//                   style: TextStyle(
//                       fontFamily: 'Montserrat',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20.0,
//                       color: Color(0xFF2B2D42)),
//                 ),
//               ],
//             ),
//             FlatButton(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0)),
//               //    padding: EdgeInsets.fromLTRB(29.5, 20, 29.5, 20),
//               color: Color(0xFF2B2D42),
//               onPressed: () async {
//                 // print('pressed');
                
//                 // var response = await blooddeletepost(id);
//                 // print(bloodloginid);
//                 // await refresh();
                
//               },
//               child: Text(
//                 'Delete',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 15,
//                   fontFamily: 'Montserrat',
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
