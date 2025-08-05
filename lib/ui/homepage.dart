import 'package:flutter/material.dart';
import 'package:jtask_flutter/data/repositories/task_repository.dart';
import 'package:jtask_flutter/ui/tasklist/addTaskDialog.dart';
import 'package:jtask_flutter/ui/tasklist/taskList_view.dart';
import 'package:jtask_flutter/ui/tasklist/taskList_viewModel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var taskListViewModel = TaskListViewModel(context.read<ITaskRepository>());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          Placeholder(),
          Expanded(child: TaskList(viewModel: taskListViewModel,)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: ()=>{
            showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                child: AddTaskDialog(viewModel: taskListViewModel,)
              )
            )
          },
          child: const Icon(Icons.add),
      ),
    );
  }
}
