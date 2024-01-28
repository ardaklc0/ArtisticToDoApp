import 'package:flutter/material.dart';

import '../ui/helper/common_variables.dart';
import '../ui/widgets/common_widgets.dart';
import '../ui/widgets/settings_widgets/notification_widgets.dart';
import '../ui/widgets/settings_widgets/slider_widgets.dart';
import '../ui/widgets/settings_widgets/switch_widgets.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homePageColor,
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TimeandRoundWidget(),
          NotificationSoundWidget(),
          SettingsNotificationSwitch(),
          AutoStartSwitch(),
        ],
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