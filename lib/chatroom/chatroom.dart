import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ChatRoom extends StatelessWidget {
  final Map<String, dynamic> usermap;
  final String ChatRoomId;
   ChatRoom({super.key,
   required this.usermap
   , required this.ChatRoomId
   });

  final TextEditingController _message = TextEditingController();
       
     FirebaseAuth _auth = FirebaseAuth.instance;
     FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
     void onsendmessage() async{
      if(_message.text.isNotEmpty){
        Map<String, dynamic> message ={
          "send by" : _auth.currentUser!.displayName,
          "message" : _message.text,
          "time" : FieldValue.serverTimestamp()
        };

        await _firestore.collection('chatroom').doc(ChatRoomId).collection('chats').add(message);

        _message.clear();
      }else{
        print('enter some text');
      }
     }

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: _firestore.collection('users').doc(usermap['uid']).snapshots(), 
          builder: (context,snapshot){
            if(snapshot.hasData!=null){
              return  Container(
                child: Column(
                  children: [
                    Text(usermap['name']),
                    Text(snapshot.data!['status'],style: const TextStyle(
                      fontSize: 14
                    ),),
                  ],
                ),
              );
            }else{
              return Container();
            }
          }),
        // title: Text(usermap['name']),
      ),
      body: Container(
        height: size.height /1.25,
        width: size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('chatroom').doc(ChatRoomId).collection('chats').orderBy("time", descending: false).snapshots(), 
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.data != null){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  //    Map<String, dynamic> map = snapshot.data!.docs[index]
                  //           .data() as Map<String, dynamic>;
                  // return message(size, map);
                  return Container(
                     width: size.width,
      alignment: snapshot.data!.docs[index]['send by'] == _auth.currentUser!.displayName ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.purple
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
       
                    child: Text(snapshot.data!.docs[index]['message'], style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white),)));
              });
            }else{
              return Container();
            }
          }),
      ),
      bottomNavigationBar: Container(
        height: size.height /10,
        width: size.width,
        alignment: Alignment.center,
        child: Container(
              height: size.height /12,
        width: size.width /1.1, 
        child: Row(
          children: [
            Container(
                 height: size.height /12,
        width: size.width / 1.3,
        child: TextField(
          controller: _message,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            )
          ),
        ),
            ),
           IconButton(onPressed: (){
            onsendmessage();
           }, icon: const Icon(Icons.send))
          ],
        ),
        ),
      ),
    );
  }
    Widget message(Size size, Map<String, dynamic> map){
    return Container(
      width: size.width,
      alignment: map['sendby'] == _auth.currentUser!.displayName ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.purple
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Text(map['message'],style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white),),
      ),
    );
  }
}
