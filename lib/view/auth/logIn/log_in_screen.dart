import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskriverpod/view/homePage/home_navigator_screen.dart';
import 'package:taskriverpod/viewModel/loginVm.dart';

import '../signUp/sign_up_screen.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Consumer(
            builder: (context,ref,child) {
              final item = ref.watch(logIn);

              return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (value) =>
                          value!.isEmpty ? 'enter a valid email or Phone' : null,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      //This will obscure text dynamically
                      decoration: const InputDecoration(
                        labelText: 'Email or Phone',
                        // hintText: 'Enter your email or phone',
                        // Here is key idea
                        fillColor: Colors.white,
                        filled: true,
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      validator: (value) =>
                          value!.isEmpty ? 'enter a valid password' : null,
                      //This will obscure text dynamically
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        // hintText: 'Enter your password',
                        // Here is key idea

                        fillColor: Colors.white,
                        filled: true,

                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: size.width * .8,
                height: 50,
                child: ElevatedButton(
                  child: const Text('Log in'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // login();
                      item.setLogin(_emailController.text, _passwordController.text, context);
                      // SharedPreferences prefs = await SharedPreferences.getInstance();

                      // try {
                      //   final credential = await FirebaseAuth.instance
                      //       .signInWithEmailAndPassword(
                      //           email: _emailController.text,
                      //           password: _passwordController.text).then((value) {
                      //     prefs.setString('token', value.user!.uid);
                      //     prefs.setBool('is_logged', true);
                      //     Navigator.pushAndRemoveUntil(
                      //         context,
                      //         MaterialPageRoute(builder: (context) => HomeNavigator()),
                      //             (route) => false);
                      //   });
                      //
                      // } on FirebaseAuthException catch (e) {
                      //   if (e.code == 'user-not-found') {
                      //     print('No user found for that email.');
                      //   } else if (e.code == 'wrong-password') {
                      //     print('Wrong password provided for that user.');
                      //   }
                      // }
                    }
                  },
                ),
              ),
              SizedBox(
                height: size.height * .07,
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account? ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()));
                        },
                        child: const Text('Sign Up ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    ],
                  )),
            ],
      ),
    );
          }
        ));
  }
}
