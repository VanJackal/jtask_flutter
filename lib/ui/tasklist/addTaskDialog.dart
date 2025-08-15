import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:jtask_flutter/domain/models/task.dart';
import 'package:jtask_flutter/ui/tasklist/taskList_viewModel.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key, required this.viewModel, required this.submitText, required this.onSubmit});
  
  final TaskListViewModel viewModel;
  final Function(Task) onSubmit;

  final String submitText;

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  String title = "";
  String projectId = "";

  DateTime dueDate = DateTime.now();

  void _addTaskButton() {
    widget.onSubmit((title: title, projectId: projectId, dueDate: dueDate, id: "", state: false));
  }
  
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownMenu<String>(
                enableFilter: true,
                label: const Text("Project"),
                onSelected: (String? id){
                  setState(() {
                      projectId = id!;
                  });
                },
                dropdownMenuEntries: UnmodifiableListView(
                  widget.viewModel.projects.map((p){
                    return DropdownMenuEntry(
                      value: p.id,
                      label: p.title
                    );
                  })
                )
              ),
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
            Row(
              children: [
                ElevatedButton(onPressed: _addTaskButton, child: Text(widget.submitText)),
                TextButton(
                  onPressed: (){Navigator.pop(context);},
                  child: Text("Cancel")
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}