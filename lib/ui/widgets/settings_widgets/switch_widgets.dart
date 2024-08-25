import 'package:flutter/material.dart';
import 'package:pomodoro2/ui/helper/common_variables.dart';
import 'package:provider/provider.dart';
import '../../../provider/auto_start_provider.dart';
import '../../../provider/notification_provider.dart';
class AutoStartSwitch extends StatelessWidget {
  const AutoStartSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final autoStartProvider = Provider.of<AutoStartProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(242, 245, 234, 1),
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 1),
            blurRadius: 2.0,
            spreadRadius: 0.05,
          ),
        ],
      ),
      child: SwitchListTile(
        activeColor: homePageColor,
        title: const Text('Autostart'),
        value: AutoStartProvider.autoStart,
        onChanged: (value) {
          value = !value;
          autoStartProvider.switchMode();
        },
      ),
    );
  }
}

class SettingsNotificationSwitch extends StatelessWidget {
  const SettingsNotificationSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(242, 245, 234, 1),
          borderRadius: BorderRadius.circular(0.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 1),
              blurRadius: 2.0,
              spreadRadius: 0.05,
            ),
          ],
        ),
        child: SwitchListTile(
          activeColor: homePageColor,
          title: const Text('Notifications'),
          value: NotificationProvider.isActive,
          onChanged: (value) {
            value = !value;
            notificationProvider.switchMode();
          },
        ),
      ),
    );
  }
}