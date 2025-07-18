import 'package:flutter/material.dart';

import 'package:jtask_flutter/domain/models/task.dart';

/*
todo
This may need to be moved away from table to support subtasks 
 */

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const <int, TableColumnWidth> {
        0: FixedColumnWidth(64),
        1: FlexColumnWidth(1),
        2: IntrinsicColumnWidth()
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TaskItem(task: (title: "Task 1", dueDate: DateTime(2025,1, 25), state: true)),//todo this should be stored in a var
        TaskItem(task: (title: "Task 2", dueDate: DateTime(2025,6, 2), state: true)),
      ],
    );
  }
}

class TaskItem extends TableRow {
  const TaskItem({super.key, super.decoration,required this.task});
  
  final Task task;

  @override
  List<Widget> get children => [
    Container(height:32, color:Colors.green,),
    TableCell(
      child: Text(task.title),
    ),
    TableCell(
      child: Text(task.dueDate.toString()),
    )
  ];
}