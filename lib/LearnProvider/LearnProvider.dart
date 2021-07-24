import 'package:flutter/material.dart';
import 'package:flutter_app/LearnProvider/CounterClass.dart';
import 'package:flutter_app/LearnProvider/Screen/ScreenOne.dart';
import 'package:provider/provider.dart';

class StateChangeListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Counter(),
      child: MaterialApp(home: ScreenOne()),
    );
  }
}
