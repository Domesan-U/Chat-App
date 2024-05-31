import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mychat/welcome_screen.dart';
import 'rounded_button.dart';
import 'Text_widget.dart';
import 'chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  String message = '';
  String email ='';
  String pass = '';
  bool showSpinner = false;

  @override


  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                      child: Image.asset('image/logo.png'), height: 240.0),
                ),
              ),
              Text('     $message',style: TextStyle(color: Colors.red,),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text_widget(hintText: 'Enter your email',onChanged: (value){email = value;}),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text_widget(hintText: 'Create your password',onChanged: (value){pass = value;},value: true),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30.0, horizontal: 8.0),
                child: rounded_button(
                  colour: Colors.lightBlueAccent,
                  title: 'Register',
                  onPressed: () async{
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      await _auth.createUserWithEmailAndPassword(
                          email: email, password: pass);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ChatScreen()));
                      setState(() {
                        showSpinner = false;
                      });
                    } on FirebaseAuthException catch(e){
                      setState(() {
                        if(e.code =="unknown") {message ="Please enter your proper credentials";}
                        else {
                          message = e.code;
                        }
                      });
                    }
                  setState(() {
                    showSpinner = false;
                  });

                  },
                ),
              ),
            ],
          ),
        ));
  }
}
