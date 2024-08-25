import 'package:flutter/material.dart';
import 'package:pomodoro2/provider/planner_provider.dart';
import 'package:pomodoro2/provider/task_provider.dart';
import 'package:pomodoro2/provider/time_provider.dart';
import 'package:provider/provider.dart';
import '../ui/helper/common_variables.dart';
import '../ui/widgets/common_widgets.dart';
import '../ui/widgets/pomodoro_widgets/body_widgets.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({super.key});
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        timerProvider.toggleTimer();
        dialogBuilder(context).whenComplete(() {
          if (!timerProvider.isRunning) {
            timerProvider.toggleTimer();
          }
        });
      },
      child: Scaffold(
        backgroundColor: homePageColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(50),
                child: SizedBox(
                  height: MediaQuery.of(context).size.shortestSide * 0.5,
                  width: MediaQuery.of(context).size.shortestSide * 0.5,
                  child: const Stack(
                    fit: StackFit.expand,
                    children: [
                      TimeIndicatorWidget(),
                      StudyBreakWidget(),
                    ],
                  ),
                ),
              ),
              const MediaButtons(),
              const TaskDropdownWidget(),
            ],
          ),
        ),
        floatingActionButton: _floatingActionButton(const Color.fromRGBO(242, 245, 234, 1), context),
      ),
    );
  }
}
Widget _floatingActionButton(Color floatingActionButtonColor, BuildContext context) {
  final taskProvider = Provider.of<TaskProvider>(context);
  final plannerProvider = Provider.of<PlannerProvider>(context);
  final timerProvider = Provider.of<TimerProvider>(context);
  return FloatingActionButton(
    backgroundColor: floatingActionButtonColor,
    child: homeIconForFloatingActionButton,
    onPressed: () async {
      if (!timerProvider.isRunning) {
        plannerProvider.resetPlanner();
        taskProvider.resetTask();
        Navigator.pop(context);
      }
    },
  );
}