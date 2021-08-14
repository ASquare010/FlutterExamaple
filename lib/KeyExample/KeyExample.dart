import 'package:flutter/material.dart';
import 'package:flutter_app/AppTheme.dart';

class KeyExample extends StatefulWidget {
  @override
  _KeyExampleState createState() => _KeyExampleState();
}

class _KeyExampleState extends State<KeyExample> {
  bool isRed = true;
  Offset offset = Offset.fromDirection(50);
  GlobalKey stickyKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (drag) {
        setState(() {
          offset = Offset(drag.globalPosition.dx, drag.globalPosition.dy);
          print(drag.globalPosition.dx);

          isRed =stickyKey.currentContext.size.contains(offset);
        });
      },
      child: Scaffold(
        body: Stack(
           children: [
            Column(
              children: [
                Expanded(
                    child: Container(
                  key: stickyKey,
                  color: Colors.purple,
                )),
                Expanded(
                    child: Container(
                  color: Colors.purpleAccent,
                ))
              ],
            ),
            Transform.translate(
              offset: offset,
              child: Container(
                color: isRed ? Colors.red : white,
                height: 100,
                width: 100,
              ),
            )
          ],
        ),
      ),
    );
  }

}
