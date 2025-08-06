import 'dart:io';

import 'package:jtask_flutter/data/repositories/task_repository.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:uuid/uuid.dart';


class JTaskDatabase {
  JTaskDatabase(String path) {
    _sql = sqlite3.open(path);
    initTables();
    
    initRepos();//!note that this should be initialized last
  }
  
  late final Database _sql;
  final Uuid uuid = Uuid();
  
  late final ITaskRepository _tasks;
  ITaskRepository get tasks => _tasks;
  
  Future<void> initDB(String path) async {
    File f = File(path);//todo create file if doesnt exist
    if (!(await f.exists())){
      await f.create();
    }
    
    _sql = sqlite3.open(path);
  }
  
  void initTables(){
    //todo this should do a check to see if the database needs to be created (or updated, Ill probably need to write an upgrade script for each version)
    //todo this should not be using NOT EXISTS condition creation
    // todo this needs a developer mode that forces a reset and prepopulates some data
    _sql.execute('''
    CREATE TABLE IF NOT EXISTS Projects (
      id TEXT PRIMARY KEY,
      title TEXT
    );
    ''');
    
    _sql.execute('''
    CREATE TABLE IF NOT EXISTS Tasks (
      id TEXT PRIMARY KEY,
      projectId TEXT,
      title TEXT,
      dueDate TEXT,
      state INT,
      FOREIGN KEY(project_id) REFERENCES Tasks(id),
    );
    ''');
  }
  
  void initRepos() {
    _tasks = TaskRepository(db: this);
  }
  
  String getUUID(){
    return uuid.v4();
  }
  
  void execUpdate(String sql, [List<Object?> params = const []]) {
    _sql.prepare(sql)
      ..execute(params)
      ..dispose();
  }
  
  ResultSet execSelect(String sql, [List<Object?> params = const []]) {
    return _sql.select(sql,params);
  }
}
