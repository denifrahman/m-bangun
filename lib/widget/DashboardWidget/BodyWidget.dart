import 'dart:convert';
import 'package:apps/models/KeluargaM.dart';
import 'package:apps/models/StatusKesehatanM.dart';
import 'package:apps/provider/Auth.dart';
import 'package:apps/provider/Keluarga.dart';
import 'package:apps/provider/StatusKesehatan.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flushbar/flushbar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
//import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'YOUR_DEVICE_ID';

class BodyWidget extends StatefulWidget {
  const BodyWidget({
    Key key,
  }) : super(key: key);

  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
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
  GoogleSignInAccount _currentUser;
  final TextEditingController inputNamaLengkapController =
      new TextEditingController();
  final TextEditingController tanggalLahirController =
      new TextEditingController();
  String statusKesehatan;

  String kelurahanId;
  int usia;
  var dataHistory = new List<KeluargaM>();
  var dataMStatusKebutuhan = List<StatusKesehatanM>();
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.signInSilently();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
        _getAnggotaKeluarga(account.id);
      });
      print(_currentUser.email);
      getAkun(account.email);
      getStatusKesehatan();
//      FirebaseAdMob.instance
//          .initialize(appId: "ca-app-pub-4655963065602426~1945712030");
//      _interstitialAd?.dispose();
//      _interstitialAd = createInterstitialAd()..load();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//    _interstitialAd?.dispose();
  }

  getAkun(email) {
    ApiAuth.chekEmail(email).then((value) {
      var result = json.decode(value.body);
      setState(() {
        kelurahanId = result['data']['kelurahan_id'];
      });
    });
  }

  getStatusKesehatan() {
    StatusKesehatan.getAll().then((value) {
      var result = json.decode(value.body);
      Iterable list = result['data'];
      setState(() {
        dataMStatusKebutuhan =
            list.map((model) => StatusKesehatanM.fromMap(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(usia);
    return Container(
      height: MediaQuery.of(context).size.height / 2 + 70,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 4),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(0))),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Daftar Keluarga',
                        style: TextStyle(fontSize: 12),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              barrierColor: Colors.grey.withOpacity(0.7),
                              context: context,
                              builder: (builder) {
                                final format = DateFormat("yyyy-MM-dd");
                                return new Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.3,
                                    decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.only(
                                            topLeft:
                                                const Radius.circular(10.0),
                                            topRight:
                                                const Radius.circular(10.0))),
                                    child: Column(
                                      children: <Widget>[
                                        Center(
                                          child: Container(
                                            decoration: new BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    new BorderRadius.all(
                                                        const Radius.circular(
                                                            10.0))),
                                            width: 50,
                                            height: 10,
                                            margin: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Column(
                                              children: <Widget>[
                                                TextFormField(
                                                  controller:
                                                      inputNamaLengkapController,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                  validator: (String arg) {
                                                    if (arg.length < 1)
                                                      return 'Nama harus di isi';
                                                    else
                                                      return null;
                                                  },
                                                  decoration: InputDecoration(
                                                      labelText: "Nama Lengkap",
                                                      hasFloatingPlaceholder:
                                                          true),
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                      top: 10,
                                                    ),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Text(
                                                      'Tanggal Lahir',
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                      textAlign: TextAlign.left,
                                                    )),
                                                DateTimeField(
                                                  format: format,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      usia = calculateAge(val);
                                                    });
                                                  },
                                                  controller:
                                                      tanggalLahirController,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                  resetIcon: Icon(
                                                    Icons.clear,
                                                    size: 14,
                                                    color: Colors.red,
                                                  ),
                                                  onShowPicker:
                                                      (context, currentValue) {
                                                    return showDatePicker(
                                                        context: context,
                                                        firstDate:
                                                            DateTime(1900),
                                                        initialDate:
                                                            currentValue ??
                                                                DateTime.now(),
                                                        lastDate:
                                                            DateTime(2100));
                                                  },
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                      top: 10,
                                                    ),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Text(
                                                      'Status',
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                      textAlign: TextAlign.left,
                                                    )),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      10,
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    isDense: true,
                                                    hint: new Text(
                                                      "Pilih",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12),
                                                    ),
                                                    value: statusKesehatan,
                                                    onChanged:
                                                        (String newValue) {
                                                      setState(() {
                                                        statusKesehatan =
                                                            newValue;
                                                      });
                                                      _onchangeKebutuhan(
                                                          newValue);
                                                    },
                                                    items: dataMStatusKebutuhan
                                                        .map((StatusKesehatanM
                                                            item) {
                                                      return new DropdownMenuItem<
                                                          String>(
                                                        value: item.statusNama
                                                            .toString(),
                                                        child: new Text(
                                                          item.statusNama
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 23,
                                                ),
                                                RoundedLoadingButton(
                                                  child: Text('Simpan',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  color: Colors.red,
                                                  controller: _btnController,
                                                  onPressed: () =>
                                                      simpanKeluarga(),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                              });
                        },
                        icon: Icon(
                          FontAwesomeIcons.plusCircle,
                          color: Colors.orange,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.height / 2 + 6,
            padding: EdgeInsets.only(left: 5, right: 5),
            decoration: new BoxDecoration(
              color: Colors.white,
              //new Color.fromRGBO(255, 0, 0, 0.0),
              border: Border(
                left: BorderSide(width: 0.3, color: Colors.grey[300]),
                top: BorderSide(width: 0.3, color: Colors.grey[300]),
                right: BorderSide(width: 0.3, color: Colors.grey[300]),
              ),
            ),
            child: dataHistory == []
                ? Center(
                    child: LoadingDoubleFlipping.square(
                        size: 30, backgroundColor: Colors.red),
                  )
                : dataHistory.length == 0
                    ? Center(
                        child: Container(
                        height: 500,
                        width: 350,
                        child: EmptyListWidget(
                            image: null,
                            packageImage: PackageImage.Image_3,
                            title: 'Data kosong',
                            subTitle: '',
                            titleTextStyle: Theme.of(context)
                                .typography
                                .black
                                .display1
                                .copyWith(color: Color(0xff9da9c7)),
                            subtitleTextStyle: Theme.of(context)
                                .typography
                                .dense
                                .body2
                                .copyWith(color: Color(0xffabb8d6))),
                      ))
                    : ListView.builder(
                        padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                        itemCount: dataHistory.length,
                        itemBuilder: (context, index) {
                          var usia = dataHistory[index].tAnggotaKeluargaUsia;
                          var status =
                              dataHistory[index].tAnggotaKeluargaStatus;
                          return Column(
                            children: <Widget>[
                              Container(
                                child: ListTile(
                                  title: Text(
                                    dataHistory[index].tAnggotaKeluargaNama,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[700]),
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.date_range,
                                        color: Colors.amber,
                                        size: 12,
                                      ),
                                      Text(
                                        ' $usia tahun',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Container(
                                        width: 8,
                                      ),
                                      status == 'SEHAT'
                                          ? Icon(
                                              FontAwesomeIcons.checkCircle,
                                              size: 12,
                                              color: Colors.green,
                                            )
                                          : status == 'ODP'
                                              ? Icon(
                                                  FontAwesomeIcons.userNinja,
                                                  size: 12,
                                                  color: Colors.orange,
                                                )
                                              : status == 'PDP'
                                                  ? Icon(
                                                      FontAwesomeIcons
                                                          .shieldVirus,
                                                      size: 12,
                                                      color: Colors.deepOrange,
                                                    )
                                                  : Icon(
                                                      FontAwesomeIcons.viruses,
                                                      size: 12,
                                                      color: Colors.red,
                                                    ),
                                      Container(
                                        width: 5,
                                      ),
                                      RichText(
                                        overflow: TextOverflow.clip,
                                        maxLines: 1,
                                        softWrap: false,
                                        strutStyle: StrutStyle(fontSize: 12.0),
                                        text: TextSpan(
                                            style: TextStyle(
                                              color: Colors.grey[800],),
                                            text: '$status'),
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                barrierColor: Colors.grey
                                                    .withOpacity(0.7),
                                                context: context,
                                                builder: (builder) {
                                                  final format =
                                                      DateFormat("yyyy-MM-dd");
                                                  return new Container(
                                                      height: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height /
                                                          2.8,
                                                      decoration: new BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: new BorderRadius
                                                                  .only(
                                                              topLeft: const Radius
                                                                      .circular(
                                                                  10.0),
                                                              topRight: const Radius
                                                                      .circular(
                                                                  10.0))),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Center(
                                                            child: Container(
                                                              decoration: new BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  borderRadius: new BorderRadius
                                                                      .all(const Radius
                                                                          .circular(
                                                                      10.0))),
                                                              width: 50,
                                                              height: 10,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 10,
                                                                      bottom:
                                                                          5),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      18.0),
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    dataHistory[
                                                                            index]
                                                                        .tAnggotaKeluargaNama,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                  ),
                                                                  Container(
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                        top: 10,
                                                                      ),
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child:
                                                                          Text(
                                                                        'Setatus Kesehatan',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                      )),
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        10,
                                                                    child: DropdownButtonFormField<
                                                                        String>(
                                                                      isDense:
                                                                          true,
                                                                      hint:
                                                                          new Text(
                                                                        "Pilih Status Kesehatan",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize: 12),
                                                                      ),
                                                                      value: dataHistory[
                                                                              index]
                                                                          .tAnggotaKeluargaStatus,
                                                                      onChanged:
                                                                          (String
                                                                              newValue) {
                                                                        setState(
                                                                            () {
                                                                          statusKesehatan =
                                                                              newValue;
                                                                        });
                                                                        _onchangeKebutuhan(
                                                                            newValue);
                                                                      },
                                                                      items: dataMStatusKebutuhan.map(
                                                                          (StatusKesehatanM
                                                                              item) {
                                                                        return new DropdownMenuItem<
                                                                            String>(
                                                                          value: item
                                                                              .statusNama
                                                                              .toString(),
                                                                          child:
                                                                              new Text(
                                                                            item.statusNama.toString(),
                                                                            style:
                                                                                TextStyle(fontSize: 12),
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 23,
                                                                  ),
                                                                  RoundedLoadingButton(
                                                                    child: Text(
                                                                        'Simpan',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white)),
                                                                    controller:
                                                                        _btnController,
                                                                    color: Colors
                                                                        .red,
                                                                    onPressed: () =>
                                                                        editKeluarga(
                                                                            dataHistory[index].tAnggotaKeluargaId),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ));
                                                });
                                          },
                                          child: Icon(FontAwesomeIcons.edit,
                                              size: 20)),
                                      InkWell(
                                          onTap: () => _deleteKeluarga(
                                              dataHistory[index]
                                                  .tAnggotaKeluargaId),
                                          child: Icon(FontAwesomeIcons.trash,
                                              size: 20, color: Colors.red)),
                                    ],
                                  ),
                                  leading: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: new BoxDecoration(
                                          color:
                                              Colors.grey[200].withOpacity(0.8),
                                          //new Color.fromRGBO(255, 0, 0, 0.0),
                                          borderRadius: new BorderRadius.all(
                                              Radius.circular(40.0))),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Icon(Icons.perm_identity))),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Divider(),
                              )
                            ],
                          );
                        }),
          ),
        ],
      ),
    );
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

  _getAnggotaKeluarga(id) async {
    try {
      Keluarga.getAnggotaKeluarga(id).then((response) {
        Iterable list = json.decode(response.body)['data'];
        setState(() {
          dataHistory = list.map((model) => KeluargaM.fromMap(model)).toList();
        });
      });
    } catch (err) {
      print(err);
    }
  }

  void simpanKeluarga() {
    Map data = {
      't_anggota_keluarga_nama': inputNamaLengkapController.text,
      't_anggota_keluarga_tanggal_lahir': tanggalLahirController.text,
      't_anggota_keluarga_usia': usia,
      't_anggota_keluarga_status': statusKesehatan,
      'user_insert': _currentUser.id,
      'kelurahan_id': kelurahanId
    };
    _btnController.success();
    var body = json.encode(data);
    Keluarga.add(body).then((value) {
      var result = json.decode(value.body);
      if (result['meta']['success'] == true) {
        clear();
        _getAnggotaKeluarga(_currentUser.id);
        Navigator.of(context).pop(false);
//        _interstitialAd?.show();
      } else {
        clear();
        Navigator.of(context).pop(false);
        Flushbar(
          title: "Gagal",
          message: "Data gagal di tambah, pastikan data lengkap",
          duration: Duration(seconds: 15),
          backgroundColor: Colors.red,
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            FontAwesomeIcons.trash,
            color: Colors.white,
          ),
        )..show(context);
      }
    });
  }

  clear() {
    setState(() {
      inputNamaLengkapController.text = "";
      usia = 0;
      tanggalLahirController.text = '';
    });
  }

  void editKeluarga(id) {
    Map data = {
      't_anggota_keluarga_status': statusKesehatan,
      't_anggota_keluarga_id': id,
    };
    _btnController.success();
    var body = json.encode(data);
    Keluarga.edit(body).then((value) {
      var result = json.decode(value.body);
      if (result['meta']['success'] == true) {
        _getAnggotaKeluarga(_currentUser.id);
        Navigator.of(context).pop(false);
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
    Keluarga.delete(id).then((value) {
      var result = json.decode(value.body);
      print(result['meta']['success']);
      if (result['meta']['success'] == true) {
        Navigator.of(context).pop(false);
        _getAnggotaKeluarga(_currentUser.id);
//        _interstitialAd?.show();
      }
    });
  }

  void _onchangeKebutuhan(String newValue) {}
}
