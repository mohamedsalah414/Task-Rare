import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskriverpod/view/auth/logIn/log_in_screen.dart';

import '../homePage/home_navigator_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => navigate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: LottieBuilder.asset(
              'assets/json/welcome.json',
            ),
          ),
        ),
      ),
    );
  }

  navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var logged = prefs.getBool('is_logged') ?? false;
    if (logged) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const HomeNavigator()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const LogInPage()));
    }
  }
}
