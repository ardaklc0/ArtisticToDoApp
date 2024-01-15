import 'package:flutter/material.dart';

import 'common_variables.dart';
import 'gustav_klimt_variables.dart';

class TaskRow extends StatefulWidget {
  const TaskRow({super.key});
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
    final double deviceHeight = MediaQuery.of(context).size.height;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return const Color.fromRGBO(216, 162, 75, 1);
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
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              autofocus: true,
              style: TextStyle(
                fontSize: deviceWidth * 0.035,
                decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
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
