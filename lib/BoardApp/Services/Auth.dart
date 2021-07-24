import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/BoardApp/Services/DataBase.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// to change fireUse to Our user obj
  User _userFromFireBaseUser(user) {
    return user != null ? User(userId: user.uid) : null;
  }

  Stream<User> get stream {
    return _auth.authStateChanges().map(_userFromFireBaseUser);
    /// line 11 is equal to line 14 is to convert fireUser to our custom user obj
    // return _auth.authStateChanges().map((event) => _userFromFireBaseUser(event));
  }

// signInWithEmailPassword user function
  Future signUpWithEmailPassword(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      //To create a now document for the new user in fireStore
      await DataBase(uid: result.user.uid).updateUserData(
          title: 'new User',
          description: 'first time using this app',
          imageLink:
              'https://www.hp.com/us-en/shop/app/assets/images/uploads/prod/25-best-hd-wallpapers-laptops159561982840438.jpgj',
          price: 1.0);
      return _userFromFireBaseUser(result.user.uid);
    } catch (e) {
      print('error Creating User ${e.toString()}');
      return null;
    }
  }

  Future logInWithEmailPassword(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFireBaseUser(result.user.uid);
    } catch (e) {
      print('error Creating User ${e.toString()}');
      return null;
    }
  }

// SignOutInAnonymously user function
  Future signOutAnonymously() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

class User {
  User({this.userId});

  final String userId;
}
