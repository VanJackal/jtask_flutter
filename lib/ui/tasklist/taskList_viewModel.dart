import 'package:flutter/material.dart';
import 'package:jtask_flutter/data/repositories/task_repository.dart';
import 'package:jtask_flutter/domain/models/task.dart';

class TaskListViewModel extends ChangeNotifier{
  TaskListViewModel(this.taskRepo);
  
  final ITaskRepository taskRepo;
  bool _showCompleted = false;
  String _projectId = "";
  
  List<Task> getTasks() {
    return taskRepo.getTasks(_showCompleted);
  }

  void addTask(String title, DateTime dueDate, String project) {
    taskRepo.addTask((title: title, dueDate: dueDate, state: false, id:"EMPTY", projectId:project));
    notifyListeners();
  }
  
  void setDone(String id, [bool state = true]) {
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
  
  set projectId(String id) {
    _projectId = id;
    notifyListeners();
  }



}