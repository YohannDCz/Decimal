import 'package:flutter/material.dart';

class NavBar extends ChangeNotifier {
  NavBar({this.currentIndex = 0});

  int currentIndex;

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}