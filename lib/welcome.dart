
import 'package:aider/screens/bloodlogin.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  signOut() async{
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Bloodlogin()));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(   
    appBar: AppBar(   
    title: Text('BLOOD BANK'),  
    backgroundColor:Colors.blueGrey[900] 
    ),   
    body: Center(   
    child: Column(
      mainAxisAlignment:MainAxisAlignment.spaceAround,
      children:<Widget>[
 Text("Welcome Everyone",   
        style: TextStyle( color: Colors.black, fontSize: 30.0 ),), 
        ElevatedButton(style:ElevatedButton.styleFrom(primary: Colors.blueGrey[900]),child:const Text("Log Out"),onPressed:(){
          signOut();
        }, )
      ]
       
    ), 
    ) 
    );
  }
}