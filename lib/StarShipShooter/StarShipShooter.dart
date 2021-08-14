import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/StarShipShooter/BaseWidgets/Bullets.dart';
import 'package:flutter_app/StarShipShooter/BaseWidgets/Enemy.dart';
import 'package:flutter_app/StarShipShooter/BaseWidgets/Player.dart';

class StarShipShooter extends StatefulWidget {
  @override
  _StarShipShooterState createState() => _StarShipShooterState();
}

class _StarShipShooterState extends State<StarShipShooter> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Star Ship Shooter'),
      ),
      body: Stack(
        children: [
          Player(),
          Bullets(),
          Enemy(),
         ],
      ),
    );
  }
}
