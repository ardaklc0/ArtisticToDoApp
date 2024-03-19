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
  const TaskRow({super.key,
    required this.textColor,
    required this.checkboxColor,
    this.text, this.dateText,
    this.task,
    required this.plannerId});
  @override
  State<TaskRow> createState() => _TaskRowState();
}
class _TaskRowState extends State<TaskRow> {
  final FocusNode _focus = FocusNode();
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
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return widget.checkboxColor;
    }
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (direction) async {
        bool confirm = false;
        if (direction == DismissDirection.endToStart) {
          // Show deletion confirmation dialog for right swipe
          confirm = await showDialog(
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
        } else if (direction == DismissDirection.startToEnd) {
          Task? task = await getTask(widget.task!.id!);
          if (!context.mounted) return false;
          int? workedMinutes = task?.totalWorkMinutes;
          confirm = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: widget.checkboxColor,
                title: dismissibleText("Left Swipe Confirmation", deviceHeight, dismissibleColor),
                content: dismissibleText("This task have $workedMinutes worked minutes.", deviceHeight, dismissibleColor),
                actions: [
                  dismissibleButton("Close", deviceHeight, dismissibleColor, false, context)
                ],
              );
            },
          );
        }
        return confirm;
      },
      onDismissed: (direction) async {
        if (direction == DismissDirection.endToStart) {
          await deleteTask(widget.task!.id!);
        } else if (direction == DismissDirection.startToEnd) {
          print("Left swipe action");
        }
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
          Icons.info,
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
                    print(keyboardProvider.isKeyboardVisible);
                    if (_controller.text.isNotEmpty) {
                      if (widget.task != null) {
                        var existingTask = Task(
                            id: widget.task!.id,
                            creationDate: widget.task!.creationDate,
                            taskDescription: _controller.text,
                            plannerId: widget.plannerId
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
                          child: TextField(
                            clipBehavior: Clip.antiAlias,
                            cursorColor: Colors.black,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.multiline,
                            controller: _controller,
                            maxLines: null,
                            autofocus: false,
                            decoration: InputDecoration(
                              filled: true,
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
            Checkbox(
              checkColor: Colors.black,
              fillColor: MaterialStateProperty.resolveWith(getColor),
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