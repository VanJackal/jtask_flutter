import "package:jtask_flutter/domain/models/task.dart";

abstract class ITaskRepository {
  /// adds a new task to the repo
  /// 
  /// note that the id is ignored and the return value contains a generated id
  Task addTask(Task task);
  
  void setState(int id, [bool state = true]);
  Task updateTask(int id, Task updated);
  List<Task> getTasks();
  Task getTask(int id);
}

class TaskRepositoryStub implements ITaskRepository{//todo this should call on sqlite and will require a full rewrite
  final Map<int ,Task> _tasks = <int, Task>{};
  int id = 0;

  @override
  Task addTask(Task task) {
    int id = this.id++;
    Task t = (id:id, title: task.title, state: task.state, dueDate: task.dueDate);
    _tasks[id] = t;
    return t;
  }

  @override
  void setState(int id, [bool state = true]) {
    Task t = getTask(id);
    updateTask(id, (id:id, title: t.title, dueDate: t.dueDate, state: state));
  }

  @override
  Task updateTask(int id, Task updated) {
    _tasks[id] = updated;
    return updated;
  }

  @override
  Task getTask(int id) {
    Task? t = _tasks[id];
    if (t == null) throw Exception("Invalid id");
    return t;
  }

  @override
  List<Task> getTasks() {
    return _tasks.values.toList();
  } 
}