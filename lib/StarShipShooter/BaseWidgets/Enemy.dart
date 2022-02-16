import 'package:flutter/material.dart';
import 'package:flutter_app/StarShipShooter/NotifyListeners/EnemyDyDxNotifier.dart';
import 'package:provider/provider.dart';

class Enemy extends StatelessWidget {
  final Color colors;

  const Enemy({Key key, this.colors = Colors.amber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EnemyDyDxNotifier loc = Provider.of<EnemyDyDxNotifier>(context);

    return Align(
      alignment: Alignment(loc.x, loc.y),
      child: AnimatedContainer(
        width: loc.getSize,
        height: loc.getSize,
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors,
        ),
      ),
    );
  }
}
