import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {

  List boatStats = [];

  // reference the box
  final _mybox = Hive.box('mybox');

  //run this method if this is the 1st time ever opening this app
  void createInitialData() {
    boatStats = [
      [1,1,1,1,false],
      [1.75,1,16,5.714,false]
    ];
  }
  //load the data from the database

  void loadData() {
    boatStats = _mybox.get("BOATSTATS");
  }

//update the database
  void updateDataBase() {
    _mybox.put("BOATSTATS", boatStats);
  }

}