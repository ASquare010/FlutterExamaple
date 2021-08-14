import 'package:flutter/material.dart';
import 'package:flutter_app/StarShipShooter/NotifyListeners/PlayerDxDyNotifier.dart';
import 'package:provider/provider.dart';

class Player extends StatelessWidget {
  const Player({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlayerDxDyNotifier _dx = Provider.of<PlayerDxDyNotifier>(context);

    return GestureDetector(
      onPanUpdate: (val) {
        _dx.setDx(val.globalPosition.dx);
      },
      child: Align(
        alignment: Alignment(_dx.dx, _dx.dy),
        child: Container(
          width: _dx.sizeRatio,
          height: _dx.sizeRatio,
          color: Colors.blue,
        ),
      ),
    );
  }
}
