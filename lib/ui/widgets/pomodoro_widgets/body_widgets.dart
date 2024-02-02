import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
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
import '../../helper/common_functions.dart';
class TimeIndicatorWidget extends StatelessWidget {
  const TimeIndicatorWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    double progress = 1 -
        (timerProvider.maxTimeInSeconds != 0
            ? TimerProvider.currentTimeInSeconds / timerProvider.maxTimeInSeconds
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
    return Text(
      'STUDY',
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
          onPressed: () {
            timerProvider.resetTimer();
            taskProvider.resetTask();
            plannerProvider.resetPlanner();
            if (timerProvider.isRunning){
              timerProvider.toggleTimer();
            }
          },
          icon: const Icon(Icons.replay, size: 30.0),
        ),
        IconButton(
          onPressed: () async {
            if (TaskProvider.taskId == null && plannerProvider.plannerId == null) {
              timerProvider.toggleTimer();
            } else if (plannerProvider.plannerId != null) {
              if (TaskProvider.taskId != null) {
                timerProvider.toggleTimer();
              }
            }
            if (!timerProvider.isRunning) {
              timerProvider.cancelState();
              if (timerProvider.isCancel) {
                await dialogBuilder(context) ?
                timerProvider.resetTimer() :
                timerProvider.toggleTimer();
              }
            }
            print("plannerId: ${plannerProvider.plannerId} <=> taskId: ${TaskProvider.taskId}");
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

    if (!timerProvider.isRunning && plannerProvider.plannerId != null) {
      return Column(
        children: [
          FutureBuilder<List<Planner>>(
            future: getPlanners(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Planner> planners = snapshot.data ?? [];
                return DropdownButtonFormField<String>(
                  value: plannerProvider.plannerId.toString(),
                  items: planners.map((planner) {
                    return DropdownMenuItem<String>(
                      value: planner.id.toString(),
                      child: Text(
                        '${planner.id}.) at ${planner.creationDate} with ${planner.plannerArtist}',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    taskProvider.resetTask();
                    plannerProvider.setPlannerId(int.parse(value!));
                  },
                );
              }
            },
          ),
          FutureBuilder<List<Task>>(
            future: getUncheckedTasks(plannerProvider.plannerId ?? 0),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Text('No task descriptions available.');
              } else {
                List<Task> tasks = snapshot.data ?? [];
                return DropdownButtonFormField<int>(
                  value: TaskProvider.taskId,
                  items: tasks.map((task) {
                    return DropdownMenuItem<int>(
                      value: task.id,
                      child: Text(
                        task.taskDescription,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    taskProvider.setTaskId(value!);
                    print("value: $value");
                    print("timerProvider.taskId: ${TaskProvider.taskId}");
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
          Visibility(
            visible: !timerProvider.isRunning,
            child: ElevatedButton(
              onPressed: () async {
                try {
                  var planners = await getPlanners();
                  var firstPlanner = planners.first.id;
                  plannerProvider.setPlannerId(firstPlanner!);
                } catch (error) {
                  print(error);
                }
              },
              style: mainUiRaisedButtonStyle,
              child: const Text("Choose a task to done"),
            ),
          ),
        ],
      );
    }
  }
}
Future<bool> dialogBuilder(BuildContext context) async {
  bool confirm = false;
  confirm = await showDialog(
    context: context,
    builder: (BuildContext context) {
      final timerProvider = Provider.of<TimerProvider>(context);
      final taskProvider = Provider.of<TaskProvider>(context);
      final plannerProvider = Provider.of<PlannerProvider>(context);
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
              taskProvider.resetTask();
              plannerProvider.resetPlanner();
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