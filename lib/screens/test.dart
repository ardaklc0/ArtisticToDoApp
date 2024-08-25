import 'package:flutter/material.dart';
import 'package:pomodoro2/provider/new_time_provider.dart';
class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  TestPageState createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
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