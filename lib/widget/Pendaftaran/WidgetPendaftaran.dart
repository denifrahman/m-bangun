import 'package:apps/Utils/Component/ButtonFullWidth.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/screen/PhoneAuth/presentation/pages/firebase/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:intl/intl.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WidgetPendaftaran extends StatefulWidget {
  WidgetPendaftaran({Key key}) : super(key: key);

  @override
  _WidgetPendaftaranState createState() {
    return _WidgetPendaftaranState();
  }
}

class _WidgetPendaftaranState extends State<WidgetPendaftaran> {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String nama, email, no_hp, tempat_lahir, jenis_kelamin, password;
  DateTime selectedDate = DateTime.now();
  bool validEmail = false;
  bool validTelp = false;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    await new Future.delayed(const Duration(microseconds: 1));
    await Provider.of<BlocAuth>(context).checkSession();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: blocAuth.isLoading
          ? PKCardProfileSkeleton()
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidate: true,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          "Nama Lengkap",
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
                                initialValue: blocAuth.currentUserLogin['nama'] == null ? '' : blocAuth.currentUserLogin['nama'],
                                onSaved: (value) {
                                  setState(() {
                                    nama = value;
                                  });
                                },
                                keyboardType: TextInputType.text,
                                validator: (String arg) {
                                  if (arg.length < 1)
                                    return 'Nama Harus di isi';
                                  else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your name',
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
                                Icons.email,
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
                                initialValue: blocAuth.currentUserLogin['email'] == null ? '' : blocAuth.currentUserLogin['email'],
                                onSaved: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                                keyboardType: TextInputType.emailAddress,
                                validator: (String arg) {
                                  if (arg.length < 1)
                                    return 'Email harus di isi';
                                  else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Masukkan email anda',
                                  errorText: !validTelp ? null : 'Email sudah di gunakan',
                                  // hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          "No Telpon",
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
                                Icons.phone,
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
                                enabled: false,
                                initialValue: blocAuth.currentUserLogin['no_hp'] == null ? '' : blocAuth.currentUserLogin['no_hp'],
                                onSaved: (value) {
                                  setState(() {
                                    no_hp = value;
                                  });
                                },
                                keyboardType: TextInputType.phone,
                                validator: (String arg) {
                                  if (arg.length < 1)
                                    return 'Telpon Harus di isi';
                                  else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  focusColor: Colors.grey,
                                  fillColor: Colors.grey,
                                  hoverColor: Colors.grey,
                                  enabled: false,
                                  border: InputBorder.none,
                                  hintText: 'Enter your phone',
                                  errorText: !validTelp ? null : 'Telpon sudah di gunakan',
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
                          "Tanggal Lahir",
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
                                Icons.date_range,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: 30.0,
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.5),
                              margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                            ),
                            new Container(
                                child: FlatButton(
                                    onPressed: () async {
                                      final DateTime picked =
                                          await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(1980, 8), lastDate: DateTime(2101));
                                      if (picked != null && picked != selectedDate)
                                        setState(() {
                                          selectedDate = picked;
                                        });
                                    },
                                    child: Text(
                                      '${DateFormat('dd/MM/yyyy').format(blocAuth.currentUserLogin['tgl_lahir'] == null ? selectedDate : DateTime.parse(blocAuth.currentUserLogin['tgl_lahir'].toString()))}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
                                    )))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Jenis Kelamin",
                              style: TextStyle(color: Colors.grey, fontSize: 16.0),
                            ),
                            jenis_kelamin == null
                                ? Text(
                                    "Pilih Jenis Kelamin",
                                    style: TextStyle(color: jenis_kelamin == null ? Colors.red : Colors.grey, fontSize: 16.0),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: Column(
                          children: <Widget>[
                            GenderSelection(
                              femaleImage: NetworkImage("https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_female_user-512.png"),
                              maleImage: NetworkImage("https://icon-library.net/images/avatar-icon/avatar-icon-4.jpg"),
                              selectedGenderIconBackgroundColor: Colors.amber,
                              selectedGender: blocAuth.currentUserLogin['jenis_kelamin'] == null
                                  ? null
                                  : blocAuth.currentUserLogin['jenis_kelamin'].toString() == 'L'
                                      ? Gender.Male
                                      : Gender.Female,
                              femaleText: 'Perempuan',
                              onChanged: (value) {
                                if (value.toString() == "Gender.Male") {
                                  jenis_kelamin = "L";
                                } else if (value.toString() == "Gender.Female") {
                                  jenis_kelamin = "P";
                                }
                              },
                              maleText: 'Laki-laki',
                              selectedGenderTextStyle: TextStyle(color: Colors.amber, fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          "Tempat Lahir",
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
                                Icons.location_on,
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
                                initialValue: blocAuth.currentUserLogin['tempat_lahir'] == null ? '' : blocAuth.currentUserLogin['tempat_lahir'],
                                onSaved: (value) {
                                  setState(() {
                                    tempat_lahir = value;
                                  });
                                },
                                keyboardType: TextInputType.text,
                                validator: (String arg) {
                                  if (arg.length < 1)
                                    return 'Tempat Lahir Harus di isi';
                                  else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorText: !validEmail ? null : 'Tempat lahir harus di isi',
                                  hintText: 'Masukkan tempat lahir anda',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: ButtonFullWidth(
        title: 'Simpan',
        color: Color(0xFFb16a085),
        onPressed: () {
          _formKey.currentState.save();
          _simpan();
        },
        btnController: _btnController,
      ),
    );
  }

  _simpan() async {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    _formKey.currentState.validate();
    var map = new Map<String, String>();
    map['id'] = blocAuth.currentUserLogin['id'];
    map['nama'] = nama;
    map['email'] = email ?? blocAuth.currentUserLogin['email'];
    map['no_hp'] = no_hp;
    map['tempat_lahir'] = tempat_lahir;
    map['tgl_lahir'] = DateFormat('yyyy-MM-dd').format(selectedDate);
    map['jenis_kelamin'] = jenis_kelamin ?? blocAuth.currentUserLogin['jenis_kelamin'];
    if (_formKey.currentState.validate()) {
      if (jenis_kelamin != null || blocAuth.currentUserLogin['jenis_kelamin'] != null) {
        var response = await blocAuth.update(map);
        if (response['meta']['success']) {
          _btnController.success();
          _showToast(response['meta']['status_message'], Colors.green);
          await new Future.delayed(const Duration(seconds: 1));
          _btnController.reset();
        } else {
          _btnController.stop();
          _showToast(response['meta']['status_message'], Colors.red);
          await new Future.delayed(const Duration(seconds: 1));
          _btnController.reset();
        }
      } else {
        _btnController.reset();
      }
    } else {
      _btnController.reset();
    }
  }

  void _showToast(String message, Color color) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
      ),
    );
  }

  _openLogin(prop) {
    Navigator.pop(context, prop);
  }

  String validateEmail(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) return 'Format Email tidak valid';
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
