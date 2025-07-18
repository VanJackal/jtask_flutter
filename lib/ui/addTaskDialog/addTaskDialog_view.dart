import 'package:flutter/material.dart';

class AddTaskDialog extends StatelessWidget {
  const AddTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
    child: Center(
      child: TextButton(
        onPressed: (){Navigator.pop(context);},
        child: Text("Close")
      ),
    ),
    );
  }

}