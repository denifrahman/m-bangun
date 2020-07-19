import 'package:apps/widget/Login/LoginWidget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: LoginWidget(
        primaryColor: Color(0xFFb16a085),
        backgroundColor: Colors.white,
        page: '/BottomNavBar',
      ),
    );
  }
}
