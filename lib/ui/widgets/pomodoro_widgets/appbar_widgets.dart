import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/time_provider.dart';
import '../../../screens/settings.dart';


class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    final deviceHeight = MediaQuery.of(context).size.height;
    void navigateSettingsPage() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const SettingsPage(),
      ));
    }

    return IconButton(
      onPressed: timerProvider.isEqual ? navigateSettingsPage : null,
      icon: Icon(
          Icons.settings,
        size: deviceHeight * 0.04,
      ),
    );
  }
}