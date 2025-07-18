import 'package:flutter/material.dart';
import 'package:jtask_flutter/domain/models/task.dart';

class TaskListViewModel extends ChangeNotifier{
  List<Task> _tasks = [
    (title: "Task 1", dueDate: DateTime(2025,1,25), state: true),
    (title: "Task 2", dueDate: DateTime(2025,1,25), state: true),
    (title: "Task 3", dueDate: DateTime(2025,1,25), state: false),
  ]; //todo this needs to be a repository

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }
}