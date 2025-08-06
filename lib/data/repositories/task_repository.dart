import "package:jtask_flutter/data/jtask_database.dart";
import "package:jtask_flutter/domain/models/task.dart";
import "package:sqlite3/common.dart";

abstract class ITaskRepository {
  /// adds a new task to the repo
  /// 
  /// note that the id is ignored and the return value contains a generated id
  Task addTask(Task task);
  
  void setState(String id, [bool state = true]);
  Task updateTask(String id, Task updated);
  List<Task> getTasks([bool showComplete = false]);
  Task? getTask(String id);
}

class TaskRepository implements ITaskRepository {
  
  TaskRepository({required this.db});
  
  final JTaskDatabase db;
  
  @override
  Task addTask(Task task) {
    var id = db.getUUID();
    return _addTask((id: id, title: task.title, dueDate: task.dueDate, state: task.state, projectId:task.projectId));
  }
  
  Task _addTask(Task task){
    db.execUpdate("INSERT INTO Tasks (id, title, dueDate, state) VALUES (?,?,?,?)",[task.id, task.title, task.dueDate.toIso8601String(), task.state]);
    return task;
  }

  @override
  Task? getTask(String id) {
    ResultSet rs = db.execSelect("SELECT * FROM Tasks WHERE id == ?", [id]);
    if (rs.isEmpty){
      return null;
    } else {
      return taskFromResultSet(rs)[0]; //if it returns more than one something is very broken
    }
  }

  @override
  List<Task> getTasks([bool showComplete = false]) {
    String sql = "SELECT * FROM Tasks${showComplete? ";" : " WHERE state == 0;"}";
    ResultSet rs = db.execSelect(sql);
    
    return taskFromResultSet(rs);
  }

  @override
  void setState(String id, [bool state = true]) {
    db.execUpdate("UPDATE Tasks SET state = ? WHERE id == ?", [state, id]);
  }

  @override
  Task updateTask(String id, Task updated) {
    // this isn't the best way to do this but the alternative is pretty involved
    assert(id == updated.id);
    db.execUpdate("DELETE FROM Tasks WHERE id == ?",[id]);
    return _addTask(updated);
  }
  
}

List<Task> taskFromResultSet(ResultSet rs){
  List<Task> tasks = [];
  for (Row r in rs){
    tasks.add((id:r['id'], title:r['title'], dueDate: DateTime.parse(r['dueDate']), state: r['state'] == 1, projectId: r['projectId']));
  }
  return tasks;
}