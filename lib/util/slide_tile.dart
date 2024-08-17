import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlideTile extends StatelessWidget {
  final String boatSpeed;
  final String boatDistance;
  final String boatHour;
  final String arrivalTime;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  SlideTile(
      {super.key,
        required this.boatSpeed,
        required this.boatDistance,
        required this.boatHour,
        required this.arrivalTime,
        required this.taskCompleted,
        required this.onChanged,
        required this.deleteFunction,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.blue),
          child: Row(
            children: [
              //Checkbox
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              //Taskname
              Text("BoatSpeed: "),
              Text(
                boatSpeed + " | ",
                style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              Text("Distance: "),
              Text(
                boatDistance + " | ",
                style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              Text("StartTime: "),
              Text(
                boatHour + " | ",
                style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              Text("ArrivalTime: "),
              Text(
                arrivalTime + "  ",
                style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
