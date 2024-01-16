import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro2/task_row.dart';
import 'common_variables.dart';

class TaskContainer extends StatelessWidget {
  final Color dateColor;
  final Color? taskColor;
  final Color? textColor;
  final String dayText;
  final String dateText;
  const TaskContainer({super.key, required this.dateColor, required this.taskColor, required this.textColor, required this.dayText, required this.dateText});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
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
                      color: dateColor
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: Variables.fixedEdgeInsets,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * Variables.widthOfDayInDateContainer,
                          child: Text(
                            dayText,
                            style: TextStyle(
                              color: textColor,
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
                            dateText,
                            style: TextStyle(
                              color: textColor,
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
              decoration: BoxDecoration(color: taskColor),
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
                        TaskRow(
                          textColor: textColor,
                          checkboxColor: dateColor,
                        ),
                        TaskRow(
                          textColor: textColor,
                          checkboxColor: dateColor,
                        ),
                        TaskRow(
                          textColor: textColor,
                          checkboxColor: dateColor,
                        ),
                        TaskRow(
                          textColor: textColor,
                          checkboxColor: dateColor,
                        ),
                        TaskRow(
                          textColor: textColor,
                          checkboxColor: dateColor,
                        ),
                        TaskRow(
                          textColor: textColor,
                          checkboxColor: dateColor,
                        )
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

