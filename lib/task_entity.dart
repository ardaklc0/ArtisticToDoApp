class Task {
  final int? id;
  final String creationDate;
  final String taskDescription;

  const Task({
    this.id,
    required this.creationDate,
    required this.taskDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'creation_date': creationDate,
      'task_description': taskDescription,
    };
  }
  @override
  String toString() {
    return 'Task{id: $id, creation_date: $creationDate, task_description: $taskDescription}';
  }
}