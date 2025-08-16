
import 'package:flutter/material.dart';
import 'package:jtask_flutter/ui/tasklist/taskList_viewModel.dart';
import 'package:jtask_flutter/ui/tasklist/task_details.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key, required this.viewModel});
  
  final TaskListViewModel viewModel;


  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  
  @override
  Widget build(BuildContext context) {
    var taskDetails = TaskDetails.of(widget.viewModel);
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            taskDetails,
            Row(
              children: [
                ElevatedButton(onPressed: (){
                  widget.viewModel.addTask(taskDetails.getTask());
                }, child: Text("Add")),
                TextButton(
                    onPressed: (){Navigator.pop(context);},
                    child: Text("Cancel")
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}