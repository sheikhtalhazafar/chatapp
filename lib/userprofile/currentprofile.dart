import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Myprofile extends StatelessWidget {
   Myprofile({super.key});
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(future: _firestore.collection('users').doc(_auth.currentUser!.uid).get(), builder: (context, snapshot){
          if(snapshot.hasData != null){
            return Column(
              children: [
                Text(snapshot.data!['name'])
              ],
            );
          }else{
            return Container();
          }
        }),
        Text(_auth.currentUser!.email.toString())
      ],
    );
  }
}