import 'package:flutter/material.dart';
import 'package:flutter_app/StarShipShooter/NotifyListeners/BulletDyNotifier.dart';
import 'package:provider/provider.dart';
import 'NotifyListeners/CollisionDetection.dart';
import 'NotifyListeners/EnemyDyDxNotifier.dart';
import 'NotifyListeners/PlayerDxDyNotifier.dart';
import 'StarShipShooter.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BulletDyNotifier bullet = BulletDyNotifier();
    PlayerDxDyNotifier player = PlayerDxDyNotifier(
      screenWidth: MediaQuery.of(context).size.width,
    );
    EnemyDyDxNotifier enemy = EnemyDyDxNotifier(
      screenWidth: MediaQuery.of(context).size.width,
    );
    CollisionDetection playerEnemyCollide =
        CollisionDetection(enemy: enemy, player: player);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: bullet,
        ),
        ChangeNotifierProvider.value(
          value: player,
        ),
        ChangeNotifierProvider.value(
          value: playerEnemyCollide,
        ),
      ],
      child: StarShipShooter(),
    );
  }
}
