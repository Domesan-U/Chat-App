import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mychat/login_screen.dart';
import 'package:mychat/welcome_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String messageText = '';
  User? loggedInUser;
  bool showSpiner = false;
  final messageTextController = TextEditingController();
  static var user = null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   messageStream();
   getuser();
  }

  void getuser() async {
    try {
      //messageStream();
      user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print("successfull");
        print(user.email);
      } else {
        print("cannot find");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      }
    } catch (e) {
      print(e);
    }
  }
  void messageStream() async {
    print("we got ancestor");
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docChanges) {
       print("Wegot ${message.doc.data()}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                   _auth.signOut();
                   Navigator.push(context,MaterialPageRoute(builder: (context)=>WelcomeScreen()));
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpiner,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              StreamBuilderCreater(),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 8.0),
                        child: TextField(
                          controller: messageTextController,
                          decoration:
                              InputDecoration(hintText: 'Text your message here'),
                          onChanged: (value) {
                            messageText = value;
                          },
                          //decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        messageTextController.clear();
                        _firestore
                            .collection('messages')
                            .add({'text': messageText, 'sender': user.email,'time': DateTime.now()});
                        //Implement send functionality.
                        print(user.email + "sended: $messageText");
                      },
                      child: Text(
                        'Send',
                        // style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.finalsender, required this.finalmessage,required this.isMe,required this.time});
  final  finalmessage;
  final finalsender;
  final time;
  final isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: isMe?CrossAxisAlignment.start: CrossAxisAlignment.end,
        children: [
          Text(finalsender,
              style: TextStyle(color: Colors.black38, fontSize: 12.0)),
          Material(
            elevation: 5.0,
            color: isMe? Colors.white: Colors.lightBlueAccent,
            borderRadius: isMe?BorderRadius.only(
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0) ): BorderRadius.only(
            topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$finalmessage',
                style: TextStyle(fontSize: 15.0, color: isMe? Colors.black54: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(time.toString().substring(11,19),
              style: TextStyle(color: Colors.black38, fontSize: 8.0)),
          ),
        ],
      ),
    );
  }
}

class StreamBuilderCreater extends StatefulWidget {
  const StreamBuilderCreater({Key? key}) : super(key: key);

  @override
  State<StreamBuilderCreater> createState() => _StreamBuilderCreaterState();
}

class _StreamBuilderCreaterState extends State<StreamBuilderCreater> {
  List<MessageBubble> messageWidget = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore.collection("messages").orderBy("time",descending: true).snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            final messages = snapshots.data?.docChanges.reversed;
            for (var message in messages!) {
              final messageText = message.doc.data();
              final finalmessage = messageText!['text'];
              final finalsender = messageText!['sender'];
              messageWidget.add(MessageBubble(
                  finalsender: finalsender, finalmessage: finalmessage,isMe: _auth.currentUser?.email==finalsender,time: messageText['time'].toDate()));
            }
          }
          print('messages $messageWidget');
          //return Expanded(child: ListView(children: messageWidget,reverse: false,));
          return Expanded(child: ListView.builder(itemCount:1,itemBuilder: (context,index){return messageWidget as Widget;},reverse: false,));

        });
  }
}

