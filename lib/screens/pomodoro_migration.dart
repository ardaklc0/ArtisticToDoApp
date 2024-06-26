import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro2/ui/widgets/settings_widgets/app_retain.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../provider/audio_provider.dart';
import '../provider/planner_provider.dart';
import '../provider/task_provider.dart';
import '../provider/time_provider.dart';
import '../ui/helper/common_variables.dart';
import '../ui/widgets/common_widgets.dart';
import '../ui/widgets/pomodoro_widgets/body_widgets.dart';

class CountDownTimerPage extends StatefulWidget {
  const CountDownTimerPage({Key? key,}) : super(key: key);
  @override
  _CountDownTimerPageState createState() => _CountDownTimerPageState();
}
class _CountDownTimerPageState extends State<CountDownTimerPage> {
  final CountdownController _controller = CountdownController(autoStart: false);
  @override
  Widget build(BuildContext context) {
    final TimerProvider timerProvider = Provider.of<TimerProvider>(context);
    final PlannerProvider plannerProvider = Provider.of<PlannerProvider>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        timerProvider.toggleTimer();
        bool received = await dialogBuilder(context);
        if (received) {
          timerProvider.resetTimer();
          if (!context.mounted) return;
          //WakelockPlus.disable();
          //WakelockPlus.enabled.then((value) => debugPrint('POP SCOPE WAKELOCK: $value'));
          Navigator.pop(context);
        } else {
          timerProvider.toggleTimer();
          //WakelockPlus.enabled.then((value) => debugPrint('POP SCOPE WAKELOCK: $value'));
        }
      },
      child: Scaffold(
        backgroundColor: homePageColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 500),
            offset: timerProvider.isRunning ? const Offset(0, 0.25) : const Offset(0, 0.15),
            curve: Curves.easeInOut,
            child: Column(
              children: <Widget>[
                const Text("Migration"),
                Countdown(
                  controller: _controller,
                  seconds: TimerProvider.currentTimeInSeconds,
                  build: (_, double time) {
                    return Padding(
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
                        ],
                      ),
                    );
                  },
                  interval: const Duration(milliseconds: 100),
                  onFinished: () async {
                  },
                ),
                const MediaButtons(),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  reverseDuration: const Duration(milliseconds: 500),
                  child: (plannerProvider.plannerId != null) ? const TaskDropdownWidget() : const PlannerChooserWidget(),
                ),
              ],
            ),
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

  return AnimatedSlide(
    curve: Curves.easeInOut,
    offset: timerProvider.isRunning ? const Offset(0, 10) : const Offset(0, 0),
    duration: const Duration(milliseconds: 300),
    child: FloatingActionButton(
      backgroundColor: floatingActionButtonColor,
      child: homeIconForFloatingActionButton,
      onPressed: () async {
        if (!timerProvider.isRunning) {
          plannerProvider.resetPlanner();
          taskProvider.resetTask();
          Navigator.pop(context);
        }
      },
    ),
  );
}
