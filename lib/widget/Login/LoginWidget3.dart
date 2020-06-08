import 'dart:async';
import 'dart:convert' show json;

import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/provider/Akun.dart';
import 'package:apps/provider/Auth.dart';
import 'package:apps/widget/DataDiri/DataDiri.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginWidget3 extends StatefulWidget {
  @override
  _LoginWidget3State createState() => new _LoginWidget3State();
}

class _LoginWidget3State extends State<LoginWidget3>
    with TickerProviderStateMixin {
  GoogleSignInAccount _currentUser;
  String _contactText;
  bool _saving = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  bool isLogin;

  @override
  void initState() {
    super.initState();
    _googleSignIn.signInSilently();
    _hadleChekSession();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
  }

  _hadleChekSession() {
    _googleSignIn.isSignedIn().then((val) {
      print(val);
      if (val) {
        if (_currentUser.email == null) {
          setState(() {
            _saving = false;
          });
        }
        ApiAuth.chekEmail(_currentUser.email).then((response) {
          var result = json.decode(response.body);
          if (result['meta']['status_message'] != true) {
            if (_currentUser.email != null) {
              Map data = {
                'akun_email': _currentUser.email,
                'akun_display': _currentUser.displayName,
                'akun_id': _currentUser.id
              };
              var body = json.encode(data);
              Akun.add(body).then((response) {
                var result = json.decode((response.body));
                print('respon add $result');
                if (result['meta']['success'] == true) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(pageBuilder: (BuildContext context,
                          Animation animation, Animation secondaryAnimation) {
                        return DataDiri();
                      }, transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                          Widget child) {
                        return new SlideTransition(
                          position: new Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      }),
                          (Route route) => false);
                  setState(() {
                    _saving = false;
                  });
                }
              });
            }
          } else {
            print(result['data']['akun_usia']);
            if (result['data']['akun_wa'] == '' ||
                result['data']['akun_wa'] == null ||
                result['data']['akun_usia'] == '' ||
                result['data']['akun_usia'] == null ||
                result['data']['kelurahan_id'] == '' ||
                result['data']['kelurahan_id'] == null ||
                result['data']['akun_nama_lengkap'] == '' ||
                result['data']['akun_nama_lengkap'] == null ||
                result['data']['akun_tanggal_lahir'] == '' ||
                result['data']['akun_tanggal_lahir'] == null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(pageBuilder: (BuildContext context,
                      Animation animation, Animation secondaryAnimation) {
                    return DataDiri();
                  }, transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return new SlideTransition(
                      position: new Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  }),
                      (Route route) => false);
              setState(() {
                _saving = false;
              });
            } else {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(pageBuilder: (BuildContext context,
                      Animation animation, Animation secondaryAnimation) {
                    return BottomAnimateBar();
                  }, transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return new SlideTransition(
                      position: new Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  }),
                      (Route route) => false);
              setState(() {
                _saving = false;
              });
            }
          }
        });
      }
      {
        setState(() {
          _saving = false;
        });
      }
    });
  }

  Widget HomePage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/cinta-rakyat.jpg'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 0.0),
            child: Center(
              child: new Image(
                  width: 200,
                  fit: BoxFit.fill,
                  image: new AssetImage('assets/logo.png')),
            ),
          ),
          Column(
            children: <Widget>[
              new Container(
                width: MediaQuery.of(context).size.width,
                margin:
                const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new FlatButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: Colors.red,
                        onPressed: () => {},
                        child: new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: new FlatButton(
                                  onPressed: () => _handleSignIn(),
                                  padding: EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 20.0,
                                  ),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "MASUK / DAFTAR",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  gotoLogin() {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  PageController _controller =
  new PageController(initialPage: 1, viewportFraction: 1.0);

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      _hadleChekSession();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _saving,
      child: Container(
          height: MediaQuery.of(context).size.height,
          child: PageView(
            controller: _controller,
            physics: new AlwaysScrollableScrollPhysics(),
            children: <Widget>[
//            SingleChildScrollView(child: LoginPage()),
              HomePage(),
//            SingleChildScrollView(child: SignupPage())
            ],
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}
