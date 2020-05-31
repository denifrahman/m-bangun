import 'dart:convert';

import 'package:apps/provider/Auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apps/screen/InboxScreen.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  GoogleSignInAccount _currentUser;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  String namaLengkap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.signInSilently();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      getAkun(account.email);
    });
  }

  getAkun(email) {
    ApiAuth.chekEmail(email).then((value) {
      var result = json.decode(value.body);
      setState(() {
        namaLengkap = result['data']['akun_nama_lengkap'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _currentUser == null
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: PKCardProfileSkeleton(
              isCircularImage: true,
              isBottomLinesActive: true,
            ),
          )
        : Container(
            height: MediaQuery.of(context).size.height / 2 - 80,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                image: DecorationImage(
                    colorFilter: ColorFilter.srgbToLinearGamma(),
                    image: AssetImage("assets/cinta-rakyat.jpg"),
                    fit: BoxFit.cover)
//        gradient: new LinearGradient(
//            colors: [Colors.white, Colors.red],
//            begin: const FractionalOffset(0.0, 0.2),
//            end: const FractionalOffset(1.0, 0.0),
//            stops: [0.0, 1.0],
//            tileMode: TileMode.clamp),
                ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: FittedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: ClipOval(
                              child: Image.network(
                                _currentUser.photoUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: 15,
                          ),
                          Text(
                            namaLengkap ?? 'wait ...',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(_currentUser.email,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  _inbox() {
    Navigator.of(context).push(PageRouteTransition(
        animationType: AnimationType.slide_up,
        builder: (context) => InboxScreen()));
  }

  _search() {}
}
