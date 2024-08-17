import 'package:flutter/material.dart';
import 'package:dndboats/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final boatSpeed;
  final boatDistance;
  final boatHour;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({super.key,
    required this.boatSpeed,
    required this.boatDistance,
    required this.boatHour,
    required this.onSave,
    required this.onCancel});




  @override
  Widget build(BuildContext context) {
    var windowHeight = MediaQuery.of(context).size.height*0.10;
    var windowWidth = MediaQuery.of(context).size.width*0.10;
    return AlertDialog(
      backgroundColor: Colors.blue[300],
      content: Container(
        height: MediaQuery.of(context).size.height*0.30,
        width: MediaQuery.of(context).size.width*0.10,
        child: Column(
          children: [
          TextField(
            controller: boatSpeed,
            decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Boat Speed (1 Tile per Day)"),
          ),
          TextField(
            controller: boatDistance,
            decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Distance to travel (1 tile)"),
          ),
          TextField(
            controller: boatHour,
            decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Start Time (24hrclock int)"),
          ),
          const SizedBox(),
          const SizedBox(width: 10, height: 10,),
          Row(
            children: [
              // SizedBox(width: MediaQuery.of(context).size.height*0.1, height: MediaQuery.of(context).size.height*0.10,),
              SizedBox(width: windowWidth/20, height: 2,),
              MyButton(text: "Save", onPressed: onSave),
              const SizedBox(width: 5, height: 2,),
              MyButton(text: "Cancel", onPressed: onCancel)
            ],
          )
        ],),
      ),
    );
  }
}
