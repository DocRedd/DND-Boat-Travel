// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dndboats/data/database.dart';
import 'package:dndboats/util/dialog_box.dart';
import 'package:dndboats/util/todo_tile.dart';


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

    //if this is the 1st time ever opening the app the create defaul data
    if (_mybox.get("TODOLIST") == null){
      db.createInitialData();
    } else {
      // there already exosts data
      db.loadData();
    }

    super.initState();
  }


  final _controller = TextEditingController();



  void checkBoxChanges(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(dialogContext).pop(),
        );
      },
    );
  }

  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Center(child: Text("To Do")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.yellow,

        // ignore: prefer_const_constructors
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanges(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          }),
    );
  }
}
