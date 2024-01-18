import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro2/Task/task_entity.dart';
import 'package:pomodoro2/Task/task_service.dart';
import '../common_variables.dart';

class TaskRow extends StatefulWidget {
  final Color? textColor;
  final Color checkboxColor;
  final String? text;
  final String? dateText;
  final Task? task;
  final int plannerId;
  const TaskRow({super.key, required this.textColor, required this.checkboxColor, this.text, this.dateText, this.task, required this.plannerId});
  @override
  State<TaskRow> createState() => _TaskRowState();
}
class _TaskRowState extends State<TaskRow> {
  bool isChecked = false;
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

    final double deviceWidth = MediaQuery.of(context).size.width;
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
    return Row(
      children: [
        SizedBox(
          width: deviceWidth * 0.80,
          child: Focus(
            onFocusChange: (value) async {
              String dayFormat = "";
              if (_controller.text.isNotEmpty) {
                if (widget.dateText == null) {
                  DateTime dateTime = DateTime.now();
                  dayFormat = DateFormat('yMd').format(dateTime).toString();
                } else {
                  dayFormat = widget.dateText!;
                }
                if (widget.task != null) {
                  var existingTask = Task(
                    id: widget.task!.id,
                    creationDate: widget.task!.creationDate,
                    taskDescription: _controller.text,
                    plannerId: widget.plannerId
                  );
                  await updateTask(existingTask);
                  print("Updated existing task: $existingTask");
                } else {
                  var newTask = Task(
                    taskDescription: _controller.text,
                    creationDate: dayFormat,
                    plannerId: widget.plannerId
                  );
                  try {
                    await insertTask(newTask);
                  } catch (error) {
                    print("Error creating new task: $error");
                  }
                }
                List<Task> tasks = await getTasks(1);
                tasks.forEach((element) {
                  print(element);
                });
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
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                controller: _controller,

                maxLines: null,
                autofocus: false,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: widget.checkboxColor,
                        width: 1.5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.checkboxColor,
                      width: 1.5),
                  ),
                ),
                style: TextStyle(
                  fontSize: deviceWidth * 0.035,
                  decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
                  color: widget.textColor,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: Variables.fixedEdgeInsets,
          child: SizedBox(
            width: deviceWidth * 0.10,
            child: Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
