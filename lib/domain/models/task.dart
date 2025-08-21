class Task {
  Task({
    this.id="NO_ID", 
    this.state = false,
    required this.title, 
    required this.dueDate,
    this.projectId
  });
  
  final String id;
  final bool state;
  final String title;
  final DateTime dueDate;
  final String? projectId;
}