import 'package:flutter/material.dart';
import 'package:mychat/testing.dart';
import 'welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'chat_screen.dart';
void main() async { WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  //options: DefaultFirebaseOptions.currentPlatform,
);
runApp(FlashChat());}
bool showSpninner=true;
class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
