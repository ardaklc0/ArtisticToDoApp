import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro2/models/task_model.dart';
import 'package:pomodoro2/provider/chosen_day_provider.dart';
import 'package:pomodoro2/provider/task_provider.dart';
import 'package:pomodoro2/services/planner_service.dart';
import 'package:pomodoro2/ui/widgets/task_row.dart';
import 'package:pomodoro2/services/task_service.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../models/planner_model.dart';
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
  late FocusNode _newTaskFocusNode;
  Set<String> selectedDays = {};
  @override
  void initState() {
    super.initState();
    _newTaskFocusNode = FocusNode();
    initializeTasks(widget.tasks, textFields, widget.dateText, widget.textColor, widget.dateColor, widget.plannerId);
  }
  Future showDaysToChoose() async {
    Planner? currentPlanner = await getPlanner(widget.plannerId);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    DateFormat inputFormat = DateFormat("M/d/yyyy");
    DateTime parsedDateTime = inputFormat.parse(currentPlanner!.creationDate.toString());
    DateFormat dateFormat = DateFormat('yMd');
    DateFormat dayFormat = DateFormat('EE');
    DateRangePickerController controller = DateRangePickerController();
    return showDialog(
      barrierDismissible: false,
      context: context,
        builder: (BuildContext context) {
          final chosenDayProvider = Provider.of<ChosenDayProvider>(context);
          return StatefulBuilder(
            builder: (context, setState) {
             return AlertDialog(
               backgroundColor: widget.dateColor,
               content: Container(
                 width: width * 0.8 , // Set your desired width
                 height: height * 0.5,
                 child: MaterialApp(
                   theme: ThemeData(
                     colorScheme: ColorScheme.fromSeed(
                       seedColor: Colors.white,
                       primary: Colors.black, // Explicitly set text color to white
                     ),
                     useMaterial3: true,
                   ),
                   debugShowCheckedModeBanner: false,
                   home: SfDateRangePicker(
                     controller: controller,
                     selectionColor: widget.taskColor,
                     selectionTextStyle: GoogleFonts.roboto(
                       fontStyle: FontStyle.normal,
                       fontWeight: FontWeight.w400,
                       color: Colors.black,
                     ),
                     monthCellStyle: DateRangePickerMonthCellStyle(
                       textStyle: GoogleFonts.roboto(
                         fontStyle: FontStyle.normal,
                         fontWeight: FontWeight.w400,
                         color: widget.textColor,
                       ),
                     ),
                     backgroundColor: Colors.transparent,
                     minDate: parsedDateTime,
                     maxDate: parsedDateTime.add(const Duration(days: 6)),
                     showActionButtons: true,
                     headerStyle: DateRangePickerHeaderStyle(
                       backgroundColor: Colors.transparent,
                       textAlign: TextAlign.center,
                       textStyle: GoogleFonts.roboto(
                         fontStyle: FontStyle.normal,
                         fontWeight: FontWeight.w400,
                         color: widget.textColor,
                       ),
                     ),
                     cancelText: 'Cancel',
                     todayHighlightColor: Colors.black,
                     rangeSelectionColor: Colors.black,
                     endRangeSelectionColor: Colors.black,
                     startRangeSelectionColor: Colors.black,
                     confirmText: 'Confirm',
                     initialSelectedDates: chosenDayProvider.chosenDay.isEmpty ?
                     [] : [for (int i = 0; i < chosenDayProvider.chosenDay.length; i++)
                       dateFormat.parse(chosenDayProvider.chosenDay.elementAt(i))],
                     selectionMode: DateRangePickerSelectionMode.multiple,
                     onCancel: () {
                       selectedDays.clear();
                       Navigator.of(context).pop();
                     },
                     onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                        selectedDays.clear();
                        for (int i = 0; i < dateRangePickerSelectionChangedArgs.value.length; i++) {
                          selectedDays.add(dateFormat.format(dateRangePickerSelectionChangedArgs.value[i]));
                        }
                        print(selectedDays);
                      },
                     onSubmit: (dateRangePickerSubmitArgs) {
                       chosenDayProvider.setChosenDay(selectedDays);
                       Navigator.of(context).pop();
                     },
                   ),
                 ),
               ),
            );
          }
        );
      },
    );
  }

  Future showSaveScreen() async {
    TextEditingController controller = TextEditingController(text: "New Task");
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    int selectedColor = 0;
    String prioName = '';
    return showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        final chosenDayProvider = Provider.of<ChosenDayProvider>(context);
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              showDaysToChoose();
                            },
                            icon: Icon(
                              Icons.date_range,
                              color: chosenDayProvider.chosenDay.isEmpty ? Colors.black : Colors.green,
                            ),
                            color: Colors.black,
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
                    taskProvider.setPrioColor(Colors.black);
                    chosenDayProvider.clearChosenDay();
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
                    for (int i = 0; i < chosenDayProvider.chosenDay.length; i++) {
                      await insertTask(Task(
                        taskDescription: controller.text,
                        priority: selectedColor,
                        creationDate: chosenDayProvider.chosenDay.elementAt(i),
                        plannerId: widget.plannerId,
                      ));
                    }
                    taskProvider.setPrioColor(Colors.black);
                    chosenDayProvider.clearChosenDay();
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
    await showSaveScreen();
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
                        onPressed: () async {
                          await addTask();
                          setState(() {
                          });
                        },
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