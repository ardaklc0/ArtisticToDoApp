import 'dart:async';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'audio_provider.dart';
import 'slider_provider.dart';

class NewTimerProvider with ChangeNotifier {
  final SoundSelectionProvider _audioProvider = SoundSelectionProvider();
  int _currentTimeInSeconds = 0;
  DateTime _currentDateTime = DateTime.now();
  bool _isRunning = false;
  final bool _isCancel = false;
  late Isolate? _isolate;
  String notification = "";
  late ReceivePort _receivePort;

  NewTimerProvider() {
    resetTimer();
  }

  bool get isRunning => _isRunning;
  bool get isCancel => _isCancel;
  int get currentTimeInSeconds => _currentTimeInSeconds;
  DateTime get currentDateTime => _currentDateTime;
  int get maxTimeInSeconds => SliderProvider.studyDurationSliderValue * 60;
  bool get isEqual => currentTimeInSeconds == maxTimeInSeconds;
  String get currentTimeDisplay {
    int minutes = _currentTimeInSeconds ~/ 60;
    int seconds = _currentTimeInSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void start() async {
    _currentTimeInSeconds = maxTimeInSeconds;
    _isRunning = true;
    notifyListeners();
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(
      _checkTimer,
      [_receivePort.sendPort, currentTimeInSeconds], // Pass arguments as a list
    );
    _receivePort.listen(_handleMessage, onDone:() {
    });
  }

  static void _checkTimer(List arguments) async {
    SendPort sendPort = arguments[0];
    int currentTimeInSeconds = arguments[1]; // Access currentTimeInSeconds directly

    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      currentTimeInSeconds--;
      if (currentTimeInSeconds == 0) {
        t.cancel();
        sendPort.send('notification 0');
      } else {
        String msg = 'notification $currentTimeInSeconds';
        debugPrint('SEND: $msg');
        sendPort.send(msg);
      }
    });
  }
  void _handleMessage(dynamic data) {
    debugPrint("RECEIVED: $data");
    notification = data;
    notifyListeners();
    if (data == 'notification 0') {
      stop();
    }
  }
  void stop() {
    _isRunning = false;
    notification = '';
    notifyListeners();
    _receivePort.close();
    _isolate!.kill(priority: Isolate.immediate);
    _isolate = null;
    _audioProvider.playSelectedAudio();
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