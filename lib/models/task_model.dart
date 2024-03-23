class Task {
  final int? id;
  final String creationDate;
  final String taskDescription;
  final int plannerId;
  int priority;
  int isDone;
  int totalWorkMinutes;

  Task({
    this.id,
    required this.creationDate,
    required this.taskDescription,
    required this.plannerId,
    this.priority = 0,
    this.isDone = 0,
    this.totalWorkMinutes = 0
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'creation_date': creationDate,
      'task_description': taskDescription,
      'planner_id': plannerId,
      'priority': priority,
      'is_done': isDone,
      'total_work_minutes': totalWorkMinutes
    };
  }
  @override
  String toString() {
    return
      'Task{id: $id,'
      ' creation_date: $creationDate,'
      ' task_description: $taskDescription,'
      ' planner_id: $plannerId,'
      ' priority: $priority,'
      ' is_done: $isDone,'
      ' total_work_done: $totalWorkMinutes}';
  }
}