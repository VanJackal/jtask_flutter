import 'package:jtask_flutter/data/jtask_database.dart';
import 'package:jtask_flutter/domain/models/project.dart';
import 'package:sqlite3/sqlite3.dart';

abstract class IProjectRepository {
  /// Add a new project
  Project addProject(Project project);
  /// Get all projects
  List<Project> getProjects();
  void updateProject(String id, Project updated);
  void deleteProject(String id);
}

class ProjectRepository implements IProjectRepository{
  ProjectRepository({required this.db});
  final JTaskDatabase db;
  
  @override
  Project addProject(Project project) {
    var id = db.getUUID();
    return _addProject((id:id, title: project.title));
  }
  
  Project _addProject(Project project){
    db.execUpdate("INSERT INTO Projects (id, title) VALUES (?,?);", [project.id, project.title]);
    return project;
  }

  @override
  List<Project> getProjects() {
    var rs = db.execSelect("SELECT * FROM Projects;");
    return projectFromResultSet(rs);
  }

  @override
  void deleteProject(String id) {
    db.execUpdate("DELETE FROM Projects WHERE id == ?", [id]);
  }

  @override
  void updateProject(String id, Project updated) {
    assert( id == updated.id);
    db.execUpdate("DELETE FROM Projects WHERE id == ?", [id]);
    _addProject(updated);
  }
  
}

List<Project> projectFromResultSet(ResultSet rs){
  List<Project> projects = [];
  for (Row r in rs) {
    projects.add((id:r['id'], title:r['title']));
  }
  return projects;
}