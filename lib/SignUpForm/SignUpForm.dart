import 'package:flutter/material.dart';

import '../AppTheme.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  /// keys are like objects which allows us to use functions of a assigned class and we can get a current state of widget.
  /// we can get like color of a container while app is running or alignment of container.
  /// kind of like
  /// var myClass = MyClass();
  ///  int studentStrength =  myClass.numberOfStudents;

  final formKey = GlobalKey<FormState>();
  var seePass = false;
  String pass,email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.done),
        label: Text('Done'),
        backgroundColor: midGrey,
        onPressed: () {
          /// THIS validate function will call both TextFieldForm receive ({validate : Functions}) which is passed as
          /// a parameter and if invalid error message automatically receive the returned string from the function
          if( formKey.currentState.validate() == true){
            /// this function is only invoked when all the TextFieldForm validate returns true because of if statement
         setState(() {
           formKey.currentState.save();
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
                Center(child: Text("Email is : $email Password is : $pass"))
              ],
            ),
          )),
    );
  }

  Widget emailForm() {
    return TextFormField(
      onSaved: (value){

            email= value  ;

      },
      validator: (valid) {
        ///
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
      onSaved: (value){

          pass= value  ;

      },
      validator: (valid) {
        if (valid.length <= 4) {
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
            onTap: () => setState(()=> seePass = !seePass),
          )
      ),
    );
  }

}
