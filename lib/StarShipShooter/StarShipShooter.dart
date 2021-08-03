import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/StarShipShooter/BaseWidgets/Enemy.dart';
import 'package:flutter_app/StarShipShooter/BaseWidgets/Player.dart';

class StarShipShooter extends StatefulWidget {
  @override
  _StarShipShooterState createState() => _StarShipShooterState();
}

class _StarShipShooterState extends State<StarShipShooter> {
  double playerPosition = 0,
      enemyDy = 0,
      enemyDx = 0;

  bool startGame = false;
  Size size = Size(0, 0);

  double velocity = 1,
      time = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Star Ship Shooter'),
        actions: [ElevatedButton(onPressed: start, child: Text('a'))],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.yellow,
              child: Stack(
                children: [
                  Player(
                    x: playerPosition,
                  ),
                  Enemy(
                    y: enemyDy,
                    // x: enemyDx,
                  )
                ],
              ),
            ),
          ),
          Slider(
            onChanged: (val) {
              setState(() {
                playerPosition = val;
              });
            },
            inactiveColor: Colors.blue,
            value: playerPosition,
            min: -size.width / 2,
            max: size.width / 2,
          ),
        ],
      ),
    );
  }

  void start() {
    print('ad');
    Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {
        _jump();
      });
    });
  }

  void _jump() {
    double temp = -2;
    double speed = 0.02;
    var equation = (0.5 * velocity * velocity) - velocity + 0.5;
    if (temp <= enemyDy) {
      if (enemyDy < 1) {
        velocity += speed;
        enemyDy = equation;
      } else if (enemyDy >= 1) {
        velocity -= speed;
        temp = enemyDy;
        enemyDy = equation;
        print(enemyDy);
      }
    } else if (temp > enemyDy) {
      velocity -= speed;
      temp = enemyDy;
      enemyDy = equation;
    }
  }
}
