import 'package:flutter/material.dart';

import '../ui/helper/common_variables.dart';
import '../ui/widgets/settings_widgets/notification_widgets.dart';
import '../ui/widgets/settings_widgets/slider_widgets.dart';
import '../ui/widgets/settings_widgets/switch_widgets.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: homePageColor,
      ),
      backgroundColor: homePageColor,
      body: const Padding(
        padding: EdgeInsets.all(15.0),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TimeandRoundWidget(),
                  NotificationSoundWidget(),
                  SettingsNotificationSwitch(),
                  SettingsDarkModeSwitch(),
                  AutoStartSwitch(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}