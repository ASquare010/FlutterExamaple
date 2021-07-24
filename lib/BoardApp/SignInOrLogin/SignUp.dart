import 'package:flutter/material.dart';
import 'package:flutter_app/AppTheme.dart';
import 'package:flutter_app/BoardApp/Services/Auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  final Function toggle;

  const SignUp({Key key, this.toggle}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthService authService = AuthService();
  final formKey = GlobalKey<FormState>();
  var seePass = false;
  String pass = '', validPass = '', email = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: midGrey,
            ),
          )
        : Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: midGrey,
              title: Text('User Sign Up'),
              actions: [
                ElevatedButton.icon(
                    onPressed: () {
                      widget.toggle();
                    },
                    label: Text('Log in Instead'),
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
              label: Text('Sign Up'),
              backgroundColor: midGrey,
              onPressed: () async {
                if (formKey.currentState.validate() == true) {
                  setState(() {
                    isLoading = true;
                  });
                  User result = await authService.signUpWithEmailPassword(email, pass);
                  setState(() {
                    isLoading = false;
                  });
                  if (result == null) {
                    print('AuthFailed');
                  }
                }
              },
            ),
            body: Container(
                margin: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 3,
                      ),
                      emailForm(),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: passwordForm(),
                      ),
                      passwordValidForm(),
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
        if (valid.length < 5) {
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

  Widget passwordValidForm() {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          validPass = value;
        });
      },
      validator: (valid) {
        if (pass != validPass) {
          return "Both Passwords must be same";
        } else {
          return null;
        }
      },
      obscureText: seePass,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        helperText: 'Check password',
        labelText: 'Confirm Password',
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
