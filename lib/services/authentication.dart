import 'package:chat_app/modules/user.dart';
import 'package:chat_app/screens/dashboard.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _firebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //checking if user has already logged in
  handleAuth() {
    return StreamBuilder(
        stream: _auth.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Dashboard();
          } else {
            return LoginPage();
          }
        });
  }

//signing in user with firebase
  signwithEmailandPass(String email, String pass) async {
    try {
      AuthResult result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser fireUser = result.user;
      return _firebaseUser(fireUser);
    } catch (e) {
      print('error signing in' + e.toString());
    }
  }

//registering user with Firebase
  Future registerNewUser(String email, String pass, String username) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      FirebaseUser fireUser = result.user;
      DB().uploadUserInfo({'email': email, 'username': username});
      return _firebaseUser(fireUser);
    } catch (e) {
      print(e);
    }
  }

//password reset
  Future resetPass(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }

  //signing out
  Future sigOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
