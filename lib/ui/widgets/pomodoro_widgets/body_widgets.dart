import 'dart:async';

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
    final isTenSeconds = (timerProvider.maxTimeInSeconds - timerProvider.currentTimeInSeconds != 0);

    //Consumer<TimerProvider> kullan!
    //TimerProvider yerine PlannerProvider ve TaskProvider kullan!


    if (!timerProvider.isRunning) {
      return Column(
        children: [
          Consumer<TimerProvider>(
            builder: (BuildContext context, TimerProvider provider, Widget? child) {
              return FutureBuilder<List<int?>>(
                future: getPlannerIds(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<int?> plannerIds = snapshot.data ?? [];
                    return DropdownButtonFormField<int?>(
                      value: provider.plannerId,
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
                        timerProvider.setPlannerId(value!);
                        print("Selected plannerId: $value");
                      },
                    );
                  }
                },
              );
            },
          ),
          Consumer<TimerProvider>(
            builder: (BuildContext context, TimerProvider provider, Widget? child) {
              return FutureBuilder<List<String>>(
                future: getTaskDescriptions(provider.plannerId ?? 1),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Text('No task descriptions available.');
                  } else {
                    List<String> taskDescriptions = snapshot.data!;
                    return DropdownButtonFormField<String>(
                      items: taskDescriptions.map((taskDescription) {
                        return DropdownMenuItem<String>(
                          value: taskDescription,
                          child: Text(
                            taskDescription,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        print("Selected taskDescription: $value");
                      },
                    );
                  }
                },
              );
            },
          )
        ],
      );
    } else {
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
  }
}

Future<List<String>> getTaskDescriptions(int plannerId) async {
  List<Task> tasks = await getUncheckedTasks(plannerId);
  return tasks.map((task) => task.taskDescription).toList();
}

Future<List<int?>> getPlannerIds() async {
  List<Planner> planners = await getPlanners();
  return planners.map((planner) => planner.id).toList();
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