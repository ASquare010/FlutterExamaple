import 'package:flutter/material.dart';
import 'package:flutter_app/BoardApp/SignInOrLogin/LogIn.dart';
import 'package:flutter_app/BoardApp/SignInOrLogin/SignUp.dart';

class Authenticate extends StatefulWidget {

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool logInScreen = true;

  void toggle() {
    setState(() => logInScreen = !logInScreen);
  }

  @override
  Widget build(BuildContext context) {
    return logInScreen
        ? LogIn(
            toggle: toggle,
          )
        : SignUp(
            toggle: toggle,
          );
  }
}
