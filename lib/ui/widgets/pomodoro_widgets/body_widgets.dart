import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro2/ui/helper/common_variables.dart';
import 'package:pomodoro2/ui/styles/common_styles.dart';
import 'package:provider/provider.dart';
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
            }
          },
          icon: Icon(
            timerProvider.isRunning ? Icons.pause : Icons.play_arrow,
            size: 45.0,
          ),
        ),
        IconButton(
          onPressed: () {
            timerProvider.jumpNextRound();
            timerProvider.resetDateTime();
          },
          icon: const Icon(Icons.fast_forward, size: 30.0),
        ),
      ],
    );
  }
}

class RoundsWidget extends StatelessWidget {
  const RoundsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    return Text(
      timerProvider.currentRoundDisplay,
      style: Theme.of(context).textTheme.titleMedium,
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
    if (timerProvider.isRunning && !timerProvider.isBreakTime) {
      return Text("${timerProvider.currentTimeInSeconds} STUDY TIME RUNNING");
    } else if (timerProvider.isRunning && timerProvider.isBreakTime) {
      return Text("${timerProvider.currentTimeInSeconds} BREAK TIME RUNNING");
    } else if (!timerProvider.isRunning && !timerProvider.isBreakTime) {
      return Column(
        children: [
          Text("${timerProvider.maxTimeInSeconds - timerProvider.currentTimeInSeconds} STUDY TIME NOT RUNNING"),
          ElevatedButton(
            onPressed: () {
              DateFormat formatter = DateFormat.Hms();
              print("Now: ${formatter.format(timerProvider.currentDateTime)}");
              print("Start: ${formatter.format(timerProvider.currentDateTime.add(Duration(seconds: timerProvider.maxTimeInSeconds - timerProvider.currentTimeInSeconds)))}");
            },
            style: mainUiRaisedButtonStyle,
            child: Text("Save : ${timerProvider.isCancel}"),
          )
        ],
      );
    } else if (!timerProvider.isRunning && timerProvider.isBreakTime){
      return Text("${timerProvider.maxTimeInSeconds - timerProvider.currentTimeInSeconds} BREAK TIME NOT RUNNING");
    } return const Text("BOS");
  }
}