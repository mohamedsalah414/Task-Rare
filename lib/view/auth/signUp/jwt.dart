//   void hs256() {
//     String token;
//
//     /* Sign */ {
//       // Create a json web token
//       final jwt = JWT(
//         {
//           'id': 123,
//           'email':_emailController.text,
//           'password' : _passwordController.text,
//           'server': {
//             'id': '3e4fc296',
//             'loc': 'euw-2',
//           }
//         },
//         issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
//       );
//
//       // Sign it
//       token = jwt.sign(SecretKey('secret passphrase'));
//
//       print('Signed token: $token\n');
//       // Signed token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIzLCJlbWFpbCI6ImRmZGYiLCJwYXNzd29yZCI6ImRmZGZkZiIsInNlcnZlciI6eyJpZCI6IjNlNGZjMjk2IiwibG9jIjoiZXV3LTIifSwiaWF0IjoxNjY1MDA0ODY0LCJpc3MiOiJodHRwczovL2dpdGh1Yi5jb20vam9uYXNyb3Vzc2VsL2RhcnRfanNvbndlYnRva2VuIn0.jOkdHT3NsdbIFB5_NpoFlJRQecG_m5l7JvWmgnHuoGQ
//     }
//
//     /* Verify */ {
//       try {
//         // Verify a token
//         final jwt = JWT.verify(token, SecretKey('secret passphrase'));
// // Payload: {id: 123, email: dfdf, password: dfdfdf, server: {id: 3e4fc296, loc: euw-2}, iat: 1665004864}
//         print('Payload: ${jwt.payload}');
//       } on JWTExpiredError {
//         print('jwt expired');
//       } on JWTError catch (ex) {
//         print(ex.message); // ex: invalid signature
//       }
//     }
//     Map<String, dynamic> payload = Jwt.parseJwt(token);
//     print('decoded ${payload}');
// //decoded {id: 123, email: dfdf, password: dfdfdf, server: {id: 3e4fc296, loc: euw-2}, iat: 1665004864, iss: https://github.com/jonasroussel/dart_jsonwebtoken}
//
//   }

// dart_jsonwebtoken