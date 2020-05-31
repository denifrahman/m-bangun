import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:apps/models/KebutuhanM.dart';
import 'package:apps/models/MKebutuhanM.dart';
import 'package:apps/provider/Kebutuhan.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
//import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'YOUR_DEVICE_ID';

class KebutuhanScreen extends StatefulWidget {
  @override
  _KebutuhanScreenState createState() => _KebutuhanScreenState();
}

class _KebutuhanScreenState extends State<KebutuhanScreen> {
//  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//    testDevices: testDevice != null ? <String>[testDevice] : null,
//    keywords: <String>['foo', 'bar'],
//    contentUrl: 'http://foo.com/bar.html',
//    childDirected: true,
//    nonPersonalizedAds: true,
//  );
//  InterstitialAd _interstitialAd;
//
//  InterstitialAd createInterstitialAd() {
//    return InterstitialAd(
//      adUnitId: 'ca-app-pub-4655963065602426/6814895332',
//      targetingInfo: targetingInfo,
//      listener: (MobileAdEvent event) {
//        print("InterstitialAd event $event");
//      },
//    );
//  }

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  var dataKebutuhan = List<KebutuhanM>();
  var dataMKebutuhan = List<MKebutuhanM>();
  GoogleSignInAccount _currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  String idKebutuhan;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    FirebaseAdMob.instance
//        .initialize(appId: "ca-app-pub-4655963065602426~1945712030");
//    _interstitialAd?.dispose();
//    _interstitialAd = createInterstitialAd()..load();
    _googleSignIn.signInSilently();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      _getKebutuhanById(account.id);
      _getAllKebutuhan();
    });
  }

  _getKebutuhanById(AkunId) {
    Kebutuhan.getByidAkun(AkunId).then((value) {
      var result = json.decode(value.body);
      Iterable list = result['data'];
      setState(() {
        dataKebutuhan = list.map((model) => KebutuhanM.fromMap(model)).toList();
      });
    });
  }

  _getAllKebutuhan() {
    Kebutuhan.getAll().then((value) {
      var result = json.decode(value.body);
      Iterable list = result['data'];
      setState(() {
        dataMKebutuhan =
            list.map((model) => MKebutuhanM.fromMap(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          elevation: 0,
          title: Text('Kebutuhan'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_circle,
                color: Colors.orange,
              ),
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.grey.withOpacity(0.7),
                    context: context,
                    builder: (builder) {
                      return new Container(
                          height: MediaQuery.of(context).size.height / 2.8,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(10.0),
                                  topRight: const Radius.circular(10.0))),
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  decoration: new BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: new BorderRadius.all(
                                          const Radius.circular(10.0))),
                                  width: 50,
                                  height: 10,
                                  margin: EdgeInsets.only(top: 10, bottom: 0),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                10,
                                        child: DropdownButtonFormField<String>(
                                          isDense: true,
                                          hint: new Text(
                                            "Pilih Kebutuhan",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                          value: idKebutuhan,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              idKebutuhan = newValue;
                                            });
                                            _onchangeKebutuhan(newValue);
                                          },
                                          items: dataMKebutuhan
                                              .map((MKebutuhanM item) {
                                            return new DropdownMenuItem<String>(
                                              value:
                                                  item.kebutuhanId.toString(),
                                              child: new Text(
                                                item.kebutuhanNama.toString(),
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      RoundedLoadingButton(
                                        child: Text('Simpan',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: Colors.red,
                                        controller: _btnController,
                                        onPressed: () => _addKebutuhan(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ));
                    });
              },
            )
          ],
        ),
        body: ListView.builder(
            padding: EdgeInsets.only(top: 5),
            itemCount: dataKebutuhan.length,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(dataKebutuhan[index].kebutuhanNama),
                      leading: Text(
                        (index + 1).toString(),
                        textAlign: TextAlign.center,
                      ),
                      trailing: IconButton(
                        onPressed: () => _deleteKeluarga(
                            dataKebutuhan[index].detailKebutuhanId),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    )
                  ],
                ),
              );
            }));
  }

  _addKebutuhan() {
    Map data = {'m_kebutuhan_id': idKebutuhan, 'm_akun_id': _currentUser.id};
    var body = json.encode(data);
    _btnController.success();
    Kebutuhan.add(body).then((value) {
      var result = json.decode(value.body);
      if (result['meta']['success'] == true) {
        Navigator.of(context).pop(false);
        _getKebutuhanById(_currentUser.id);
//        _interstitialAd?.show();
      }
    });
  }

  Future<bool> _deleteKeluarga(id) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus data!'),
        content: Text('Apakah anda ingin menghapus data ?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Tidak'),
          ),
          FlatButton(
            onPressed: () => _delete(id),
            /*Navigator.of(context).pop(true)*/
            child: Text('Ya'),
          ),
        ],
      ),
    );
  }

  _delete(id) {
    Kebutuhan.delete(id).then((value) {
      var result = json.decode(value.body);
      print(result['meta']['success']);
      if (result['meta']['success'] == true) {
        Navigator.of(context).pop(false);
        Flushbar(
          title: "Sukses",
          message: "Data berhasil di hapus",
          duration: Duration(seconds: 15),
          backgroundColor: Colors.red,
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            FontAwesomeIcons.trash,
            color: Colors.white,
          ),
        )..show(context);
        _getKebutuhanById(_currentUser.id);
//        _interstitialAd?.show();
      }
    });
  }

  void _onchangeKebutuhan(String newValue) {
    setState(() {
      idKebutuhan = newValue;
    });
  }
}
