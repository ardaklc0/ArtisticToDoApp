import 'package:flutter/material.dart';
import '../ui/helper/common_variables.dart';
import '../ui/widgets/common_widgets.dart';
import '../ui/widgets/pomodoro_widgets/appbar_widgets.dart';
import '../ui/widgets/pomodoro_widgets/body_widgets.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homePageColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
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
            const MediaButtons(),
            const TaskDropdownWidget(),
            const RoundsWidget(),
            const SettingsButton(),
          ],
        ),
      ),
      floatingActionButton: _floatingActionButton(const Color.fromRGBO(242, 245, 234, 1), context),
    );
  }
}
Widget _floatingActionButton(Color floatingActionButtonColor, BuildContext context) => FloatingActionButton(
  backgroundColor: floatingActionButtonColor,
  child: homeIconForFloatingActionButton,
  onPressed: () {
    Navigator.pop(context);
  },
);