import 'package:flutter/material.dart';
import 'common_variables.dart';

class TaskRow extends StatefulWidget {
  final Color? textColor;
  final Color checkboxColor;
  const TaskRow({super.key, required this.textColor, required this.checkboxColor});
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
            focusNode: _focus,
            onFocusChange: (value) {
              print(_controller.text);
            },
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
                maxLines: null,
                autofocus: true,
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
