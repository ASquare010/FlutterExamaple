import 'package:flutter/material.dart';
import 'package:flutter_app/BoardApp/Home/Home.dart';
import 'package:provider/provider.dart';

import 'Services/Auth.dart';
import 'SignInOrLogin/Authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<User>(context);
    if (userData == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
