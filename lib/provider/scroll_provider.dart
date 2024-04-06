import 'package:flutter/cupertino.dart';

class ScrollProvider extends ChangeNotifier {
  ScrollController _scrollController = ScrollController(initialScrollOffset: 0.0);

  ScrollController get scrollController => _scrollController;

  ScrollProvider() {
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}