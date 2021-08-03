import 'package:flutter/material.dart';

class Enemy extends StatelessWidget {
  final double x, y,size;

  const Enemy({Key key, this.x = 0, this.y = 0,this.size = 25}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(x,y),
      child: AnimatedContainer(
        width: size,
        height: size,
        duration:  Duration(milliseconds: 200),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
      ),
    );
  }
}
