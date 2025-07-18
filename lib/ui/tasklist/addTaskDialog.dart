import 'package:flutter/material.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  String title = "";

  DateTime dueDate = DateTime.now();

  void _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
    );
    if (picked != null && picked != dueDate){
      setState(() {
        dueDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            TextFormField(
              initialValue: title,
              decoration: InputDecoration(
                labelText: 'Title'
              ),
              onChanged: (val) => {
                title = val
              },
            ),
            Row(
              children: [
                Text("Due: "),
                TextButton(
                  onPressed: (){
                    _selectDueDate(context);
                  },
                  child: Text("$dueDate"),
                ),
              ],
            ),
            TextButton(
              onPressed: (){Navigator.pop(context);},
              child: Text("Cancel")
            ),
          ],
        )
      ),
    );
  }
}