import 'package:chatapp/homescreen.dart';
import 'package:chatapp/screens/auth_screens/methods/auh_methods.dart';
import 'package:chatapp/screens/auth_screens/signupscreen.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final _formkey = GlobalKey<FormState>();
final TextEditingController _emalcontroller = TextEditingController();
final TextEditingController _passwodcontroller = TextEditingController();
bool loading = false;


  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
     
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple.shade200,
        automaticallyImplyLeading: false,
        title: Text('Welcome to We Chat'),
      ),
      body: SingleChildScrollView(
        child: Column(
         
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
       
            const SizedBox(
              height: 50,
            ),
            Form(
              key: _formkey,
              child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: TextFormField(
                    controller: _emalcontroller,
                    validator: (text){
                      if(text == null || text.isEmpty){
                        return 'enail is empty';
                      }
                      return null;
                    },
                     decoration:   InputDecoration(
                      prefixIcon: Icon(Icons.email),
                    hintText: 'Enter your Email',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                  ),
                  ),
                ),Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: TextFormField(
                    controller: _passwodcontroller,
                    validator: (text){
                      if(text == null || text.isEmpty){
                        return 'password is empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                    hintText: 'Enter your password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                  ),
                  ),
                )
              ],
            )),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextButton(
              onPressed: (){
              if(_formkey.currentState!.validate()){
                logIn(_emalcontroller.text.toString(), _passwodcontroller.text.toString()).then((user) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homescreen()));
                  if(user!=null){
                    print('login succesfull');
                  }
                  else{
                    print('failed');
                  }
                },);
                print('validation is done');            
              }
             }, child: const  Text('Login')),
           ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('do not have an account'),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Signupsceen()));
              }, child: const Text('Signup'))
            ],
           )
          ],
        ),
      ),

    );
  }
}