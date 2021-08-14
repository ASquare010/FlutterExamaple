import 'package:flutter/material.dart';
import 'package:flutter_app/AppTheme.dart';
import 'package:flutter_app/StarShipShooter/NotifyListeners/BulletDyNotifier.dart';
import 'package:flutter_app/StarShipShooter/NotifyListeners/PlayerDxDyNotifier.dart';
import 'package:provider/provider.dart';

class Bullets extends StatefulWidget {
  @override
  _BulletsState createState() => _BulletsState();
}

class _BulletsState extends State<Bullets> {
  int x = 0;
  double temp = 0;

  @override
  Widget build(BuildContext context) {
    final BulletDyNotifier _dy = Provider.of<BulletDyNotifier>(context);
    final PlayerDxDyNotifier _dx = Provider.of<PlayerDxDyNotifier>(context);
    if (_dy.y == 1) {
      temp = _dx.dx;
    }
    return Align(
        alignment: Alignment(temp, _dy.y),
        child: Container(
          height: 10,
          width: 5,
          decoration: BoxDecoration(
              color: yellow,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            children: [
              Spacer(
                flex: 3,
              ),
              Expanded(
                  child: Container(
                color: Colors.brown[500],
              ))
            ],
          ),
        ));
  }
}
