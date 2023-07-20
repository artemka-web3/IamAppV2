import 'package:flutter/material.dart';

class PageIndex extends ChangeNotifier {
  int index = 0;
  int lastVisitedPage = 0;

  void changeIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }

  void back() {
    final int helper = index;
    lastVisitedPage = index;
    index = helper;
    notifyListeners();
  }
}
