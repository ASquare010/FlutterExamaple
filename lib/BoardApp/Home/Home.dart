import 'package:flutter/material.dart';
import 'package:flutter_app/AppTheme.dart';
import 'package:flutter_app/BoardApp/Services/Auth.dart';

import 'BoardList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: midGrey,
        actions: [
          IconButton(
            onPressed: AuthService().signOutAnonymously,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      // body: StreamProvider<List<Board>>.value(
      //   value: DataBase().board,
      //   initialData: [],
      //   child: BoardList(),
      // ),
      body: BoardList(),
    );
  }
}
