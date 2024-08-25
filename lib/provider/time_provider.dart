import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pomodoro2/ui/helper/common_functions.dart';
import 'audio_provider.dart';
import 'auto_start_provider.dart';
import 'notification_provider.dart';
import 'slider_provider.dart';

class TimerProvider with ChangeNotifier {
  final SoundSelectionProvider _audioProvider = SoundSelectionProvider();
  late Timer _timer;
  static int _currentTimeInSeconds = 60;
  DateTime _currentDateTime = DateTime.now();
  bool _isRunning = false;
  bool _isCancel = false;
  TimerProvider() {
    resetTimer();
  }
  bool get isRunning => _isRunning;
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
      //WakelockPlus.enable();
      _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
      notifyListeners();
    } else {
      _timer.cancel();
      _isRunning = false;
      //WakelockPlus.disable();
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
      //WakelockPlus.disable();
      //WakelockPlus.enabled.then((value) => debugPrint('Wakelock disabled: $value'));
      notifyListeners();
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
}