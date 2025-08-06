import 'package:flutter/material.dart';
import 'package:jtask_flutter/domain/models/project.dart';

class ProjectsViewModel extends ChangeNotifier {
  String _selected = "";


  String get selected => _selected;
  set selected(String projectId) {
    _selected = projectId;
    notifyListeners();
  }
  
  List<Project> get projects {
    return [
      (id:"none1", title: "project1"),
      (id:"none2", title: "project2"),
      (id:"none3", title: "project3"),
      (id:"none4", title: "project4"),
    ];
  }
}