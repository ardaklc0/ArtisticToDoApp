import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro2/models/task_model.dart';
import 'package:pomodoro2/services/task_service.dart';
import 'package:pomodoro2/ui/widgets/common_widgets.dart';
import 'package:provider/provider.dart';
import '../../provider/keyboard_provider.dart';
import '../../provider/task_provider.dart';
import '../../provider/task_update_provider.dart';
import '../helper/common_variables.dart';
class TaskRow extends StatefulWidget {
  final Color? textColor;
  final Color checkboxColor;
  final String? text;
  final String? dateText;
  final Task? task;
  final int plannerId;
  int? priority;
  TaskRow({super.key,
    required this.textColor,
    required this.checkboxColor,
    this.text, this.dateText,
    this.task,
    required this.plannerId,
    this.priority});
  @override
  State<TaskRow> createState() => _TaskRowState();
}
class _TaskRowState extends State<TaskRow> {
  final FocusNode _focus = FocusNode();
  final FocusNode _focus2 = FocusNode();
  String error = '';
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.text != null) {
      _controller.text = widget.text!;
    } else {
      _controller.text = "";
    }
  }
  @override
  void dispose() {
    super.dispose();
    _focus.dispose();
    _controller.dispose();
  }
  Future showSaveScreen(TaskUpdateProvider taskUpdateProvider) async {
    TextEditingController controller = TextEditingController(text: _controller.text);
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    int selectedColor = 0;
    String prioName = '';
    if (widget.priority == 0) {
      taskProvider.setPrioColor(Colors.black);
      selectedColor = 0;
    } else if (widget.priority == 1) {
      taskProvider.setPrioColor(Colors.redAccent);
      prioName = 'H';
      selectedColor = 1;
    } else if (widget.priority == 2) {
      taskProvider.setPrioColor(Colors.orangeAccent);
      prioName = 'M';
      selectedColor = 2;
    } else if (widget.priority == 3) {
      taskProvider.setPrioColor(Colors.blueAccent);
      prioName = 'L';
      selectedColor = 3;
    }

    return showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: widget.checkboxColor,
                title: Text(
                  'Edit the task',
                  style: GoogleFonts.roboto(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: error.isNotEmpty,
                        child: Text(
                          error,
                          style: GoogleFonts.roboto(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            color: Colors.red,
                          ),
                        ),
                      ),
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
                          onChanged: (value) {
                            error = '';
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter task description',
                            hintStyle: GoogleFonts.roboto(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(0.35),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            PopupMenuButton<int>(
                              tooltip: 'Select priority',
                              color: widget.checkboxColor,
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
                                PopupMenuItem(
                                  value: 4,
                                  child: Row(
                                    children: [
                                      const Icon(Icons.flag, color: Colors.black),
                                      Text(
                                        'No Priority',
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
                                    prioName = 'H';
                                    break;
                                  case 2:
                                    taskProvider.setPrioColor(Colors.orangeAccent);
                                    selectedColor = 2;
                                    prioName = 'M';
                                    break;
                                  case 3:
                                    taskProvider.setPrioColor(Colors.blueAccent);
                                    selectedColor = 3;
                                    prioName = 'L';
                                    break;
                                  case 4:
                                    taskProvider.setPrioColor(Colors.black);
                                    selectedColor = 0;
                                    prioName = '';
                                    break;
                                }
                                setState(() {
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.flag,
                                      color: taskProvider.prioColor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      prioName,
                                      style: GoogleFonts.roboto(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                        color: taskProvider.prioColor,
                                      ),
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
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.roboto(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () async {
                      taskProvider.setPrioColor(Colors.black);
                      error = '';
                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Submit',
                      style: GoogleFonts.roboto(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () async {
                      if (controller.text == "") {
                        error = 'Please enter a task description!';
                        setState(() {});
                        return;
                      } else {
                        var existingTask = Task(
                          id: widget.task!.id,
                          creationDate: widget.task!.creationDate,
                          taskDescription: controller.text,
                          plannerId: widget.plannerId,
                          isDone: widget.task!.isDone,
                          priority: selectedColor,
                        );
                        await updateTask(existingTask);
                        _controller.text = controller.text;
                        taskProvider.setPrioColor(Colors.black);
                        widget.priority = selectedColor;
                        error = '';
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            }
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    final keyboardProvider = Provider.of<KeyboardProvider>(context, listen: false);
    TaskUpdateProvider taskUpdateProvider = Provider.of<TaskUpdateProvider>(context);
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (direction) async {
        return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: widget.checkboxColor,
              title: dismissibleText("Confirmation", deviceHeight, dismissibleColor),
              content: dismissibleText("Are you sure you want to delete this item?", deviceHeight, dismissibleColor),
              actions: <Widget>[
                dismissibleButton("Cancel", deviceHeight, dismissibleColor, false, context),
                dismissibleButton("Delete", deviceHeight, dismissibleColor, true, context)
              ],
            );
          },
        );
      },
      onDismissed: (direction) async {
        await deleteTask(widget.task!.id!);
      },
      secondaryBackground: Container(
        color: widget.checkboxColor,
        child: const Icon(
          Icons.delete,
          color: Colors.black,
        ),
      ),
      background: Container(
        color: widget.checkboxColor,
        child: const Icon(
          Icons.delete,
          color: Colors.black,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                width: deviceWidth * 0.80,
                child: Focus(
                  onFocusChange: (value) async {
                    value ? keyboardProvider.showKeyboard() : keyboardProvider.hideKeyboard();
                    if (_controller.text.isNotEmpty) {
                      if (widget.task != null) {
                        var existingTask = Task(
                          id: widget.task!.id,
                          creationDate: widget.task!.creationDate,
                          taskDescription: _controller.text,
                          plannerId: widget.plannerId,
                          priority: widget.priority!,
                        );
                        await updateTask(existingTask);
                      }
                    }
                  },
                  focusNode: _focus,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: widget.checkboxColor,
                        selectionColor: widget.checkboxColor,
                        selectionHandleColor: widget.checkboxColor,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(4, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            textSelectionTheme: const TextSelectionThemeData(
                              cursorColor: Colors.black,
                              selectionHandleColor: Colors.black,
                              selectionColor: Colors.black38,
                            ),
                          ),
                          child: MaterialButton(
                            onLongPress: () async {
                              await showSaveScreen(taskUpdateProvider);
                              setState(() {

                              });
                            },
                            color: widget.checkboxColor,
                            onPressed: () => _focus2.requestFocus(),
                            child: AbsorbPointer(
                              child: TextField(
                                focusNode: _focus2,
                                clipBehavior: Clip.antiAlias,
                                cursorColor: Colors.black,
                                textCapitalization: TextCapitalization.sentences,
                                keyboardType: TextInputType.multiline,
                                controller: _controller,
                                maxLines: null,
                                autofocus: false,
                                decoration: InputDecoration(
                                  filled: false,
                                  fillColor: widget.checkboxColor,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: widget.checkboxColor,
                                        width: 1.5
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: widget.checkboxColor,
                                        width: 1.5
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  color: widget.task!.isDone == 1 ? Colors.black.withOpacity(0.5) : Colors.black,
                                  fontWeight: FontWeight.w300,
                                  decoration: widget.task!.isDone == 1 ? TextDecoration.lineThrough : TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Checkbox(
              checkColor: Colors.black,
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (widget.priority == 0) {
                  return widget.checkboxColor;
                } else if (widget.priority == 1) {
                  return Colors.redAccent;
                } else if (widget.priority == 2) {
                  return Colors.orangeAccent;
                } else if (widget.priority == 3) {
                  return Colors.blueAccent;
                }
                return null;
              }),
              value: intConverter(widget.task!.isDone),
              onChanged: (bool? value) async {
                setState(() {
                  widget.task!.isDone = boolConverter(value!);
                });
                int intValue = boolConverter(value!);
                if (widget.task != null) {
                  var existingTask = Task(
                    id: widget.task!.id,
                    creationDate: widget.task!.creationDate,
                    taskDescription: _controller.text,
                    plannerId: widget.plannerId,
                    isDone: intValue,
                    priority: widget.priority!,
                  );
                  await updateTask(existingTask);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  int boolConverter(bool boolExp) {
    return (boolExp == true) ? 1 : 0;
  }
  bool intConverter(int intExp) {
    return (intExp == 1) ? true : false;
  }
}