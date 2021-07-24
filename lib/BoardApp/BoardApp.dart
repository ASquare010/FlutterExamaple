import 'package:flutter/material.dart';
import 'package:flutter_app/BoardApp/Services/Auth.dart';
import 'package:provider/provider.dart';
import 'Wrapper.dart';

class BoardApp extends StatefulWidget {
  @override
  _BoardAppState createState() => _BoardAppState();
}

class _BoardAppState extends State<BoardApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: User(),
      value: AuthService().stream,
      child: Wrapper(),
    );
  }
}
