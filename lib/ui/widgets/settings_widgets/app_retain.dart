import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppRetainWidget extends StatelessWidget {
  const AppRetainWidget({super.key, required this.child});
  final Widget child;
  final _channel = const MethodChannel('com.example/app_retain');
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          if (Navigator.of(context).canPop()) {
            return true;
          } else {
            _channel.invokeMethod('sendToBackground');
            return false;
          }
        } else {
          return true;
        }
      },
      child: child,
    );
  }
}
