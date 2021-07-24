import 'package:flutter/material.dart';
import 'package:flutter_app/LearnProvider/CounterClass.dart';
import 'package:provider/provider.dart';

class ScreenTwo extends StatefulWidget {
  @override
  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    final Counter _counter = Provider.of<Counter>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Back to First Screen'),),
      body: Center(
        child: Text('Counter holds State  \n ${_counter.getVal}',textAlign: TextAlign.center,),
      ),
    );
  }
}
