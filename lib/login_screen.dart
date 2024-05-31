import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mychat/rounded_button.dart';
import 'Text_widget.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email='';
  String pass='';
 String e_message='';
 bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
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
                  child: Image.asset('image/logo.png'),
                  height: 200,
                  width: 100,
                ),
              ),
            ),
            Container(child: Text('     $e_message',style: TextStyle(color: Colors.red),)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text_widget(hintText: 'Enter your mail',onChanged: (value){email = value;},),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
                child: Text_widget(hintText: 'Enter your password',onChanged: (value){pass = value;},value: true,)
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: rounded_button(colour: Colors.lightBlueAccent,title: 'Login' ,
                onPressed: ()async{

                try {
                  setState(() {
                    showSpinner = true;
                    e_message ='';
                  });
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: pass);
                  showSpinner= false;
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatScreen()));

    print("above here");
                  }

                  on FirebaseAuthException catch(e){
                  print('inside cattch');

                  setState(() {
                    showSpinner = false;

                    print(e.code);
                    e_message = e.code.toString();
                    });
                   }
                   setState((){showSpinner = false;});
               }

            ),

        ),
    ]
        ),
      )
    );
  }
}
