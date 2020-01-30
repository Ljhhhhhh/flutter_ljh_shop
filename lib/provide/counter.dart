import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count = 0;
  int get value=> _count;

  increment() {
    _count++;
    notifyListeners();
  }
}