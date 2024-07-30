import 'package:chatapp/homescreen.dart';
import 'package:chatapp/screens/auth_screens/loginscree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
    FirebaseAuth _auth = FirebaseAuth.instance;
    void initState() {
    // TODO: implement initState
    super.initState();
    if(_auth.currentUser!=null){
      Future.delayed(Duration(seconds: 3),(){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homescreen()));
      });
     
    }else{
       Future.delayed(Duration(seconds: 3),(){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body:  Center(child: Center(child: Text("Lets Chat Buddy..", style: TextStyle(fontSize: 30),))));
  }
}