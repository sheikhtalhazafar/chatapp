import 'package:chatapp/chatroom/chatroom.dart';
import 'package:chatapp/screens/auth_screens/loginscree.dart';
import 'package:chatapp/userprofile/currentprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with WidgetsBindingObserver{
  Map<String, dynamic>? userMap;
  final TextEditingController _searchcontroller = TextEditingController();
    final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    setstatus("online");
  }
  void setstatus(String status)async{
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status":status
    });
  }

    @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setstatus("online");
      
    } else {
      // offline
      setstatus("ofline");
    }
  }


  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onsearch() async{
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    setState(() {
      isloading = true;
    });
    await _firestore.collection('users').where('email', isEqualTo: _searchcontroller.text).get().then((value) {
      if(value.docs.isNotEmpty){
        // User found, update userMap
              setState(() {
        userMap = value.docs[0].data();
         isloading = false;
      });
      }else{  
            // User not found, set a default value
    setState(() {
      userMap = {'error': 'User not found'};
      isloading = false;
    });
    print(userMap);
      }
      print(userMap);
    });
  }
  @override
 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple.shade200,
      ),
      drawer: Drawer(
        child:Column(
          children: [
            Myprofile(),
            ElevatedButton(onPressed:()async{
            FirebaseAuth _auth = FirebaseAuth.instance;
             await _auth.signOut().then((value) {
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
             });        
            
          }, child: Text('logout')),
          ],
        )
      ),
      body: isloading ? const Center(child: CircularProgressIndicator()) : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: _searchcontroller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'search',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            onsearch();
          }, child: const Text('search')),

          userMap!=null ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: (){
                        String roomId = chatRoomId(
                            _auth.currentUser!.displayName!,
                              userMap!['name']);

                Navigator.push(context, MaterialPageRoute(builder: (contet)=>ChatRoom(
                  ChatRoomId: roomId,
                  usermap: userMap!,
                )));
              },
              leading: const Icon(Icons.account_box, color: Colors.black,),
              title:    Text( userMap!['name'].toString()),
              subtitle: Text(userMap!['email'].toString()),
              trailing: const Icon(Icons.chat,color: Colors.black,),
            ),
          ) : const SizedBox()
        ],
      ),
    );
  }
}