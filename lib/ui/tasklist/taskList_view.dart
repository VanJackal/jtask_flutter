import 'package:flutter/material.dart';

import 'package:jtask_flutter/domain/models/task.dart';
import 'package:jtask_flutter/ui/tasklist/editTaskDialog.dart';
import 'package:jtask_flutter/ui/tasklist/taskList_viewModel.dart';

/*
todo
This may need to be moved away from table to support subtasks 
 */

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.viewModel});

  final TaskListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context,_) {
        var tasks = TaskItem.from(viewModel.getTasks(), viewModel, context);
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Show Completed"),
                  Switch(value: viewModel.showCompleted, onChanged: (val){viewModel.showCompleted = val;})
                ],
              ),
            ),
            Expanded(
              child: ListView(
                  children: tasks
              ),
            ),
          ],
        );
      }
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task, required this.viewModel, required this.context});
  
  final Task task;
  final TaskListViewModel viewModel;
  final BuildContext context;

  static List<TaskItem> from(List<Task> tasks, TaskListViewModel viewModel, BuildContext context) {
    return tasks.map((t)=> TaskItem(task:t, viewModel: viewModel, context: context)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: (){viewModel.setDone(task.id, !task.state);},
          child: SizedBox(
              height:32,
              child:Icon(task.state ? Icons.check_circle_outline : Icons.circle_outlined )
          ),
        ),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(task.title),
            )
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(task.dueDate.toString()),
        ),
        GestureDetector(
          onTap: (){
            showDialog(context: context, builder: (BuildContext context) => Dialog(
                child: EditTaskDialog(initTask:task, viewModel: viewModel,)
            ));
          },
          child: Icon(Icons.edit),

        )

      ],
    );
  }
}