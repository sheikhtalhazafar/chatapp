import 'package:chatapp/screens/auth_screens/loginscree.dart';
import 'package:chatapp/screens/auth_screens/methods/auh_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signupsceen extends StatefulWidget {
  const Signupsceen({super.key});

  @override
  State<Signupsceen> createState() => _SignupsceenState();
}

class _SignupsceenState extends State<Signupsceen> {
final _formkey = GlobalKey<FormState>();
final TextEditingController _emailcontroller = TextEditingController();
final TextEditingController _passwordcontroller = TextEditingController();
final TextEditingController _namecntroller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
   
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple.shade200,
        automaticallyImplyLeading: false,
        title: Text('Signup'),
      ),
      body: SingleChildScrollView(
        child: Column(
         
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        
           const SizedBox(
              height: 100,
            ),
          
          Form(
                key: _formkey,
                child: Column(
                children: [
                      Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: TextFormField(
                      controller: _namecntroller,
                      validator: (text){
                        if(text == null || text.isEmpty){
                          return 'enter your name';
                        }
                        return null;
                      },
                       decoration: InputDecoration(
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(35),
                    child: TextFormField(
                      controller: _emailcontroller,
                      validator: (text){
                        if(text == null || text.isEmpty){
                          return 'email is empty';
                        }
                        return null;
                      },
                       decoration:  InputDecoration(
                      hintText: 'Enter your Email',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                    ),
                    ),
                  ),Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: TextFormField(
                      controller: _passwordcontroller,
                      validator: (text){
                        if(text == null || text.isEmpty){
                          return 'password is empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                    ),
                    ),
                  )
                ],
              )),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextButton(onPressed: (){
              if(_formkey.currentState!.validate()){
                createaccount(_namecntroller.text.toString(), _emailcontroller.text.toString(), _passwordcontroller.text.toString()).then((user){
                  if(user!=null){
                    print('account create succesfully');
                  }else{
                    print('account create failed');
                  }
                });
               
              }
             }, child: const Text('signup')),
           ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const Text('already have an account'),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
              }, child: const Text('Login'))
            ],
           )
          ],
        ),
      ),

    );
  }
}