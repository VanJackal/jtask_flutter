import "package:jtask_flutter/domain/models/task.dart";

abstract class ITaskRepository {
  /// adds a new task to the repo
  /// 
  /// note that the id is ignored and the return value contains a generated id
  Task addTask(Task task);
  
  void setState(String id, [bool state = true]);
  Task updateTask(String id, Task updated);
  List<Task> getTasks([bool showComplete = false]);
  Task getTask(String id);
}

class TaskRepository implements ITaskRepository {
  
  TaskRepository({required this.db});
  
  final JTaskDatabase db;
  
  @override
  Task addTask(Task task) {
    var stmt = db.sql.prepare("INSERT INTO Tasks (id, title, dueDate, state) VALUES (?,?,?,?)");
    var id = db.getUUID();
    stmt.execute([id, task.title, task.dueDate.toIso8601String(), task.state]);
    Task t = (id: id, title: task.title, dueDate: task.dueDate, state: task.state);//todo should use database result
    return t;
  }

  @override
  Task getTask(String id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  List<Task> getTasks([bool showComplete = false]) {
    // TODO: implement getTasks
    return [];
  }

  @override
  void setState(String id, [bool state = true]) {
    // TODO: implement setState
  }

  @override
  Task updateTask(String id, Task updated) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
  
}