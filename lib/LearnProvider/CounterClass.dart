import 'package:flutter/foundation.dart';

class Counter extends ChangeNotifier {
  int _count = 0;

  int get getVal => _count;

  void setVal(int value) {
    _count = value;
    notifyListeners();
  }
}
