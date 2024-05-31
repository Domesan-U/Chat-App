import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// class patient extends StatelessWidget {
//   String? prescription;
//   static int count =0;
//   DocumentSnapshot? data1;
//   String? p_name;
//   final controller1 = TextEditingController();
//   final controller2 = TextEditingController();
//   final _firestore = FirebaseFirestore.instance;
//   @override
//
//   void messageStream() async {
//     print("we got ancestorda");
//     await for (var snapshot in _firestore.collection("patients").snapshots()) {
//       for (var message in snapshot.docChanges) {
//         count= message.doc.data()?["id"];
//         print(count);
//       }
//     }
//   }
//
//
//   Widget build(BuildContext context) {
//
//     return
//       StatefulWrapper(
//         onInit: (){
//             print("Init");
//             messageStream();
//             print("Count ${count}");
//         },
//         child: Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Column(
//               children: [
//                 Text(
//                   "Enter Patient name",
//                 ),
//                 TextField(
//                   controller: controller1,
//                   decoration: InputDecoration(hintText: "New Patient"),
//                   onChanged: (value){
//                     p_name = value;
//                   },
//                 ),
//                 Text(
//                   "Prescription",
//                 ),
//                 TextField(
//                   controller: controller2,
//                   decoration: InputDecoration(hintText: "Enter Prescription Here"),
//                   onChanged: (value)
//                   {
//                     prescription = value;
//                   },
//                 ),
//                 MaterialButton(
//                   child: Text("Add"),
//                   color: Colors.blueAccent,
//                     onPressed: () {
//                            _firestore.collection("patients").add({"patient name": p_name,"prescription": prescription,"id":count+1});
//                     },
//                 ),
//   ],),
//
//             Column(
//               children: [
//                 Text(
//                   "Get Patient Record",
//                 ),
//                 TextField(
//                   controller: controller1,
//                   decoration: InputDecoration(hintText: "Old Patient Name/id"),
//                 ),
//                 MaterialButton(
//                   child: Text("Get"),
//                 color: Colors.blueAccent,
//                 onPressed: ()async
//                 {
//                   print("Entere");
//                   await for (var snapshot in _firestore.collection("patients").orderBy('id').snapshots()) {
//                     for (var message in snapshot.docChanges) {
//                         count = message.doc.data()?['id'];
//                     }
//                     print(count);
//                   }print("Exite");
//                 }
//                 )
//               ],
//             ),
//
//
//           ],
//         ),
//     ),
//       );
//   }
// }
class patientrecord extends StatefulWidget {

  @override
  State<patientrecord> createState() => _patientrecordState();
}

class _patientrecordState extends State<patientrecord> {

  Map? found;
  String? prescription;
  static int count=0;
  String search ="" ;
  DocumentSnapshot? data1;
  String? p_name;
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  void changer(Map foundy)
  {
    setState(() {
      found = foundy;
    });
  }

  void messageStream() async {

    print("we got ancestorda");
    await for (var snapshot in _firestore.collection("patients").orderBy("id").snapshots()) {
      for (var message in snapshot.docChanges) {
        print("her?");
        found = message.doc.data();
        count=int.parse(message.doc.data()?["id"]);
        print("re first loop $count");
      }
      setState(() {
        count;
        found;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messageStream();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                "Enter Patient name",
              ),
              TextField(
                controller: controller1,
                decoration: InputDecoration(hintText: "New Patient"),
                onChanged: (value){
                  p_name = value;
                },
              ),
              Text(
                "Prescription",
              ),
              TextField(
                controller: controller2,
                decoration: InputDecoration(hintText: "Enter Prescription Here"),
                onChanged: (value)
                {
                  prescription = value;
                },
              ),
              Container(
                child: Text(

                 " Assigned Id: ${(count+1).toString()}"
                )
              ),
              MaterialButton(
                child: Text("Add"),
                color: Colors.blueAccent,
                onPressed: () {
                  //messageStream();
                  print("Count $count");
                  controller1.clear();
                  controller2.clear();
                 _firestore.collection("patients").add({"patient name": p_name,"prescription": prescription,"id":(count+1).toString()});
                },
              ),
            ],),

          Column(
            children: [
              Text(
                "Get Patient Record",
              ),
              TextField(
                onChanged: (value)
                {
                  search = value;
                },
                controller: controller3,
                decoration: InputDecoration(hintText: "Old Patient Name/id"),
              ),
              MaterialButton(
                  child: Text("Get"),
                  color: Colors.blueAccent,
                  onPressed: ()async
                  {
                    controller3.clear();
                    print("Entere");
                    await for (var snapshot in _firestore.collection("patients").orderBy('id').snapshots()) {
                      for (var message in snapshot.docChanges) {
                        print("search $search");
                        print("Fetching each messages - ${message.doc.data()?['id']}");
                        print("Fetchinggi each messages - ${message.doc.data()?['patient name']}");
                        print("Checking ${search == message.doc.data()?['id']}");
                        if((search == message.doc.data()?['id'])|| search == message.doc.data()?["patient name"])
                          {
                            found = message.doc.data();
                            changer(found!);
                            print("noobs here ${found?['patient name']}");
                            print("Name-${message.doc.data()?['patient name']} \nPrescription - ${message.doc.data()?['prescription']}");
                            break;
                          }

                      }
                      print("Here Second Loop $count");
                    }print("Exite");
                  }
              ),
              Container(
                child:Text(
                  "Name:  ${found?['patient name']}\n Prescription : ${found?['prescription']}"
                ),
              )
            ],
          ),


        ],
      ),
    );
  }
}


