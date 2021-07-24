import 'package:flutter/material.dart';
import 'package:flutter_app/AppTheme.dart';
import 'package:flutter_app/BoardApp/Services/Auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogIn extends StatefulWidget {
  final Function toggle;

  const LogIn({Key key, this.toggle}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  AuthService authService = AuthService();

  final formKey = GlobalKey<FormState>();
  var seePass = false;
  String pass = '', email = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: midGrey,
            ),
          )
        : Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: midGrey,
              title: Text('User Log In'),
              actions: [
                ElevatedButton.icon(
                    onPressed: () {
                      widget.toggle();
                    },
                    label: Text('Sign Up Instead'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    icon: Icon(FontAwesomeIcons.shekelSign)),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              splashColor: white,
              elevation: 0,
              icon: Icon(Icons.done),
              label: Text('Log In'),
              backgroundColor: midGrey,
              onPressed: () async {
                if (formKey.currentState.validate() == true) {
                  setState(() {
                    isLoading =true;
                  });
                  authService.logInWithEmailPassword(email, pass).then((result) {
                    setState(() {
                      isLoading = false;
                    });

                    if (result == null) {


                      print('AuthFailed');
                    }
                  });
                }
              },
            ),
            body: Container(
                margin: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      emailForm(),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: passwordForm(),
                      ),
                    ],
                  ),
                )),
          );
  }

  Widget emailForm() {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
      validator: (valid) {
        if (!valid.contains("@")) {
          return "Invalid Email";
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          helperText: 'YourEmail@mail.com',
          labelText: 'Email',
          prefixIcon: Icon(Icons.alternate_email),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }

  Widget passwordForm() {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          pass = value;
        });
      },
      validator: (valid) {
        if (valid.length < 6) {
          return "Password more then 4 Chr";
        } else {
          return null;
        }
      },
      obscureText: seePass,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          helperText: 'eg.password123',
          labelText: 'Password',
          prefixIcon: Icon(Icons.lock),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          suffixIcon: InkWell(
            child: seePass ? Icon(Icons.remove_red_eye) : Icon(Icons.remove_red_eye_outlined),
            onTap: () => setState(() => seePass = !seePass),
          )),
    );
  }
}
