import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mychat/about_page.dart';
import 'package:mychat/login_screen.dart';
import 'package:mychat/registration_screen.dart';
import 'rounded_button.dart';
import 'about_page.dart';
import 'patient.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red
  ];
  static const colorizeTextStyle =
      TextStyle(fontSize: 45.0, fontWeight: FontWeight.w900);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('image/logo.png'),
                      height: 60.0,
                    ),
                  ),
                  AnimatedTextKit(
                    pause: Duration(seconds: 2),
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'MyChat',
                        textStyle: colorizeTextStyle,
                        colors: colorizeColors,
                      ),
                      ColorizeAnimatedText(
                        'MyChat',
                        textStyle: colorizeTextStyle,
                        colors: colorizeColors,
                      ),
                    ],
                    // isRepeatingAnimation: true,
                    repeatForever: true,
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: rounded_button(
                  colour: Colors.lightBlueAccent,
                  title: 'Login',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => patientrecord()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: rounded_button(
                  colour: Colors.lightBlueAccent,
                  title: 'Register',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationScreen()));
                  },
                ),
              ),
              Material(
                elevation: 0.0,
                color: Colors.white,
                borderOnForeground: false,
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.help_outline_rounded),
                      Text('About'),
                    ],
                  ),
                    onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutPage()));}
                    //onPressed: (){},
                ),
              )
            ],
          )),
    );
  }
}
