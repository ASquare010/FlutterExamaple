import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final double x;

  const Player({Key key, this.x}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(x, 1),
      child: Container(
        width: 50,
        height: 50,
        color: Colors.blue,
      ),
    );
  }
}
