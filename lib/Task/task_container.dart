import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro2/Task/task_entity.dart';
import 'package:pomodoro2/Task/task_row.dart';
import 'package:pomodoro2/Task/task_service.dart';
import '../common_variables.dart';

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
    initializeTasks();
  }

  void initializeTasks() {
    if (widget.tasks != null) {
      textFields.addAll(widget.tasks!.where((element) => widget.dateText == element.creationDate).map((element) {
        return TaskRow(
          textColor: widget.textColor,
          checkboxColor: widget.dateColor,
          text: element.taskDescription,
          dateText: element.creationDate,
          task: element,
          plannerId: widget.plannerId,
        );
      }));
    }
  }

  void addTask() {
    setState(() {
      textFields.add(TaskRow(
        textColor: widget.textColor,
        checkboxColor: widget.dateColor,
        dateText: widget.dateText,
        plannerId: widget.plannerId,
      ));
    });
  }


  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: widget.textColor,
      backgroundColor: widget.dateColor,
      fixedSize: Size(deviceWidth * 0.5, deviceHeight * 0.05),
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(deviceWidth * 0.05)),
      ),
    );

    return Column(
      children: [

        SizedBox(
          height: MediaQuery.of(context).size.height * Variables.heightProportionOfDateContainer,
          width: MediaQuery.of(context).size.width,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  border: const Border(
                      top: BorderSide(
                          width: 2.5
                      )
                  ),
                  color: widget.dateColor
              ),
              child: Row(
                children: [
                  Padding(
                    padding: Variables.fixedEdgeInsets,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * Variables.widthOfDayInDateContainer,
                      child: Text(
                        widget.dayText,
                        style: TextStyle(
                          color: widget.textColor,
                          fontSize: deviceWidth * 0.04,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  Padding(
                    padding: Variables.fixedEdgeInsets,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * Variables.widthOfDateInDateContainer,
                      child: Text(
                        widget.dateText,
                        style: TextStyle(
                          color: widget.textColor,
                          fontSize: deviceWidth * 0.04 ,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              )
          ),
        ), //DateContainer
        SizedBox(
          height: deviceHeight * Variables.heightProportionOfTaskContainer,
          width: deviceWidth,
          child: DecoratedBox(
          decoration: BoxDecoration(color: widget.taskColor),
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Padding(
              padding: Variables.fixedEdgeInsets,
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
                        style: raisedButtonStyle,
                        child: Text(
                          "Create A Task",
                          style: TextStyle(
                            fontSize: deviceWidth * 0.035,
                          ),
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
  );
}
}

