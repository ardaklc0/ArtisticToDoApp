import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro2/models/task_model.dart';
import 'package:pomodoro2/services/task_service.dart';
import 'package:pomodoro2/ui/widgets/common_widgets.dart';
import 'package:provider/provider.dart';
import '../../provider/keyboard_provider.dart';
import '../helper/common_variables.dart';
import '../styles/common_styles.dart';
class TaskRow extends StatefulWidget {
  final Color? textColor;
  final Color checkboxColor;
  final String? text;
  final String? dateText;
  final Task? task;
  final int plannerId;
  final int priority;
  const TaskRow({super.key,
    required this.textColor,
    required this.checkboxColor,
    this.text, this.dateText,
    this.task,
    required this.plannerId,
    required this.priority});
  @override
  State<TaskRow> createState() => _TaskRowState();
}
class _TaskRowState extends State<TaskRow> {
  final FocusNode _focus = FocusNode();
  final FocusNode _focus2 = FocusNode();
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
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    final keyboardProvider = Provider.of<KeyboardProvider>(context, listen: false);
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
                          priority: widget.priority,
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
                            onLongPress: () {
                              print("dgsasga");
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
                                style: GoogleFonts.abel(
                                  color: widget.task!.isDone == 1 ? Colors.black.withOpacity(0.5) : Colors.black,
                                  fontSize: deviceWidth * 0.042,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  textStyle: textStyle(widget.textColor, deviceWidth),
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
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (widget.priority == 0) {
                  return widget.checkboxColor;
                } else if (widget.priority == 1) {
                  return Colors.redAccent;
                } else if (widget.priority == 2) {
                  return Colors.orangeAccent;
                } else if (widget.priority == 3) {
                  return Colors.blueAccent;
                }
              }),
              value: intConverter(widget.task!.isDone),
              onChanged: (bool? value) async {
                print("Priority: ${widget.task!.priority}");
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
                    priority: widget.priority,
                  );
                  await updateTask(existingTask);
                  print("Updated existing task: $existingTask");
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