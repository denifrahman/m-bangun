import 'package:flutter/material.dart';
import 'package:apps/widget/Login/LoginWidget3.dart';

class LoginScreen3 extends StatefulWidget {
  LoginScreen3({Key key}) : super(key: key);

  @override
  _LoginScreen3State createState() {
    return _LoginScreen3State();
  }
}

class _LoginScreen3State extends State<LoginScreen3> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: LoginWidget3(),
      ),
    );
  }
}
