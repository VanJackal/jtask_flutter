import 'package:flutter/material.dart';
import 'package:jtask_flutter/data/repositories/project_repository.dart';
import 'package:jtask_flutter/domain/models/project.dart';

class ProjectsViewModel extends ChangeNotifier {
  ProjectsViewModel({required this.projectRepo});
  
  final IProjectRepository projectRepo;
  String _selected = "";



  String get selected => _selected;
  set selected(String projectId) {
    _selected = projectId;
    notifyListeners();
  }
  
  void addProject(Project project){
    projectRepo.addProject((title:project.title, id:"NONE"));
    notifyListeners();
  }
  
  List<Project> get projects {
    return projectRepo.getProjects();
  }
}