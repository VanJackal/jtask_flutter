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
                children: [
                  Table(
                    columnWidths: const <int, TableColumnWidth> {
                      0: FixedColumnWidth(64),
                      1: FlexColumnWidth(1),
                      2: IntrinsicColumnWidth(),
                      3: IntrinsicColumnWidth()
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: tasks,
                  ),
                ]
              ),
            ),
          ],
        );
      }
    );
  }
}

class TaskItem extends TableRow {
  const TaskItem({super.key, super.decoration,required this.task, required this.viewModel, required this.context});
  
  final Task task;
  final TaskListViewModel viewModel;
  final BuildContext context;

  @override
  List<Widget> get children => [
    GestureDetector(
      onTap: (){viewModel.setDone(task.id, !task.state);},
      child: Container(
        height:32, 
        color: task.state? Colors.green:Colors.red,
        child:Icon(task.state ? Icons.check_circle_outline : Icons.circle_outlined )
      ),
    ),
    TableCell(
      child: Text(task.title),
    ),
    TableCell(
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
  ];

  static List<TaskItem> from(List<Task> tasks, TaskListViewModel viewModel, BuildContext context) {
    return tasks.map((t)=> TaskItem(task:t, viewModel: viewModel, context: context)).toList();
  }
}