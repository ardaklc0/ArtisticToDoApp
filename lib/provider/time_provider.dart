import 'dart:async';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:pomodoro2/ui/helper/common_functions.dart';
import 'audio_provider.dart';
import 'auto_start_provider.dart';
import 'notification_provider.dart';
import 'slider_provider.dart';

class TimerProvider with ChangeNotifier {
  final SoundSelectionProvider _audioProvider = SoundSelectionProvider();
  late Timer _timer;
  static late int _currentTimeInSeconds;
  DateTime _currentDateTime = DateTime.now();
  bool _isRunning = false;
  bool _isBreakTime = false;
  bool _isCancel = false;
  Isolate? _isolate;
  final receivePort = ReceivePort();
  TimerProvider() {
    resetTimer();
  }
  Isolate? get isolate => _isolate;
  bool get isRunning => _isRunning;
  bool get isBreakTime => _isBreakTime;
  bool get isCancel => _isCancel;
  static int get currentTimeInSeconds => _currentTimeInSeconds;
  DateTime get currentDateTime => _currentDateTime;
  int get maxTimeInSeconds => SliderProvider.studyDurationSliderValue * 60;
  bool get isEqual => currentTimeInSeconds == maxTimeInSeconds;
  String get currentTimeDisplay {
    int minutes = _currentTimeInSeconds ~/ 60;
    int seconds = _currentTimeInSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
  void toggleTimer() {
    if (!_isRunning) {
      _isRunning = true;
      start();
      notifyListeners();
    } else {
      stop();
      _isRunning = false;
      notifyListeners();
    }
  }
  void cancelState() {
    if (!isRunning) {
      if (maxTimeInSeconds - currentTimeInSeconds >= 10) {
        _isCancel = true;
        notifyListeners();
      } else {
        _isCancel = false;
        notifyListeners();
      }
    } else {
      _timer.cancel();
      _isRunning = false;
      notifyListeners();
    }
  }
  Future<void> _updateTimer(Timer timer) async {
    if (_currentTimeInSeconds > 0) {
      _currentTimeInSeconds--;
      notifyListeners();
    } else {
      _timer.cancel(); // previous timer
      _isRunning = false;
      await saveWorkedMinutes();
      if (AutoStartProvider.autoStart == false) {
        _timer.cancel(); // next timer
        _isRunning = false;
        notifyListeners();
      }
      if (NotificationProvider.isActive) {
        _audioProvider.playSelectedAudio();
      }
      resetTimer();
    }
  }
  void resetTimer() {
    _currentTimeInSeconds = maxTimeInSeconds;
    _currentDateTime = DateTime.now();
    notifyListeners();
  }
  void resetDateTime() {
    _currentDateTime = DateTime.now();
    notifyListeners();
  }

  void stop() {
    receivePort.close();
    _isolate!.kill(priority: Isolate.immediate);
  }
  Future<void> start() async {
    Map map = {
      'port': receivePort.sendPort,
      'initial_duration': maxTimeInSeconds,
    };

    _isolate = await Isolate.spawn(_entryPoint, map);
    receivePort.sendPort.send(maxTimeInSeconds);
  }
  static void _entryPoint(Map map) async {
    int initialTime = map['initial_duration'];
    SendPort port = map['port'];
    _currentTimeInSeconds = initialTime;
    Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timer.tick == initialTime) {
          timer.cancel();
          port.send(timer.tick);
          port.send('Timer finished');
        } else {
          print(timer.tick);
          _currentTimeInSeconds --;
          port.send(timer.tick);
        }
      },
    );
  }
}