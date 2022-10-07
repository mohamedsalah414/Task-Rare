import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:taskriverpod/view/homePage/home_navigator_screen.dart';

import '../../../viewModel/loginVm.dart';
import '../logIn/log_in_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  void hs256() {
    String token;

    /* Sign */ {
      // Create a json web token
      final jwt = JWT(
        {
          'id': 123,
          'email':_emailController.text,
          'password' : _passwordController.text,
          'server': {
            'id': '3e4fc296',
            'loc': 'euw-2',
          }
        },
        issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
      );

      // Sign it
      token = jwt.sign(SecretKey('secret passphrase'));

      print('Signed token: $token\n');
      // Signed token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIzLCJlbWFpbCI6ImRmZGYiLCJwYXNzd29yZCI6ImRmZGZkZiIsInNlcnZlciI6eyJpZCI6IjNlNGZjMjk2IiwibG9jIjoiZXV3LTIifSwiaWF0IjoxNjY1MDA0ODY0LCJpc3MiOiJodHRwczovL2dpdGh1Yi5jb20vam9uYXNyb3Vzc2VsL2RhcnRfanNvbndlYnRva2VuIn0.jOkdHT3NsdbIFB5_NpoFlJRQecG_m5l7JvWmgnHuoGQ
    }

    /* Verify */ {
      try {
        // Verify a token
        final jwt = JWT.verify(token, SecretKey('secret passphrase'));
// Payload: {id: 123, email: dfdf, password: dfdfdf, server: {id: 3e4fc296, loc: euw-2}, iat: 1665004864}
        print('Payload: ${jwt.payload}');
      } on JWTExpiredError {
        print('jwt expired');
      } on JWTError catch (ex) {
        print(ex.message); // ex: invalid signature
      }
    }
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    print('decoded ${payload}');
//decoded {id: 123, email: dfdf, password: dfdfdf, server: {id: 3e4fc296, loc: euw-2}, iat: 1665004864, iss: https://github.com/jonasroussel/dart_jsonwebtoken}

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Consumer(
            builder: (context,ref,child) {
              final item = ref.watch(logIn);
            return Center(
                child: SingleChildScrollView(
      padding: EdgeInsets.all(15),
      child: Column(children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) =>
                        value!.isEmpty ? 'enter a valid email' : null,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    //This will obscure text dynamically

                    decoration: InputDecoration(
                      labelText: 'Email',

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
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      // hintText: 'Enter your password',
                      // Here is key idea

                      fillColor: Colors.white,
                      filled: true,

                      labelStyle: TextStyle(
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
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: size.width,
                    height: 50,
                    child: ElevatedButton(
                      child: const Text(
                        'Create Company Account',
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          item.setRegister(_emailController.text, _passwordController.text, context);
                          // register();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         HomePage()
                          //   ),
                          // );
                          // try {
                          //   final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          //     email: _emailController.text,
                          //     password: _passwordController.text,
                          //   );
                          //   print(credential.user!.uid);
                          //   print(credential.credential);
                          // } on FirebaseAuthException catch (e) {
                          //   if (e.code == 'weak-password') {
                          //     print('The password provided is too weak.');
                          //   } else if (e.code == 'email-already-in-use') {
                          //     print('The account already exists for that email.');
                          //
                          //   }
                          // } catch (e) {
                          //   print(e);
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
                            const Text('Already have an account?',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LogInPage()),
                                    (route) => false);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => const LogInPage()));
                              },
                              child: const Text('Login',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )
                          ])),
                ],
              ),
            ),
      ]),
    ));
          }
        ));
  }
}
