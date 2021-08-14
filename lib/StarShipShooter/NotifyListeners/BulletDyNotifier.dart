import 'dart:async';
import 'package:flutter/material.dart';

class BulletDyNotifier extends ChangeNotifier {
  double y = 1;
   BulletDyNotifier() {
     start();
  }

  void start() {
    Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (y > -1) {
        y -= 0.2;
        notifyListeners();
       } else {
        y = 1;
        notifyListeners();
      }
    });
  }
}
