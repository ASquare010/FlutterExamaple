import 'package:flutter/material.dart';
import 'package:flutter_app/LearnProvider/CounterClass.dart';
import 'package:flutter_app/LearnProvider/Screen/ScreenTwo.dart';
import 'package:provider/provider.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key key}) : super(key: key);

  @override
  _ScreenOneState createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  final Duration _duration = Duration(milliseconds: 150);
  int value = 0;

  @override
  Widget build(BuildContext context) {
    final Counter _counter = Provider.of<Counter>(context);

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenTwo())),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Next Screen'),
          ),
        ),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            _counter.setVal(value++);
          },
          child: AnimatedContainer(
            duration: _duration,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10, right: 10, top: val(_counter) ? 10 : 50),
            child: val(_counter)
                ? Center(child: Text('Counter ${_counter.getVal}'))
                : Icon(
                    Icons.title,
                    color: Colors.blue,
                  ),
          ),
        ),
      ),
    );
  }

  bool val(Counter counter) {
    if (counter.getVal % 2 == 0) {
      return true;
    } else
      return false;
  }
}
