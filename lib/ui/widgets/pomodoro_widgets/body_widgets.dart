import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro2/provider/task_provider.dart';
import 'package:pomodoro2/services/planner_service.dart';
import 'package:pomodoro2/services/task_service.dart';
import 'package:pomodoro2/ui/helper/common_variables.dart';
import 'package:pomodoro2/ui/styles/common_styles.dart';
import 'package:pomodoro2/ui/widgets/pomodoro_widgets/appbar_widgets.dart';
import 'package:provider/provider.dart';
import '../../../models/planner_model.dart';
import '../../../models/task_model.dart';
import '../../../provider/planner_provider.dart';
import '../../../provider/time_provider.dart';

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
    final taskProvider = Provider.of<TaskProvider>(context);
    final plannerProvider = Provider.of<PlannerProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: timerProvider.isEqual ? null : timerProvider.resetTimer,
          icon: const Icon(Icons.replay, size: 30.0),
        ),
        IconButton(
          onPressed: () async {
            timerProvider.toggleTimer();
            print("plannerId: ${plannerProvider.plannerId} <=> taskId: ${taskProvider.taskId}");
            if (!timerProvider.isRunning) {
              timerProvider.cancelState();
              if (timerProvider.isCancel) {
                await _dialogBuilder(context) ?
                timerProvider.resetTimer() :
                timerProvider.toggleTimer();
              }
            }
            
          },
          icon: Icon(
            timerProvider.isRunning ? Icons.pause : Icons.play_arrow,
            size: 45.0,
          ),
        ),
        const SettingsButton()
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
    final taskProvider = Provider.of<TaskProvider>(context);
    final plannerProvider = Provider.of<PlannerProvider>(context);
    //Consumer<TimerProvider> kullan!
    //TimerProvider yerine PlannerProvider ve TaskProvider kullan!
    if (!timerProvider.isRunning && plannerProvider.plannerId != null) {
      return Column(
        children: [
          FutureBuilder<List<int?>>(
            future: getPlannerIds(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<int?> plannerIds = snapshot.data ?? [];
                return DropdownButtonFormField<int?>(
                  value: plannerProvider.plannerId,
                  items: plannerIds.map((plannerId) {
                    return DropdownMenuItem<int?>(
                      value: plannerId,
                      child: Text(
                        plannerId.toString(),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    taskProvider.resetTask();
                    plannerProvider.setPlannerId(value!);
                  },
                );
              }
            },
          ),
          FutureBuilder<Map<String, String>>(
            future: getTaskDescriptionAndId(plannerProvider.plannerId ?? 0),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Text('No task descriptions available.');
              } else {
                Map<String, String> tasks = (snapshot.data as Map<String, String>);
                return DropdownButtonFormField<int>(
                  value: taskProvider.taskId,
                  items: tasks.entries.map((task) {
                    return DropdownMenuItem<int>(
                      value: int.parse(task.key),
                      child: Text(
                        task.value,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    print("value: $value");
                    taskProvider.setTaskId(value!);
                    print("timerProvider.taskId: ${taskProvider.taskId}");
                  },
                );
              }
            },
          )
        ],
      );
    } else {
      return Column(
        children: [
          Text("${timerProvider.maxTimeInSeconds - timerProvider.currentTimeInSeconds} STUDY TIME NOT RUNNING"),
          ElevatedButton(
            onPressed: () async {
              DateFormat formatter = DateFormat.Hms();
              print("Start: ${formatter.format(timerProvider.currentDateTime)}");
              print("Now: ${formatter.format(timerProvider.currentDateTime.add(Duration(seconds: timerProvider.maxTimeInSeconds - timerProvider.currentTimeInSeconds)))}");

              var planners = await getPlannerIds();
              var firstPlanner = planners.first;
              plannerProvider.setPlannerId(firstPlanner!);
            },
            style: mainUiRaisedButtonStyle,
            child: Text("Save : ${timerProvider.isCancel}"),
          )
        ],
      );
    }
  }
}

Future<List<String>> getTaskDescriptions(int plannerId) async {
  List<Task> tasks = await getUncheckedTasks(plannerId);
  return tasks.map((task) => task.taskDescription).toList();
}
Future<Map<String, String>> getTaskDescriptionAndId(int plannerId) async {
  List<Task> tasks = await getUncheckedTasks(plannerId);
  Map<String, String> taskMap = {};
  for (var task in tasks) {
    taskMap[task.id.toString()] = task.taskDescription;
  }
  return taskMap;
}
Future<List<Task>> getTasks(int plannerId) async {
  return await getUncheckedTasks(plannerId);
}
Future<List<int?>> getPlannerIds() async {
  List<Planner> planners = await getPlanners();
  return planners.map((planner) => planner.id).toList();
}
Future<List<int?>> getTaskIds(int plannerId) async {
  List<Task> tasks = await getTasks(plannerId);
  return tasks.map((task) => task.id).toList();
}
Future<bool> _dialogBuilder(BuildContext context) async {
  bool confirm = false;
  confirm = await showDialog(
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
              Navigator.of(context).pop(true);
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
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
    },
  );
  return confirm;
}