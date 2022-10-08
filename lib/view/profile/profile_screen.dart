import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskriverpod/viewModel/loginVm.dart';

import '../auth/logIn/log_in_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final auth = ref.watch(logIn);
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      auth.email!,
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    var prefs = await SharedPreferences.getInstance();
                    auth.logOut().then((value) {
                      prefs.clear();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LogInPage()),
                          (route) => false);
                    });
                  },
                  child: const Text('Log Out',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),))
            ],
          ),
        ),
      );
    });
  }
}
