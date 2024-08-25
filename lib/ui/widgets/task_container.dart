import 'package:flutter/material.dart';
import 'package:pomodoro2/models/task_model.dart';
import '../helper/common_variables.dart';
import '../helper/task_function.dart';
import 'common_widgets.dart';
class TaskContainerTest extends StatefulWidget {
  final Color dateColor;
  final Color? taskColor;
  final Color? textColor;
  final String dayText;
  final String dateText;
  final List<Task>? tasks;
  final int plannerId;
  const TaskContainerTest({super.key, required this.dateColor, required this.taskColor, required this.textColor, required this.dayText, required this.dateText, this.tasks, required this.plannerId});
  @override
  State<TaskContainerTest> createState() => _TaskContainerTestState();
}
class _TaskContainerTestState extends State<TaskContainerTest> {
  List<Widget> textFields = [];
  @override
  void initState() {
    super.initState();
    initializeTasks(widget.tasks, textFields, widget.dateText, widget.textColor, widget.dateColor, widget.plannerId);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
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
                ),
                child: Row(
                  children: [
                    partOfTaskContainer(deviceWidth, widthOfDayInDateContainer, widget.dayText, widget.textColor),
                    SizedBox(
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
                color: widget.taskColor?.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Padding(
                  padding: fixedEdgeInsets.copyWith(),
                  child: SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      children: textFields,
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