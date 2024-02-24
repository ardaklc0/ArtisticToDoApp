import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro2/models/task_model.dart';
import 'package:pomodoro2/ui/widgets/task_row.dart';
import 'package:pomodoro2/services/task_service.dart';
import '../helper/common_variables.dart';
import '../helper/task_function.dart';
import '../styles/common_styles.dart';
import 'common_widgets.dart';
class TaskContainer extends StatefulWidget {
  final Color dateColor;
  final Color? taskColor;
  final Color? textColor;
  final String dayText;
  final String dateText;
  final List<Task>? tasks;
  final int plannerId;
  const TaskContainer({super.key, required this.dateColor, required this.taskColor, required this.textColor, required this.dayText, required this.dateText, this.tasks, required this.plannerId});
  @override
  State<TaskContainer> createState() => _TaskContainerState();
}
class _TaskContainerState extends State<TaskContainer> {
  List<Widget> textFields = [];
  @override
  void initState() {
    super.initState();
    initializeTasks(widget.tasks, textFields, widget.dateText, widget.textColor, widget.dateColor, widget.plannerId);
  }
  Future<void> addTask() async {
    Task? newTask = Task(
      taskDescription: "New Task",
      creationDate: widget.dateText,
      plannerId: widget.plannerId,
    );
    int taskId = await insertTask(newTask);
    newTask = await getTask(taskId);
    setState(() {
      textFields.add(TaskRow(
        textColor: widget.textColor,
        checkboxColor: widget.dateColor,
        text: newTask?.taskDescription,
        dateText: newTask?.creationDate,
        task: newTask,
        plannerId: widget.plannerId,
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Column(
        children: [
          SizedBox(
            height: deviceHeight * heightProportionOfDateContainer,
            width: deviceWidth * 0.95,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: widget.dateColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  partOfTaskContainer(deviceWidth, widthOfDayInDateContainer, widget.dayText, widget.textColor),
                  Container(
                    width: deviceWidth * 0.33,
                    child: const SizedBox(),
                  ),
                  partOfTaskContainer(deviceWidth, widthOfDateInDateContainer, widget.dateText, widget.textColor),
                ],
              )
            ),
          ), //DateContainer
          SizedBox(
            height: deviceHeight * heightProportionOfTaskContainer,
            width: deviceWidth * 0.95,
            child: DecoratedBox(
            decoration: BoxDecoration(
              color: widget.taskColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Padding(
                padding: fixedEdgeInsets,
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      Column(
                        children: textFields
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          onPressed: addTask,
                          style: raisedButtonStyle(widget.textColor, widget.dateColor, deviceHeight, deviceWidth),
                          child: Text(
                            "Create A Task",
                            style: buttonTextStyle(deviceWidth)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ), //TaskContainer
      ],
    ),
  );
}
}

