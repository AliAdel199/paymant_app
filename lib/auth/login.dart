
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import '../constant.dart';

import '../authentication_service.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
      // '169784826667-fd252el0rfd2ph8r19qqq2dnvrkei8rh.apps.googleusercontent.com',
    ],
  );
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Welcome to",
          style: TextStyle(
            fontSize: 16,
            color: textColor,
            height: 2,
          ),
        ),
        Text(
          "Paymant App",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: textColor,
            letterSpacing: 2,
            height: 1,
          ),
        ),
        Text(
          "Please login to continue",
          style: TextStyle(
            fontSize: 16,
            color: textColor,
            height: 1,
          ),
        ),
       const SizedBox(
          height: 16,
        ),
        Image.asset("images/abc.png"),
        const SizedBox(
          height: 16,
        ),
        const  SizedBox(
          height: 24,
        ),
        Container(
          height: 55,
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius:const BorderRadius.all(
              Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: colorGreen.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () async {
              context.read<AuthenticationService>().signInWithGoogle();

//
            },
//
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/google.png",
                    height: 35,
                    color: offWhite,
                  ),
                  const  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Login With Google",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: offWhite,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
