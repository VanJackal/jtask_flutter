import 'package:flutter/material.dart';
import 'package:jtask_flutter/domain/models/task.dart';

class TaskListViewModel extends ChangeNotifier{
  TaskListViewModel(){
    addTask("task 1", DateTime.now());
    addTask("task 2", DateTime.now());
    addTask("task 3", DateTime.now());
  }
  
  final Map<int ,Task> _tasks = <int, Task>{}; //todo this needs to be a repository
  int id = 0;
  
  List<Task> getTasks() {
    return _tasks.values.toList();
  }

  void addTask(String title, DateTime dueDate) {
    var id = this.id++;
    _tasks[id] = (title: title, dueDate: dueDate, state: false, id:id);
    notifyListeners();
  }
}