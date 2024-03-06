import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro2/models/task_model.dart';
import 'package:pomodoro2/ui/widgets/task_row.dart';
import 'package:pomodoro2/services/task_service.dart';
import '../helper/common_variables.dart';
import '../helper/task_function.dart';
import '../styles/common_styles.dart';
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
  late FocusNode _newTaskFocusNode;
  @override
  void initState() {
    super.initState();
    _newTaskFocusNode = FocusNode();
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
    _newTaskFocusNode.requestFocus();
  }
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
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
                child: Stack(
                  children: [
                    Padding(
                      padding: fixedEdgeInsets.copyWith(bottom: deviceHeight * 0.06),
                      child: SingleChildScrollView(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Column(
                          children: textFields,
                        ),
                      ),
                    ),
                    Positioned(
                      top: deviceHeight * 0.240,
                      child: Container(
                        color: widget.dateColor,
                      ),
                    ),
                    Positioned(
                      top: deviceHeight * 0.240,
                      left: deviceWidth * 0.825,
                      child: ElevatedButton(
                        onPressed: addTask,
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(deviceHeight * 0.05, deviceHeight * 0.05),
                          ),
                          iconSize: MaterialStateProperty.all<double>(deviceHeight * 0.03),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                          minimumSize: MaterialStateProperty.all<Size>(Size.zero),
                          alignment: Alignment.center,
                          backgroundColor: MaterialStateProperty.all<Color>(widget.dateColor),
                          shape: MaterialStateProperty.all<CircleBorder>(
                            const CircleBorder(),
                          ),
                          elevation: MaterialStateProperty.all<double>(10.0),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ), //TaskContainer
        ],
      ),
    );
  }
}

