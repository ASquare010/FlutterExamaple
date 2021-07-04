import 'package:flutter/material.dart';
import 'package:flutter_app/NetWorkCall/NetWorkCallTwo.dart';
import 'NetWorkCall/NetWorkCall.dart';
import 'SignUpForm/SignUpForm.dart';
import 'TipCalculater/TipCalculate.dart';
import 'TrueFalseQuizApp/TrueFalseQuizApp.dart';
import 'WeatherForecast/WeatherForecast.dart';

// This widget is the root of your application.
void main() {
  runApp(MaterialApp(
    // theme: ThemeData(backgroundColor: blue,brightness: Brightness.dark,splashColor: blue,cursorColor: blue,textTheme: TextTheme(headline: TextStyle(color: white))),
    home: ScreenSelect(),
  ));
}

// Select Example To Text
class ScreenSelect extends StatelessWidget {
  final List<Widget> screen = <Widget>[
    NetWorkCalling(),
    SignUpForm(),
    TipCalculate(),
    TrueFalseQuizApp(),
    NetWorkCallTwo(),
    WeatherForecast()
  ];
  final List<String> screenName = [
    'NetWorkCalling',
    'SignUpForm',
    'TipCalculate',
    'TrueFalseQuizApp',
    'NetWorkCallTwo',
    'WeatherForecast'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select A Screen'),
      ),
      body: ListView.builder(
        itemCount: screen.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen[index])),
          title: Text(screenName[index]),
          trailing: Icon(Icons.arrow_forward_ios_rounded),
        ),
      ),
    );
  }
}