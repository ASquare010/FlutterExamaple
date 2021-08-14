import 'package:flutter/material.dart';
import 'package:flutter_app/StarShipShooter/NotifyListeners/EnemyDyDxNotifier.dart';

class Enemy extends StatelessWidget {
  final Color colors;

  const Enemy({Key key, this.colors = Colors.red}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EnemyDyDxNotifier _dYdX =
        EnemyDyDxNotifier(screenWidth: MediaQuery.of(context).size.width);

    return Align(
      alignment: Alignment(_dYdX.x, _dYdX.y),
      child: AnimatedContainer(
        width: _dYdX.getSize,
        height: _dYdX.getSize,
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors,
        ),
      ),
    );
  }
}
