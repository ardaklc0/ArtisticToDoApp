import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro2/services/picasso_colors.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../models/planner_model.dart';
import '../models/task_model.dart';
import '../provider/chosen_day_provider.dart';
import '../provider/keyboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../provider/navbar_provider.dart';
import '../provider/task_provider.dart';
import '../services/planner_service.dart';
import '../services/task_service.dart';
import '../ui/helper/common_functions.dart';
import '../ui/helper/common_variables.dart';
import '../ui/widgets/image_container.dart';
String randomImage = randomImageChooser("Picasso");
class Picasso extends StatefulWidget {
  const Picasso({super.key, required this.title, this.plannerId, this.date});
  final String title;
  final int? plannerId;
  final String? date;
  @override
  State<Picasso> createState() => _PicassoState();
}
class _PicassoState extends State<Picasso> {
  late Future<SingleChildScrollView> taskFuture;
  late List<Color> colorList;
  late ScrollController scrollController;
  String error = '';
  Set<String> selectedDays = {};
  late TaskProvider mainTaskProvider;

  @override
  void initState() {
    super.initState();
    List<Color> chosenColors = picassoColors.firstWhere((element) => element.fileName.contains(randomImage)).colors;
    colorList = [chosenColors.first, chosenColors.last];
    mainTaskProvider = Provider.of<TaskProvider>(context, listen: false);
    String today = DateFormat('M/d/yyyy').format(DateTime.now());
    double creationOffset = createOffsetWithRespectToChosenDay(today);
    scrollController = ScrollController(initialScrollOffset: creationOffset);
    taskFuture = createPlanner(
      widget.date!,
      widget.plannerId!,
      colorList.last,
      colorList.first,
      Colors.black,
      assignedController: scrollController,
    );
  }
  Future showDaysToChoose() async {
    Planner? currentPlanner = await getPlanner(widget.plannerId!);
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    DateFormat inputFormat = DateFormat("M/d/yyyy");
    DateTime parsedDateTime = inputFormat.parse(
        currentPlanner!.creationDate.toString());
    DateFormat dateFormat = DateFormat('yMd');
    DateRangePickerController controller = DateRangePickerController();
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        final chosenDayProvider = Provider.of<ChosenDayProvider>(context);
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: colorList.last,
                content: SizedBox(
                  width: width * 0.8, // Set your desired width
                  height: height * 0.5,
                  child: MaterialApp(
                    theme: ThemeData(
                      colorScheme: ColorScheme.fromSeed(
                        seedColor: Colors.white,
                        primary: Colors
                            .black, // Explicitly set text color to white
                      ),
                      useMaterial3: true,
                    ),
                    debugShowCheckedModeBanner: false,
                    home: SfDateRangePicker(
                      controller: controller,
                      selectionColor: colorList.first.withOpacity(0.5),
                      selectionTextStyle: GoogleFonts.roboto(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      monthCellStyle: DateRangePickerMonthCellStyle(
                        textStyle: GoogleFonts.roboto(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
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
                          color: Colors.black,
                        ),
                      ),
                      cancelText: 'Cancel',
                      todayHighlightColor: Colors.black,
                      rangeSelectionColor: Colors.black,
                      endRangeSelectionColor: Colors.black,
                      startRangeSelectionColor: Colors.black,
                      confirmText: 'Confirm',
                      initialSelectedDates: chosenDayProvider.chosenDay.isEmpty
                          ?
                      []
                          : [
                        for (int i = 0; i <
                            chosenDayProvider.chosenDay.length; i++)
                          dateFormat.parse(chosenDayProvider.chosenDay
                              .elementAt(i))
                      ],
                      selectionMode: DateRangePickerSelectionMode.multiple,
                      onCancel: () {
                        selectedDays.clear();
                        Navigator.of(context).pop();
                      },
                      onSelectionChanged: (
                          dateRangePickerSelectionChangedArgs) {
                        selectedDays.clear();
                        for (int i = 0; i < dateRangePickerSelectionChangedArgs
                            .value.length; i++) {
                          selectedDays.add(dateFormat.format(
                              dateRangePickerSelectionChangedArgs.value[i]));
                        }
                      },
                      onSubmit: (dateRangePickerSubmitArgs) {
                        chosenDayProvider.setChosenDay(selectedDays);
                        if (chosenDayProvider.chosenDay.isNotEmpty) {
                          error = '';
                          setState(() {});
                        }
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

  double createOffsetWithRespectToChosenDay(String date) {
    final double deviceHeight = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    final containerSize = (deviceHeight * heightProportionOfDateContainer + deviceHeight * 0.33 + 20);
    DateTime startDate = DateFormat('M/d/yyyy').parse(widget.date!);
    DateTime chosenDate = DateFormat('M/d/yyyy').parse(date);
    return (chosenDate.difference(startDate).inDays * containerSize);
  }

  Future showSaveScreen() async {
    TextEditingController controller = TextEditingController(text: "");
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
                backgroundColor: colorList.last,
                title: Text(
                  'Create a new task',
                  style: GoogleFonts.roboto(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5, // Set width to 80% of screen width
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
                          decoration: const InputDecoration(
                            hintText: 'Enter task description',
                            hintStyle: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
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
                            Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  showDaysToChoose();
                                },
                                icon: Icon(
                                  Icons.calendar_month,
                                  color: chosenDayProvider.chosenDay.isEmpty
                                      ? Colors.black
                                      : Colors.redAccent,
                                ),
                                color: Colors.black,
                              ),
                            ),
                            PopupMenuButton<int>(
                              tooltip: 'Select priority',
                              color: colorList.last,
                              itemBuilder: (context) =>
                              [
                                PopupMenuItem(
                                  value: 1,
                                  child: Row(
                                    children: [
                                      const Icon(
                                          Icons.flag, color: Colors.redAccent),
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
                                      const Icon(
                                          Icons.flag, color: Colors.orangeAccent),
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
                                      const Icon(
                                          Icons.flag, color: Colors.blueAccent),
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
                                    taskProvider.setPrioColor(
                                        Colors.orangeAccent);
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
                                setState(() {});
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)),
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
                      'Close',
                      style: GoogleFonts.roboto(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () async {
                      taskProvider.setPrioColor(Colors.black);
                      chosenDayProvider.clearChosenDay();
                      error = '';
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
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () async {
                      if (controller.text == "" && chosenDayProvider.chosenDay.isEmpty) {
                        error = 'Please enter a task description and select a day!';
                        setState(() {});
                        return;
                      } else if (controller.text == "") {
                        error = 'Please enter a task description!';
                        setState(() {});
                        return;
                      } else if (chosenDayProvider.chosenDay.isEmpty) {
                        String formatDate = DateFormat('yMd').format(DateTime.now());
                        Task newTask = Task(
                          taskDescription: controller.text,
                          priority: selectedColor,
                          creationDate: formatDate,
                          plannerId: widget.plannerId!,
                        );
                        await insertTask(newTask);
                        double offset = createOffsetWithRespectToChosenDay(formatDate);
                        mainTaskProvider.setInitialOffset(offset);
                        setState(() {});
                        taskProvider.setPrioColor(Colors.black);
                        chosenDayProvider.clearChosenDay();
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                      } else {
                        for (int i = 0; i < chosenDayProvider.chosenDay.length; i++) {
                          Task newTask = Task(
                            taskDescription: controller.text,
                            priority: selectedColor,
                            creationDate: chosenDayProvider.chosenDay.elementAt(i),
                            plannerId: widget.plannerId!,
                          );
                          await insertTask(newTask);
                        }
                        setState(() {});
                        double offset = createOffsetWithRespectToChosenDay(chosenDayProvider.chosenDay.first);
                        mainTaskProvider.setInitialOffset(offset);
                        taskProvider.setPrioColor(Colors.black);
                        chosenDayProvider.clearChosenDay();
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
  Future<void> addTask() async {
    await showSaveScreen();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final navbarProvider = Provider.of<NavbarProvider>(context);
    final keyboardProvider = Provider.of<KeyboardProvider>(context, listen: false);
    final viewInsets = EdgeInsets.fromViewPadding(WidgetsBinding.instance.window.viewInsets, WidgetsBinding.instance.window.devicePixelRatio);
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          navbarProvider.showNavbar();
          keyboardProvider.hideKeyboard();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorList.last,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
              mainTaskProvider.setInitialOffset(0.0);
            },
          ),
        ),
        backgroundColor: colorList.last,
        resizeToAvoidBottomInset: true,
        persistentFooterButtons: !keyboardProvider.isKeyboardVisible ? [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(colorList.last),
                  elevation: WidgetStateProperty.all(0),
                  shape: WidgetStateProperty.all(
                    const CircleBorder(
                        side: BorderSide(color: Colors.black, width: 1.0)
                    ),
                  ),
                ),
                onPressed: () async {
                  await addTask();
                  taskFuture = createPlanner(
                    widget.date!,
                    widget.plannerId!,
                    colorList.last,
                    colorList.first,
                    Colors.black,
                    assignedController: ScrollController(initialScrollOffset: mainTaskProvider.initialOffset),
                  );
                  setState(() {});
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ] : [],
        body: AnimatedPadding(
            duration: const Duration(milliseconds: 150),
            padding: EdgeInsets.only(
              bottom: keyboardProvider.isKeyboardVisible
                  ? viewInsets.bottom
                  : 0,
            ),
            child: _buildBody(deviceWidth, deviceHeight)
        ),
      ),
    );
  }

  Widget _buildBody(double deviceWidth, double deviceHeight) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ImageContainer(
          imageUrl: randomImage,
          imageAlignment: Alignment.center,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: FutureBuilder<SingleChildScrollView>(
                  future: taskFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return snapshot.data ?? Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}