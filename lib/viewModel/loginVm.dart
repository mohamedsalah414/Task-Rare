import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/homePage/home_navigator_screen.dart';

final logIn = ChangeNotifierProvider((ref) {
  return Auth();
});

class Auth extends ChangeNotifier {
  Auth() {
    fetchUser();
  }

  setLogin(email, pass, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((value) {
        prefs.setString('token', value.user!.uid);
        prefs.setString('email', email.toString());
        prefs.setBool('is_logged', true);
        fetchUser();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeNavigator()),
            (route) => false);
      });
    } on FirebaseAuthException catch (e) {

      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: 'No user found for that email.',
          backgroundColor: Colors.red,
        );
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: 'Wrong password provided for that user.',
          backgroundColor: Colors.red,
        );
        debugPrint('Wrong password provided for that user.');
      }
      else {
        Fluttertoast.showToast(
          msg: e.code,
          backgroundColor: Colors.red,
        );
      }
    }
    notifyListeners();
  }

  setRegister(email, pass, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: pass,
      )
          .then((value) {
        prefs.setString('token', value.user!.uid);
        prefs.setString('email', email.toString());
        prefs.setBool('is_logged', true);
        fetchUser();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeNavigator()),
            (route) => false);
      });
    } on FirebaseAuthException catch (e) {

      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
          msg: 'The password provided is too weak.',
          backgroundColor: Colors.red,
        );
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: 'The account already exists for that email.',
          backgroundColor: Colors.red,
        );
        print('The account already exists for that email.');
      }
      else {
        Fluttertoast.showToast(
          msg: e.code,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  String? _email;
  String? _uid;

  String? get email => _email;

  String? get uid => _uid;

  fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _email = user.email.toString();
      _uid = user.uid.toString();
    } else {
      _email = prefs.getString('email');
    }
    notifyListeners();
  }

  logOut() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
