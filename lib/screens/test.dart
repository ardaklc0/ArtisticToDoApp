import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro2/provider/new_time_provider.dart';
import 'package:pomodoro2/provider/time_provider.dart';

import '../provider/audio_provider.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => new _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    NewTimerProvider newTimerProvider = NewTimerProvider();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              newTimerProvider.currentTimeDisplay,
              style: const TextStyle(fontSize: 30),
            ),
            ElevatedButton(onPressed: newTimerProvider.start, child: const Text('Start')),
            ElevatedButton(onPressed: newTimerProvider.stop, child: const Text('Stop')),
          ],
        ),
      ),
    );
  }
}