import 'package:flutter/material.dart';
import 'package:jtask_flutter/domain/models/task.dart';

class TaskListViewModel extends ChangeNotifier{
  TaskListViewModel(){
    addTask("task 1", DateTime.now());
    addTask("task 2", DateTime.now());
    addTask("task 3", DateTime.now());
  }
  
  List<Task> _tasks = []; //todo this needs to be a repository

  List<Task> get tasks => _tasks;
  int id = 0;
  
  

  void addTask(String title, DateTime dueDate) {
    _tasks.add((title: title, dueDate: dueDate, state: false, id:id++));
    notifyListeners();
  }
}