import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro2/models/task_model.dart';
import 'package:pomodoro2/provider/task_provider.dart';
import 'package:pomodoro2/ui/widgets/task_row.dart';
import 'package:pomodoro2/services/task_service.dart';
import 'package:provider/provider.dart';
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

  Future showSaveScreen(String taskDescription, int taskId) async {
    TextEditingController controller = TextEditingController(text: taskDescription);
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    int selectedColor = 0;
    return showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: widget.dateColor,
              title: Text(
                'Create a new task',
                style: GoogleFonts.roboto(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  color: widget.textColor,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      textSelectionTheme: const TextSelectionThemeData(
                        cursorColor: Colors.black,
                        selectionColor: Colors.black38,
                        selectionHandleColor: Colors.black,
                      ),
                    ),
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Enter task description',
                        hintStyle: GoogleFonts.roboto(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: widget.textColor?.withOpacity(0.35),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      controller: controller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        PopupMenuButton<int>(
                          tooltip: 'Select priority',
                          color: widget.dateColor,
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  const Icon(Icons.flag, color: Colors.redAccent),
                                  Text(
                                    'High Priority',
                                    style: GoogleFonts.roboto(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Row(
                                children: [
                                  const Icon(Icons.flag, color: Colors.orangeAccent),
                                  Text(
                                    'Mid Priority',
                                    style: GoogleFonts.roboto(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 3,
                              child: Row(
                                children: [
                                  const Icon(Icons.flag, color: Colors.blueAccent),
                                  Text(
                                    'Low Priority',
                                    style: GoogleFonts.roboto(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          onSelected: (value) {
                            switch (value) {
                              case 1:
                                taskProvider.setPrioColor(Colors.redAccent);
                                selectedColor = 1;
                                break;
                              case 2:
                                taskProvider.setPrioColor(Colors.orangeAccent);
                                selectedColor = 2;
                                break;
                              case 3:
                                taskProvider.setPrioColor(Colors.blueAccent);
                                selectedColor = 3;
                                break;
                            }
                            setState(() {
                            });
                            print('Selected: ${taskProvider.prioColor}');
                          },
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                      "Select Priority: ",
                                      style: GoogleFonts.roboto(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                        color: widget.textColor,
                                      )),
                                ),
                                Icon(
                                  Icons.flag,
                                  color: taskProvider.prioColor,
                                ),

                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Close',
                    style: GoogleFonts.roboto(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      color: widget.textColor,
                    ),
                  ),
                  onPressed: () async {
                    await deleteTask(taskId);
                    taskProvider.setPrioColor(Colors.black);
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    'Create',
                    style: GoogleFonts.roboto(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      color: widget.textColor,
                    ),
                  ),
                  onPressed: () async {
                    Task? newTask = await getTask(taskId);
                    print('Selected color: $selectedColor');
                    textFields.add(TaskRow(
                      textColor: widget.textColor,
                      checkboxColor: widget.dateColor,
                      text: controller.text,
                      dateText: newTask?.creationDate,
                      task: newTask,
                      plannerId: widget.plannerId,
                      priority: selectedColor,
                    ));
                    var existingTask = Task(
                      id: newTask!.id,
                      creationDate: newTask.creationDate,
                      taskDescription: controller.text,
                      plannerId: widget.plannerId,
                      priority: selectedColor,
                    );
                    await updateTask(existingTask);
                    taskProvider.setPrioColor(Colors.black);
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
        );
      },
    );
  }

  Future<void> addTask() async {
    Task? newTask = Task(
      taskDescription: "New Task",
      creationDate: widget.dateText,
      plannerId: widget.plannerId,
    );
    int taskId = await insertTask(newTask);
    await showSaveScreen(newTask.taskDescription, taskId);
    setState(() {});
    _newTaskFocusNode.requestFocus();
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

