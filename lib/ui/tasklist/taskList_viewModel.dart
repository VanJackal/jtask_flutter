import 'package:flutter/material.dart';
import 'package:jtask_flutter/data/repositories/task_repository.dart';
import 'package:jtask_flutter/domain/models/task.dart';

class TaskListViewModel extends ChangeNotifier{
  TaskListViewModel(this.taskRepo){
    addTask("task 1", DateTime.now());
    addTask("task 2", DateTime.now());
    addTask("task 3", DateTime.now());
  }
  
  final ITaskRepository taskRepo;
  
  List<Task> getTasks() {
    return taskRepo.getTasks();
  }

  void addTask(String title, DateTime dueDate) {
    taskRepo.addTask((title: title, dueDate: dueDate, state: false, id:"EMPTY"));
    notifyListeners();
  }
  
  void setDone(String id, [bool state = true]) {
    taskRepo.setState(id, state);
    notifyListeners();
  }
}