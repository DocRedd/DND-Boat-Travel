import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  MyButton(
      {super.key,
        required this.text,
        required this.onPressed}
      );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),
          backgroundColor: Colors.blue,
          //foregroundColor: Colors.red,
          shape: StadiumBorder()),
    );
  }
}
