import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DonorList extends StatefulWidget {
 final String request_id;
 final double latitude;
 final double longitude;
 final String blood_grp;
 
  DonorList({this.request_id,this.latitude,this.longitude,this.blood_grp});

  @override
 
  State<DonorList> createState() => _DonorListState();
   
}

class _DonorListState extends State<DonorList> {
  var temp;
   var requestquery;
   var finallist=[];
   var newfinallist;
   var list1=[];
     double calculateDistance(lat1, lon1, lat2, lon2){

       
        var p = pi / 180;
      var a = 0.5 -cos((lat2 - lat1) * p) / 2 +
          cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
       return(12742 * asin(sqrt(a)));
      
    // print("Inside calculate distance");
    // print(lat1);
    // print(lon1);
    // print(lat2);
    // print(lon2);
    // var p = 0.017453292519943295;

 
    // var a = 0.5 - cos(((lat2 - lat1) * p))/2 +
    //     cos(lat1 * p) * cos(lat2 * p) *
    //         (1 - cos((lon2 - lon1) * p))/2;
    // return 12742 * asin(sqrt(a));
  }
  sortDistance(List l3)async{
    print("insiiiiiiiide");
    for(var i=0;i<l3.length-1;i++){
      for(var j=0;j<l3.length-1-i;j++){
        if(l3[j][5]>l3[j+1][5]){
          temp=l3[j];
          l3[j]=l3[j+1];
          l3[j+1]=temp;
        }
      }
    }
    print("l3");
     setState(() {
          finallist=l3;
        });
    print(l3);
    // return l3;
  }
   final _auth = FirebaseAuth.instance;
   calculateAllDistance(List l1,double latitude1,double longitude1) async{
            print("helloooooooooooooooo");
            print("l1$l1");
            print("latitude$latitude1");
            print("longi$longitude1");
            print(latitude1.runtimeType);
            for(var i=0;i<l1.length;i++){
                var b= calculateDistance(latitude1, longitude1,l1[i][1], l1[i][2]);
                print("Distance{$b}");
                l1[i].add(b);
            }
            print(l1);
        await sortDistance(l1);
       
        print("comeback from sort");
        print(finallist);
        //  setState(()  {
        //         // print(list3[0][])
               
        //        finallist=await sortDistance(l1);
                
        //     });
        // print("finallist ${finallist}");
        
        // return finallist;
   }
   void initState()  {
    // fetchposts();

    super.initState();
     getApi();
     
        
     
     
        
    // print(list3);
  }
  var list2=[];
  var list3=[];
  getApi() async{
       final User user=await _auth.currentUser;
    final uid=user.uid;
    print(uid);
    // CollectionReference users = FirebaseFirestore.instance.collection('users');
  if(uid!=null){
await FirebaseFirestore.instance
    .collection('users')
    .where('isWilling',isEqualTo: true)
    .where('blood_grp',isEqualTo:widget.blood_grp )
    .get()
    
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          list2=[];
          list2.add(doc["uid"]);
          // print(list2);
         
          list2.add(doc["latitude"]);
          
          list2.add(doc['longitude']);
          
          list2.add(doc['phone']);
          list2.add(doc['name']);
          
          list3.add(list2);
          print(list3);
            // print(doc["name"].runtimeType);
          //  print(doc.data());
          //  requestquery.add(doc.data());
        });

    }
    
    );
  }
    await calculateAllDistance(list3,widget.latitude,widget.longitude);
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
           automaticallyImplyLeading: false,
            
          title: Center(child: Text('Donors',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),)),
          backgroundColor:Color(0xFF2B2D42),
        ),),
        
            body: ListView.builder(
              itemCount:finallist.length,
                // itemCount: finallist==null?0:finallist.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                   
                    child: Container(
                   
                  decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Colors.white10, // Set border color
            width: 3.0),   // Set border width
        borderRadius: BorderRadius.all(
            Radius.circular(10.0)), // Set rounded corner radius
        boxShadow: [BoxShadow(blurRadius: 4,color: Colors.grey,offset: Offset(1,1))] // Make rounded corner of border
      ),
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(30),
                    
                    child: Row(
                      children: [
Text(
                      '${finallist[index][5].round()}km away',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(width: 60,),
                        Text(
                      '${finallist[index][4]}',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.black),
                        ),
                          SizedBox(width:50,),
                        Spacer(),
                        IconButton(
                                icon: new Icon(Icons.phone),
                                onPressed: () async {
                                  launch("tel://${finallist[index][3]}");
                                })
                      ],
                    )
                  )
                  );
                }
                )
                )
    );
  }
}