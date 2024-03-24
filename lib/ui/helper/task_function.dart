import 'package:flutter/cupertino.dart';
import '../../models/task_model.dart';
import '../widgets/task_row.dart';


List<Widget> initializeTasks(List<Task>? taskList, List<Widget> taskRowList, String dateText, Color? textColor, Color dateColor, int plannerId) {
  if (taskList != null) {
    taskRowList.addAll(taskList.where((element) => dateText == element.creationDate).map((element) {
      return TaskRow(
        textColor: textColor,
        checkboxColor: dateColor,
        text: element.taskDescription,
        dateText: element.creationDate,
        task: element,
        plannerId: plannerId,
        priority: element.priority,
      );
    }));
  }
  return taskRowList;
}