import 'dart:async';
import 'package:flutter/foundation.dart';
import 'audio_provider.dart';
import 'auto_start_provider.dart';
import 'notification_provider.dart';
import 'slider_provider.dart';

class TimerProvider with ChangeNotifier {
  final SoundSelectionProvider _audioProvider = SoundSelectionProvider();
  late Timer _timer;
  late int _currentTimeInSeconds;
  DateTime _currentDateTime = DateTime.now();
  bool _isRunning = false;
  bool _isBreakTime = false;
  int? _plannerId;
  String? _taskDescription;
  bool _isCancel = false;
  TimerProvider() {
    resetTimer();
  }
  bool get isRunning => _isRunning;
  bool get isBreakTime => _isBreakTime;
  bool get isCancel => _isCancel;
  int? get plannerId => _plannerId;
  String? get taskDescription => _taskDescription;
  int get currentTimeInSeconds => _currentTimeInSeconds;
  DateTime get currentDateTime => _currentDateTime;
  int get maxTimeInSeconds => SliderProvider.studyDurationSliderValue * 60;
  bool get isEqual => currentTimeInSeconds == maxTimeInSeconds;
  String get currentTimeDisplay {
    int minutes = _currentTimeInSeconds ~/ 60;
    int seconds = _currentTimeInSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
  void setPlannerId(int value) {
    _plannerId = value;
    notifyListeners();
  }
  void setTaskDescription(String value) {
    _taskDescription = value;
    notifyListeners();
  }
  void toggleTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
      notifyListeners();
    } else {
      _timer.cancel();
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
  void _updateTimer(Timer timer) {
    if (_currentTimeInSeconds > 0) {
      _currentTimeInSeconds--;
      notifyListeners();
    } else {
      _timer.cancel(); // previous timer
      _isRunning = false;
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