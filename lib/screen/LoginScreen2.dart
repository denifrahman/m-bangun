import 'package:apps/widget/Login/LoginWidget.dart';
import 'package:flutter/material.dart';

class LoginScreen2 extends StatelessWidget {
  LoginScreen2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: LoginWidget(
          primaryColor: Color(0xFF4aa0d5),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}