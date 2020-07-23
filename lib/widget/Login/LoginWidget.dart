import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/Api.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/PendaftaranScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginWidget extends StatefulWidget {
  final Color primaryColor;
  final Color backgroundColor;
  final String page;

  LoginWidget({Key key, this.primaryColor, this.backgroundColor, this.page});

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: widget.backgroundColor,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidate: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new ClipPath(
                clipper: MyClipper(),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: new Image(width: 100, fit: BoxFit.fill, image: new AssetImage('assets/logo.png')),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  "Email",
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    new Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      height: 30.0,
                      width: 1.0,
                      color: Colors.grey.withOpacity(0.5),
                      margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                    ),
                    new Expanded(
                      child: TextFormField(
                        focusNode: myFocusNodeEmailLogin,
                        validator: (val) {
                          if (val.length < 1)
                            return 'Silahkan masukkan email';
                          else
                            return null;
                        },
                        controller: loginEmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Masukkan email anda',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  "Password",
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    new Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                      child: Icon(
                        Icons.lock_open,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      height: 30.0,
                      width: 1.0,
                      color: Colors.grey.withOpacity(0.5),
                      margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                    ),
                    new Expanded(
                      child: TextFormField(
                        focusNode: myFocusNodePasswordLogin,
                        validator: (val) {
                          if (val.length < 1)
                            return 'Silahkan masukkan password';
                          else
                            return null;
                        },
                        controller: loginPasswordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Masukkan password anda.',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: RoundedLoadingButton(
                        child: Text('MASUK', style: TextStyle(color: Colors.white)),
                        color: Color(0xFFb16a085),
                        controller: _btnController,
                        onPressed: () => _login(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        color: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.only(left: 20.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Tidak punya akun ? daftar disini!",
                            style: TextStyle(color: this.widget.primaryColor),
                          ),
                        ),
                        onPressed: () => _openPendaftaranScreen(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _login() {
    var map = new Map<String, dynamic>();
    map['userpassword'] = loginPasswordController.text;
    map['useremail'] = loginEmailController.text;
    _formKey.currentState.validate();
    Api.login(map).then((value) async {
      var data = json.decode(value.body);
      print(data);
      if (data['status']) {
        _btnController.success();
        LocalStorage.sharedInstance.writeValue(key: 'session', value: json.encode(data));
        Navigator.popAndPushNamed(context, widget.page);
        Provider.of<DataProvider>(context).setLoading(true);
        Provider.of<DataProvider>(context).chekSession();
      } else {
        _btnController.error();
        _showToast(data['message']);
        await new Future.delayed(const Duration(seconds: 1));
        _btnController.reset();
      }
    });
  }

  void _showToast(String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
  }

  _openPendaftaranScreen() {
    Navigator.push(context, SlideRightRoute(page: PendaftaranScreen())).then((value) {
      print(value);
      if (value != null) {
        setState(() {
          loginEmailController.text = value['useremail'];
          loginPasswordController.text = value['userpassword'];
        });
      }
    });
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
