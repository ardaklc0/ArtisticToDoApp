class Task {
  final int? id;
  final String creationDate;
  final String taskDescription;
  final int plannerId;

  const Task({
    this.id,
    required this.creationDate,
    required this.taskDescription,
    required this.plannerId
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'creation_date': creationDate,
      'task_description': taskDescription,
      'planner_id': plannerId
    };
  }
  @override
  String toString() {
    return 'Task{id: $id, creation_date: $creationDate, task_description: $taskDescription, planner_id: $plannerId}';
  }
}