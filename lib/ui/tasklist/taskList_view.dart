import 'package:flutter/material.dart';

import 'package:jtask_flutter/domain/models/task.dart';
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
        var tasks = TaskItem.from(viewModel.getTasks(), viewModel);
        return ListView(
          children: [
            Table(
              columnWidths: const <int, TableColumnWidth> {
                0: FixedColumnWidth(64),
                1: FlexColumnWidth(1),
                2: IntrinsicColumnWidth()
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: tasks,
            ),
          ]
        );
      }
    );
  }
}

class TaskItem extends TableRow {
  const TaskItem({super.key, super.decoration,required this.task, required this.viewModel});
  
  final Task task;
  final TaskListViewModel viewModel;

  @override
  List<Widget> get children => [
    Container(
      height:32, 
      color: task.state? Colors.green:Colors.red,
      child: IconButton(onPressed: (){viewModel.setDone(task.id, !task.state);}, icon: Icon(task.state ? Icons.check_circle_outline : Icons.circle_outlined )),
    ),
    TableCell(
      child: Text(task.title),
    ),
    TableCell(
      child: Text(task.dueDate.toString()),
    )
  ];

  static List<TaskItem> from(List<Task> tasks, TaskListViewModel viewModel) {
    return tasks.map((t)=> TaskItem(task:t, viewModel: viewModel)).toList();
  }
}