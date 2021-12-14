//import 'dart:io';
//import 'package:flutter_easyloading/flutter_easyloading.dart';
//import 'package:paymantApp/constant.dart';
//
//import '../authentication_service.dart';
//import '../services/media_service.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_icons/flutter_icons.dart';
//import 'package:provider/provider.dart';
//import '../authentication_service.dart';
//
//class SignUp extends StatefulWidget {
//  @override
//  _SignUpState createState() => _SignUpState();
//}
//
//class _SignUpState extends State<SignUp> {
//  //AuthProvider authProvider;
//
//  String _email;
//  String _name;
//  double _deviceHeight;
//  double _deviceWidth;
//  File _image;
//  String _password;
//
//  @override
//  Widget build(BuildContext context) {
//    _deviceHeight = MediaQuery.of(context).size.height;
//    _deviceWidth = MediaQuery.of(context).size.width;
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.stretch,
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        Text(
//          "Sign up with",
//          style: TextStyle(
//            fontSize: 16,
//            color: textColor,
//            height: 2,
//          ),
//        ),
//
//        Row(
//          children: [
//            Text(
//              "Paymant App",
//              style: TextStyle(
//                fontSize: 25,
//                fontWeight: FontWeight.bold,
//                color: textColor,
//                letterSpacing: 2,
//                height: 1,
//              ),
//            ),
//            SizedBox(
//              width: 20,
//            ),
//            _imageSelectorWidget(),
//          ],
//        ),
//        SizedBox(
//          height: 11,
//        ),
//        TextField(
//          style: TextStyle(
//            color: textColor,
//          ),
//          onChanged: (value) {
//            setState(() {
//              _name = value;
//            });
//          },
//          decoration: InputDecoration(
//            hintText: 'Full Name',
//            hintStyle: TextStyle(
//              fontSize: 16,
//              color: hintTextColor,
//              fontWeight: FontWeight.bold,
//            ),
//            border: OutlineInputBorder(
//              borderRadius: BorderRadius.circular(25),
//              borderSide: BorderSide(
//                width: 0,
//                style: BorderStyle.none,
//              ),
//            ),
//            filled: true,
//            fillColor: colorWhite,
//            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//          ),
//        ),
//
//        SizedBox(
//          height: 16,
//        ),
//
//        TextField(
//          style: TextStyle(
//            color: textColor,
//          ),
//          onChanged: (value) {
//            setState(() {
//              _email = value;
//            });
//          },
//          decoration: InputDecoration(
//            hintText: 'Enter Email / Username',
//            hintStyle: TextStyle(
//              fontSize: 16,
//              color: hintTextColor,
//              fontWeight: FontWeight.bold,
//            ),
//            border: OutlineInputBorder(
//              borderRadius: BorderRadius.circular(25),
//              borderSide: BorderSide(
//                width: 0,
//                style: BorderStyle.none,
//              ),
//            ),
//            filled: true,
//            fillColor: colorWhite,
//            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//          ),
//        ),
//
//        SizedBox(
//          height: 16,
//        ),
//
//        TextField(
//          style: TextStyle(
//            color: textColor,
//          ),
//          obscureText: true,
//          onChanged: (value) {
//            setState(() {
//              _password = value;
//            });
//          },
//          decoration: InputDecoration(
//            hintText: 'Password',
//            hintStyle: TextStyle(
//              fontSize: 16,
//              color: hintTextColor,
//              fontWeight: FontWeight.bold,
//            ),
//            border: OutlineInputBorder(
//              borderRadius: BorderRadius.circular(25),
//              borderSide: BorderSide(
//                width: 0,
//                style: BorderStyle.none,
//              ),
//            ),
//            filled: true,
//            fillColor: colorWhite,
//            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//          ),
//        ),
//
//        SizedBox(
//          height: 24,
//        ),
//
//        Container(
//          height: 40,
//          decoration: BoxDecoration(
//            color: colorGreen,
//            borderRadius: BorderRadius.all(
//              Radius.circular(25),
//            ),
//            boxShadow: [
//              BoxShadow(
//                color: colorGreen.withOpacity(0.2),
//                spreadRadius: 3,
//                blurRadius: 4,
//                offset: Offset(0, 3),
//              ),
//            ],
//          ),
//          child: GestureDetector(
//            onTap: ()  {
//
//              context.read<AuthenticationService>().signUp(
//                  email: _email.trim(),
//                  password: _password.trim(),
//                  name: _name.trim(),
//                  image: _image);
//
//            },
//            child: Center(
//              child: Text(
//                "SIGN UP",
//                style: TextStyle(
//                  fontSize: 24,
//                  fontWeight: FontWeight.bold,
//                  color: offWhite,
//                ),
//              ),
//            ),
//          ),
//        ),
//
//        SizedBox(
//          height: 24,
//        ),
//
////
//      ],
//    );
//  }
//
//  Widget _imageSelectorWidget() {
//    return Align(
//      alignment: Alignment.center,
//      child: GestureDetector(
//        onTap: () async {
//          File _imageFile = await MediaService.instance.getImageFromLibrary();
//          setState(() {
//            _image = _imageFile;
//          });
//        },
//        child: Container(
//          height: _deviceHeight * 0.12,
//          width: _deviceHeight * 0.12,
//          decoration: BoxDecoration(
//            color: Colors.transparent,
//            borderRadius: BorderRadius.circular(500),
//            image: DecorationImage(
//              fit: BoxFit.cover,
//              image: _image != null
//                  ? FileImage(_image)
//                  : NetworkImage(
//                      "https://cdn0.iconfinder.com/data/icons/occupation-002/64/programmer-programming-occupation-avatar-512.png"),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
