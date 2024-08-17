// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dndboats/data/database.dart';
import 'package:dndboats/util/dialog_box.dart';
import 'package:dndboats/util/slide_tile.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _mybox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {

    //if this is the 1st time ever opening the app the create default data
    if (_mybox.get("BOATSTATS") == null){
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }


  final _boatSpeed = TextEditingController();
  final _boatDistance = TextEditingController();
  final _boatHour = TextEditingController();


  void checkBoxChanges(bool? value, int index) {
    setState(() {
      db.boatStats[index][1] = !db.boatStats[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask(){
    setState(() {
      int lengthOfboatStats = db.boatStats.length;
      // For My dnd campaign one tile is 28 miles across
      double distanceOfTile = 28;
      // The user can set the speed of the boat
      double boatSpeed = double.parse(_boatSpeed.text);
      // simple math to determine how fast the boat travels per hour
      double travelPerHour = boatSpeed/24;
      // How many tiles the boat will be travelling to get to their destination
      double boatDistance = double.parse(_boatDistance.text);
      // Time it takes to cross a a tile at the boats speed
      double timeToCrossTile = boatDistance/travelPerHour;
      // StartTime held as a 24hr clock
      double boatHour = double.parse(_boatHour.text);
      // Initializing my variable here
      double arrivalTime;

      if(boatHour+timeToCrossTile>24){
          arrivalTime = (boatHour+timeToCrossTile)-24;
      } else {
        arrivalTime = (boatHour+timeToCrossTile);
      }

      db.boatStats.add([boatSpeed,boatDistance,boatHour, arrivalTime, false]);
      _boatSpeed.clear();
      _boatDistance.clear();
      _boatHour.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return DialogBox(
          boatSpeed: _boatSpeed,
          boatDistance: _boatDistance,
          boatHour: _boatHour,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(dialogContext).pop(),
        );
      },
    );
  }

  void deleteTask(int index){
    setState(() {
      db.boatStats.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text("Boat Travelling")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.blue,

        // ignore: prefer_const_constructors
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: db.boatStats.length,
          itemBuilder: (context, index) {
            return SlideTile(
              boatSpeed: db.boatStats[index][0].toString(),
              boatDistance:db.boatStats[index][1].toString(),
              boatHour:db.boatStats[index][2].toString(),
              arrivalTime: db.boatStats[index][3].toString(),
              taskCompleted: db.boatStats[index][4],
              onChanged: (value) => checkBoxChanges(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          }),
    );
  }
}
