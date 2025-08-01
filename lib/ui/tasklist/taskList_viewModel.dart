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
  bool _showCompleted = false;
  
  List<Task> getTasks() {
    return taskRepo.getTasks(_showCompleted);
  }

  void addTask(String title, DateTime dueDate) {
    taskRepo.addTask((title: title, dueDate: dueDate, state: false, id:-1));
    notifyListeners();
  }
  
  void setDone(int id, [bool state = true]) {
    taskRepo.setState(id, state);
    notifyListeners();
  }

  bool get showCompleted {
    return _showCompleted;
  }

  set showCompleted(val){
    _showCompleted = val;
    notifyListeners();
  }



}