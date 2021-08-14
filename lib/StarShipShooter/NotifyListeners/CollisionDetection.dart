import 'dart:async';
import 'package:flutter/material.dart';
import 'EnemyDyDxNotifier.dart';
import 'PlayerDxDyNotifier.dart';

class CollisionDetection extends ChangeNotifier {
  final EnemyDyDxNotifier enemy;
  final PlayerDxDyNotifier player;

  CollisionDetection({this.enemy, this.player}) {
    detectionCollision();
  }

  bool didCollide = false;

  void detectionCollision() {
    Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (player.dx < enemy.x + enemy.n &&
          player.dx + player.n > enemy.x &&
          player.dy < enemy.y + enemy.n &&
          player.dy + player.n > enemy.y) {
        didCollide = true;
        print('true collided');
        notifyListeners();
      } else {
        didCollide = false;
        print('false collided');

        notifyListeners();
      }
    });
  }

// final collide = (position1.dx < position2.dx + size2.width &&
//     position1.dx + size1.width > position2.dx &&
//     position1.dy < position2.dy + size2.height &&
//     position1.dy + size1.height > position2.dy);

}
