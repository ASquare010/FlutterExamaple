import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class EnemyDyDxNotifier extends ChangeNotifier{
  final double screenWidth;
  double x = 0, y = 0;
  double velocityY = 1, speed = 0.04, ballTravel = 0;
  double tempY = -2;
  bool isLeft;
  double sizeRatio = 0.1;
  double _newMin = -1, _newMax = 1;
  double _oldMin = 0;
  double n;

  EnemyDyDxNotifier({@required this.screenWidth}) {
    n = ((((screenWidth * sizeRatio - _oldMin) * (_newMax - _newMin)) /
                (screenWidth - _oldMin)) +
            _newMin) ;
    isLeft = Random().nextBool();
    ballTravel = double.parse(doubleInRange(0.5, -0.5).toStringAsFixed(2));
    start();
  }

  get getSize {
    return screenWidth * sizeRatio;
  }

  void setSize(double size) {
    this.sizeRatio = size;
  }

  void start() {
    Timer.periodic(Duration(milliseconds: 30), (timer) {
      _jump();
     });
  }

  void _jump() {
    //verticalMotion
    if (tempY <= y) {
      if (y < 1) {
        velocityY += speed;
        y = _equation(velocityY);
      } else if (y >= 1) {
        velocityY -= speed;
        tempY = y;

        if (ballTravel < 1) {
          ballTravel += 0.03;
        }
        y = _equation(velocityY);
      }
    } else if (tempY > y) {
      velocityY -= speed;
      tempY = y;
      y = _equation(velocityY);
    }
    // horizontalMotion
    if (x < 1 && x > -1) {
      if (isLeft) {
        x += 0.01;
      } else if (!isLeft) {
        x -= 0.01;
      }
    } else if (x >= 1) {
      isLeft = false;
      x -= 0.02;
    } else if (x <= -1) {
      isLeft = true;
      x += 0.02;
    }
  }

  double _equation(double x) {
    notifyListeners();
    double val =
        (0.5 * x * x) - x + double.parse(ballTravel.toStringAsFixed(2));
    if (val > 1)
      return 1;
    else
      return double.parse(val.toStringAsFixed(2));
  }

  double doubleInRange(num start, num end) =>
      Random().nextDouble() * (end - start) + start;
}
