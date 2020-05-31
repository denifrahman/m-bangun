import 'dart:async';
import 'dart:convert';
import 'package:apps/models/KecamatanM.dart';
import 'package:apps/models/KelurahanM.dart';
import 'package:apps/models/KotaM.dart';
import 'package:apps/provider/Kecamatan.dart';
import 'package:apps/provider/Kelurahan.dart';
import 'package:apps/provider/Kota.dart';
import 'package:flushbar/flushbar.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:apps/Utils/BottomAnimation.dart';
import 'package:intl/intl.dart';
import 'package:apps/provider/Akun.dart';
import 'package:apps/provider/Auth.dart';
import 'package:apps/screen/LoginScreen3.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  List<dynamic> ProfileScreen = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = true;
  GoogleSignInAccount _currentUser;
  bool _saving = false;
  DateTime tanggalLahir;
  final TextEditingController tanggalLahirController =
      new TextEditingController();
  final TextEditingController inputNamaLengkapController =
      new TextEditingController();
  final TextEditingController inputUsiaController = new TextEditingController();
  final TextEditingController inputWaController = new TextEditingController();
  bool validTelp = false;
  Timer timer;
  String statusKesehatan;
  String idKota;
  var dataKota = new List<KotaM>();
  String idKecamatan;
  var dataKecamatan = new List<KecamatanM>();
  String idKelurahan;
  var dataKelurahan = new List<KelurahanM>();

  @override
  void initState() {
    super.initState();
    _getKota();
    _googleSignIn.signInSilently();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  getAkun(email) {
    ApiAuth.chekEmail(email).then((value) {
      var result = json.decode(value.body);
      print(result['data']);
      inputWaController.text = result['data']['akun_wa'];
      inputNamaLengkapController.text = result['data']['akun_nama_lengkap'];
      inputUsiaController.text = result['data']['akun_usia'];
      inputUsiaController.text = result['data']['akun_usia'];
      setState(() {
        statusKesehatan = result['data']['akun_status'];
      });
      tanggalLahirController.text =
          result['data']['akun_tanggal_lahir'].toString();
      setState(() {
        idKota = result['data']['id_kabkota'];
      });
      _getKecamatanById(idKota);
      setState(() {
        idKecamatan = result['data']['id_kecamatan'];
      });
      _getKelurahanById(idKecamatan);
      setState(() {
        idKelurahan = result['data']['kelurahan_id'];
      });
      print(result['data']['id_kabkota']);
    });
  }

  void _getKota() async {
    Kota.getAll().then((response) {
      var result = json.decode(response.body);
      if (result['meta']['success'] == true) {
        setState(() {
          Iterable list = result['data'];
          dataKota = list.map((model) => KotaM.fromMap(model)).toList();
          print(dataKota[1].namaKabkota);
        });
        getAkun(_currentUser.email);
      }
    });
  }

  void _getKecamatanById(id) async {
    Kecamatan.getAllById(id).then((response) {
      var result = json.decode(response.body);
      setState(() {
        Iterable list = result['data'];
        dataKecamatan = list.map((model) => KecamatanM.fromMap(model)).toList();
        print(dataKecamatan[1].namaKecamatan);
      });
    });
  }

  void _getKelurahanById(id) async {
    Kelurahan.getAllById(id).then((response) {
      var result = json.decode(response.body);
      setState(() {
        Iterable list = result['data'];
        dataKelurahan = list.map((model) => KelurahanM.fromMap(model)).toList();
        print(dataKelurahan[1].namaKelurahan);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Profile'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _handleSignOut(context),
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: _currentUser == null
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PKCardProfileSkeleton(
                isCircularImage: true,
                isBottomLinesActive: true,
              ),
            )
          : _saving
              ? Container(
                  padding: EdgeInsets.all(30),
                  child: Center(
                      child: LoadingDoubleFlipping.square(
                          size: 30, backgroundColor: Colors.red)),
                )
              : new Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: Container(
                      height: MediaQuery.of(context).size.height - 80,
                      padding: EdgeInsets.only(bottom: 10),
                      child: SingleChildScrollView(child: singUpCard())),
                ),
    );
  }

  Widget singUpCard() {
    final format = DateFormat("yyyy-MM-dd");
    print(inputNamaLengkapController.text);
    var screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 50),
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 20),
                  child: FittedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: ClipOval(
                              child: Image.network(
                                _currentUser.photoUrl ?? '',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: 15,
                          ),
                          Text(
                            _currentUser.displayName,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Text(_currentUser.email,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: inputNamaLengkapController,
                  style: TextStyle(fontSize: 12),
                  validator: (String arg) {
                    if (arg.length < 1)
                      return 'Nama harus di isi';
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Nama Lengkap", hasFloatingPlaceholder: true),
                ),
                SizedBox(
                  height: 15,
                ),
//                Container(
//                  height: 60,
//                  width: MediaQuery.of(context).size.width - 10,
//                  child: DropdownButtonFormField<String>(
//                    items: ["SEHAT", "ODP", "PDP", "POSITIF"]
//                        .map((label) => DropdownMenuItem(
//                              child:
//                                  Text(label, style: TextStyle(fontSize: 12)),
//                              value: label,
//                            ))
//                        .toList(),
//                    isDense: true,
//                    hint: new Text(
//                      "Pilih Status Kesehatan",
//                      style: TextStyle(color: Colors.grey, fontSize: 12),
//                    ),
//                    value: statusKesehatan,
//                    validator: (String arg) {
//                      if (arg.length == null ? 0 : arg.length < 1)
//                        return 'Silahkan pilih status ';
//                      else
//                        return null;
//                    },
//                    onChanged: (val) {
//                      setState(() {
//                        statusKesehatan = val;
//                      });
//                    },
//                  ),
//                ),
//                SizedBox(
//                  height: 10,
//                ),
                DateTimeField(
                  format: format,
                  controller: tanggalLahirController,
                  style: TextStyle(fontSize: 12),
                  resetIcon: Icon(
                    Icons.clear,
                    size: 14,
                    color: Colors.red,
                  ),
//                  onChanged: (val){
//                    inputUsiaController.text = calculateAge(val);
//                  },
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 10,
                  child: DropdownButtonFormField<String>(
                    validator: (String arg) {
                      if (arg.length == null ? 0 : arg.length < 1)
                        return 'Silahkan pilih kota';
                      else
                        return null;
                    },
//                    decoration: InputDecoration.collapsed(hintText: ''),
                    isDense: true,
                    hint: new Text(
                      "Pilih Kota",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    value: idKota,
                    onChanged: (String newValue) {
                      setState(() {
                        idKota = newValue;
                      });
                      _onchangeKota(newValue);
                    },
                    items: dataKota.map((KotaM item) {
                      return new DropdownMenuItem<String>(
                        value: item.idKabkota.toString(),
                        child: new Text(
                          item.namaKabkota.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 10,
                  child: DropdownButtonFormField<String>(
                    validator: (String arg) {
                      if (arg.length == null ? 0 : arg.length < 1)
                        return 'Pilih kecamatan';
                      else
                        return null;
                    },
//                    decoration: InputDecoration.collapsed(hintText: ''),
                    isDense: true,
                    hint: new Text(
                      "Pilih Kecamatan",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    value: idKecamatan,
                    onChanged: (String newValue) {
                      setState(() {
                        idKecamatan = newValue;
                      });
                      _onchangeKecamatan(newValue);
                    },
                    items: dataKecamatan.map((KecamatanM item) {
                      return new DropdownMenuItem<String>(
                        value: item.idKecamatan.toString(),
                        child: new Text(
                          item.namaKecamatan.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 10,
                  child: DropdownButtonFormField<String>(
//                    decoration: InputDecoration.collapsed(hintText: ''),
                    isDense: true,
                    hint: new Text(
                      "Pilih Kelurahan",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    value: idKelurahan,
                    onChanged: (String newValue) {
                      setState(() {
                        idKelurahan = newValue;
                      });
                      _onchangeKelurahan(newValue);
                    },
                    items: dataKelurahan.map((KelurahanM item) {
                      return new DropdownMenuItem<String>(
                        value: item.idKelurahan.toString(),
                        child: new Text(
                          item.namaKelurahan.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: inputWaController,
                  validator: validatePhone,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                      labelText: "No Wa / Telpon",
                      hasFloatingPlaceholder: true),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: inputUsiaController,
                  style: TextStyle(fontSize: 12),
                  validator: (String arg) {
                    if (arg.length < 1)
                      return '*';
                    else
                      return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Usia", hasFloatingPlaceholder: true),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      child: Text("Simpan"),
                      color: Colors.red,
                      textColor: Colors.white,
                      padding: EdgeInsets.only(
                          left: 110, right: 110, top: 15, bottom: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                        editData();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String validatePhone(String value) {
    RegExp regx = RegExp(r"^[0-9]*$", caseSensitive: false);
    if (value.length < 1)
      return 'Telpon harus di isi';
    else if (!regx.hasMatch(value))
      return 'Data harus angka';
    else
      return null;
  }

  void editData() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _saving = true;
      });
      Map data = {
        'akun_nama_lengkap': inputNamaLengkapController.text,
        'akun_tanggal_lahir': tanggalLahirController.text,
        'akun_wa': inputWaController.text,
        'akun_usia': inputUsiaController.text,
        'akun_email': _currentUser.email,
        'kelurahan_id': idKelurahan,
        'akun_status': statusKesehatan
      };
      var body = json.encode(data);
      Akun.edit(body).then((value) {
        var result = json.decode(value.body);
        if (result['meta']['success'] == true) {
          setState(() {
            _saving = false;
          });
          Flushbar(
            title: "Sukses",
            message: "Pembaruan data telah berhasil",
            duration: Duration(seconds: 15),
            backgroundColor: Colors.green,
            flushbarPosition: FlushbarPosition.TOP,
            icon: Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
          )..show(context);
        }
      });
    }
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  _handleSignOut(context) {
    print('keluar');
    _googleSignIn.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation animation, Animation secondaryAnimation) {
          return LoginScreen3();
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
  }

  void _onchangeKota(String newValue) {
    print(newValue);
    _getKecamatanById(newValue);
  }

  void _onchangeKecamatan(String newValue) {
    _getKelurahanById(newValue);
  }

  void _onchangeKelurahan(String newValue) {
    print(newValue);
    setState(() {
      idKelurahan = newValue;
    });
  }
}
