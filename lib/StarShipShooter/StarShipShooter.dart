import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/StarShipShooter/BaseWidgets/Enemy.dart';
import 'package:flutter_app/StarShipShooter/BaseWidgets/Player.dart';

import 'BaseWidgets/Bullets.dart';

class StarShipShooter extends StatefulWidget {
  @override
  _StarShipShooterState createState() => _StarShipShooterState();
}

class _StarShipShooterState extends State<StarShipShooter> {
  double playerPosition = 0, enemyDy = 0, enemyDx = 0;
  GlobalKey<EnemyState> enemyKey = GlobalKey<EnemyState>();

  bool startGame = false, moveLeft = false;

  double enemyBallSize = 25;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Star Ship Shooter'),
        actions: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  enemyBallSize += 5;
                });
              },
              child: Text('a'))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Player(
                  x: playerPosition,
                ),Bullets()
                // Enemy(
                //   key: enemyKey,
                //   size: enemyBallSize,
                // ),
              ],
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
            min: -1,
            max: 1,
          ),
        ],
      ),
    );
  }
}
