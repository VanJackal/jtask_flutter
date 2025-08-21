
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:jtask_flutter/domain/models/task.dart';
import 'package:jtask_flutter/ui/tasklist/taskList_viewModel.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails ({super.key, required this.taskState, required this.viewModel});
  final TaskState taskState;
  final TaskListViewModel viewModel;
  
  static TaskDetails of(TaskListViewModel viewModel,[Task? init] ){
    return TaskDetails(taskState: TaskState(init), viewModel: viewModel,);
  }
  
  void _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
    );
    if (picked != null && picked != taskState.dueDate){
        taskState.dueDate = picked;
    }
  }
  
  Task getTask() {
    return taskState.toTask();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: taskState.title,
          decoration: InputDecoration(
              labelText: 'Title'
          ),
          onChanged: (val) => {
            taskState.title = val
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownMenu<String>(
              enableFilter: true,
              label: const Text("Project"),
              initialSelection: taskState.projectId,
              onSelected: (String? id){
                taskState.projectId = id!;
              },
              dropdownMenuEntries: UnmodifiableListView(
                  viewModel.projects.map((p){
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
              child: Text("${taskState.dueDate}"),
            ),
          ],
        ),
      ],
    );
  }}

class TaskState {
  TaskState(Task? init) {
    title = init?.title ?? "";
    projectId = init?.projectId ?? "";
    dueDate = init?.dueDate ?? DateTime.now();
    id = init?.id ?? "";
    state = init?.state ?? false;
  }
  
  late String title;
  late String projectId;
  late DateTime dueDate;
  late String id;
  late bool state;
  
  Task toTask(){
    return Task(title: title, projectId: projectId, dueDate: dueDate, id:id, state:state);
  }
  
}