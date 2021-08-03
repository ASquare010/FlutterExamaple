import 'package:flutter/material.dart';
import 'package:flutter_app/AppTheme.dart';

class Bullets extends StatelessWidget {
  const Bullets({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment(0, 0),
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
              Expanded(child: Container(
                color: Colors.brown[500],
              ))
            ],
          ),
        )
    );
  }
}
