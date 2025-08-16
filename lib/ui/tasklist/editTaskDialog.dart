
import 'package:flutter/material.dart';
import 'package:jtask_flutter/domain/models/task.dart';
import 'package:jtask_flutter/ui/tasklist/taskList_viewModel.dart';
import 'package:jtask_flutter/ui/tasklist/task_details.dart';

class EditTaskDialog extends StatefulWidget {
  const EditTaskDialog({super.key, required this.viewModel, required this.initTask});

  final TaskListViewModel viewModel;

  final Task initTask;


  @override
  State<EditTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<EditTaskDialog> {

  @override
  Widget build(BuildContext context) {
    var taskDetails = TaskDetails.of(widget.viewModel, widget.initTask);
    return Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              taskDetails,
              Row(
                children: [
                  ElevatedButton(onPressed: (){
                    widget.viewModel.updateTask(taskDetails.getTask());
                  }, child: Text("Confirm")),
                  ElevatedButton(onPressed: (){
                    widget.viewModel.deleteTask(widget.initTask.id);
                    Navigator.pop(context);
                  }, child: Text("Delete")),
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
