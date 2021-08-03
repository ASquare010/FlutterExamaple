import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Enemy extends StatefulWidget {
  final double size;

  const Enemy({Key key, this.size = 25}) : super(key: key);

  @override
  EnemyState createState() => EnemyState();
}

class EnemyState extends State<Enemy> {
  double x = 0, y = 0;
  double velocityY = 1, speed = 0.04, ballTravel = 0;
  double tempY = -2;
  bool isLeft;

  @override
  void initState() {
    isLeft = Random().nextBool();
    ballTravel = double.parse(doubleInRange(0.5, -0.5).toStringAsFixed(2));
    print('ballTravel $ballTravel');
    start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(x, y),
      child: AnimatedContainer(
        width: widget.size,
        height: widget.size,
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
      ),
    );
  }

  void start() {
    Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {
        _jump();
      });
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
        print(ballTravel);
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
