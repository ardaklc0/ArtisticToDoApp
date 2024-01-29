import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro2/services/planner_service.dart';
import 'package:pomodoro2/services/task_service.dart';
import 'package:pomodoro2/ui/helper/common_variables.dart';
import 'package:pomodoro2/ui/styles/common_styles.dart';
import 'package:pomodoro2/ui/widgets/pomodoro_widgets/appbar_widgets.dart';
import 'package:provider/provider.dart';
import '../../../models/planner_model.dart';
import '../../../models/task_model.dart';
import '../../../provider/time_provider.dart';
import '../common_widgets.dart';

class TimeIndicatorWidget extends StatelessWidget {
  const TimeIndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    double progress = 1 -
        (timerProvider.maxTimeInSeconds != 0
            ? timerProvider.currentTimeInSeconds / timerProvider.maxTimeInSeconds
            : 5);


    return CircularProgressIndicator(
      strokeWidth: 15.0,
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
      backgroundColor: const Color.fromRGBO(242, 245, 234, 1),
      value: progress,
    );
  }
}

class StudyBreakWidget extends StatelessWidget {
  const StudyBreakWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TimeWidget(),
        TimeModeWidget(),
      ],
    );
  }
}

class TimeModeWidget extends StatelessWidget {
  const TimeModeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    return Text(
      timerProvider.isBreakTime ? 'RELAX' : 'STUDY',
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    return Text(
      timerProvider.currentTimeDisplay,
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class MediaButtons extends StatelessWidget {
  const MediaButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: timerProvider.isEqual ? null : timerProvider.resetTimer,
          icon: const Icon(Icons.replay, size: 30.0),
        ),
        IconButton(
          onPressed: () {
            timerProvider.toggleTimer();
            if (!timerProvider.isRunning) {
              timerProvider.cancelState();
              if (timerProvider.isCancel) {
                _dialogBuilder(context);
              }
            }
          },
          icon: Icon(
            timerProvider.isRunning ? Icons.pause : Icons.play_arrow,
            size: 45.0,
          ),
        ),
        SettingsButton()
      ],
    );
  }
}



class TaskDropdownWidget extends StatelessWidget {
  const TaskDropdownWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    final isTenSeconds = (timerProvider.maxTimeInSeconds - timerProvider.currentTimeInSeconds != 0);
    final shouldShowDropdown = (!timerProvider.isRunning);

    //Consumer<TimerProvider> kullan!
    //TimerProvider yerine PlannerProvider ve TaskProvider kullan!
    Future<DropdownButtonFormField<String>>? retrievePlanners() async {
      List<String> plannerIds = [];
      List<Planner> planners = await getPlanners();
      for (var element in planners) {
        plannerIds.add(element.id.toString());
      }
      if (timerProvider.plannerId == null) {
        timerProvider.setPlannerId(int.parse( plannerIds.first));
      }
      List<DropdownMenuItem<String>> dropdownItems = plannerIds
          .map((String id) => DropdownMenuItem<String>(value: id, child: Text(id)))
          .toList();
      return DropdownButtonFormField<String>(
        value: timerProvider.plannerId.toString(),
        items: dropdownItems,
        onChanged: (value) {
          timerProvider.setPlannerId(int.parse(value!));
        },
      );
    }

    Future<DropdownButtonFormField<String>>? retrieveTasks() async {
      List<String> taskDescriptions = [];
      List<Task> tasks = await getUncheckedTasks(timerProvider.plannerId!);
      for (var element in tasks) {
        taskDescriptions.add(element.taskDescription);
      }
      List<DropdownMenuItem<String>> dropdownItems = taskDescriptions
          .map((String id) => DropdownMenuItem<String>(value: id, child: Text(id)))
          .toList();
      return DropdownButtonFormField<String>(
        value: timerProvider.taskDescription,
        items: dropdownItems,
        onChanged: (value) {
          timerProvider.setTaskDescription(value!);
        },
      );
    }

    if (!timerProvider.isRunning) {
      return Column(
        children: [
          FutureBuilder<DropdownButtonFormField<String>>(
            future: retrievePlanners(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return shouldShowDropdown ? snapshot.data! : const Text("");
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          FutureBuilder<DropdownButtonFormField<String>>(
            future: retrieveTasks(),
            builder: (context, snapshot) {
              try {
                if (snapshot.connectionState == ConnectionState.done) {
                  return shouldShowDropdown ? snapshot.data! : const Text("");
                } else {
                  return const CircularProgressIndicator();
                }
              } catch (error) {
                return const Text("There is no open tasks");
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
              },
              style: mainUiRaisedButtonStyle,
              child: const Text("Start"),
            ),
          )
        ],
      );
    }
    if (!timerProvider.isRunning && isTenSeconds) {
      return Column(
        children: [
          Text("${timerProvider.maxTimeInSeconds - timerProvider.currentTimeInSeconds} STUDY TIME NOT RUNNING"),
          ElevatedButton(
            onPressed: () {
              DateFormat formatter = DateFormat.Hms();
              print("Start: ${formatter.format(timerProvider.currentDateTime)}");
              print("Now: ${formatter.format(timerProvider.currentDateTime.add(Duration(seconds: timerProvider.maxTimeInSeconds - timerProvider.currentTimeInSeconds)))}");
            },
            style: mainUiRaisedButtonStyle,
            child: Text("Save : ${timerProvider.isCancel}"),
          )
        ],
      );
    }
    return const Text("");
  }
}

Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
          'Your progress will be deleted. Do you really want to cancel?',
        ),
        backgroundColor: homePageColor,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text(
              'Yes',
              style: TextStyle(
                color: Colors.black
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text(
              "No, let's continue",
              style: TextStyle(
                  color: Colors.black
              )
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}