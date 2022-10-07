import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/homePage/home_navigator_screen.dart';

final logIn = ChangeNotifierProvider((ref) {
  return Auth();
});

class Auth extends ChangeNotifier {



  Auth(){
    fetchUser();
  }

  setLogin(email,pass,BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email,
          password: pass).then((value) {
        prefs.setString('token', value.user!.uid);
        prefs.setBool('is_logged', true);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeNavigator()),
                (route) => false);
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    notifyListeners();
  }
  setRegister(email,pass,BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      ).then((value) {
        prefs.setString('token', value.user!.uid);
        prefs.setBool('is_logged', true);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeNavigator()),
                (route) => false);
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');

      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
  String? _email;
  String? _uid;
  String? get email => _email ;
  String? get uid => _uid ;


  fetchUser(){
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _email = user.email.toString();
      _uid = user.uid.toString();
    }
  }

}
