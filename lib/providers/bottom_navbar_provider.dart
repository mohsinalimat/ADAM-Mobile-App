import 'package:flutter/cupertino.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  // drawer toggle function
  TickerFuture toggleDrawer(AnimationController animationController) =>
      animationController.isCompleted
          ? animationController.reverse()
          : animationController.forward();
}
