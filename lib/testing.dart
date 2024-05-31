import 'package:flutter/material.dart';
class tester extends StatefulWidget {
  const tester({Key? key}) : super(key: key);
  static int i=0;

  @override
  State<tester> createState() => _testerState();
}
Text loop(){
  return Text(
    "count"
  );
}
class _testerState extends State<tester> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Count ${tester.i}"),
          MaterialButton(child:Text("Increase in parent"),color: Colors.blueAccent,onPressed: (){setState(() {
           tester.i++;
          });}),
          increser(onTap: (){setState(() {
            tester.i++;
            print("calling");
            increser.caller();
          });}),
        ],
        ),
    );
  }
}
class increser extends StatefulWidget {
  static void caller(){
    ticker++;
    print("Increased Ticker $ticker");
  }
  Function() onTap;
  static int ticker =0;
  increser({required this.onTap});
  @override
  State<increser> createState() => _increserState();
}

class _increserState extends State<increser> {
  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.blueAccent,child: MaterialButton(onPressed:(){widget.onTap();print("pressed");},color: Colors.blueAccent,child: Text("Presse me"),));
  }
}

