import 'package:flutter/cupertino.dart';

class PlayerDxDyNotifier extends ChangeNotifier {
  double currentOffsetVal = 0;

  double _newMin = -1, _newMax = 1;
  double _oldMin = 0, screenWidth;

  double sizeRatio = 0.1;
  double dy = 1;
  double n;

  PlayerDxDyNotifier({
    @required this.screenWidth,
  }) {
    sizeRatio = screenWidth * sizeRatio;
    n = ((((screenWidth * sizeRatio - _oldMin) * (_newMax - _newMin)) /
                (screenWidth - _oldMin)) +
            _newMin);
  }

  void setDx(double val) {
    currentOffsetVal = val;
    notifyListeners();
  }

  double get dx {
    // to scale offset val to alignment
    double x = (((currentOffsetVal - _oldMin) * (_newMax - _newMin)) /
            (screenWidth - _oldMin)) +
        _newMin;
    return x;
  }
}
