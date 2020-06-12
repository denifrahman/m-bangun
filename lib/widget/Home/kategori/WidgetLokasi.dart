import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/KotaM.dart';
import 'package:apps/models/ProvinsiM.dart';
import 'package:apps/provider/Api.dart';
import 'package:apps/widget/Home/kategori/WidgetSelectLokasi.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WidgetLokasi extends StatefulWidget {
  WidgetLokasi({Key key}) : super(key: key);
  @override
  _WidgetLokasiState createState() {
    return _WidgetLokasiState();
  }
}

class _WidgetLokasiState extends State<WidgetLokasi> {
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  String idKota;
  String idProvinsi;
  String namaProvinsi, namaKota, namaKecamatan;
  var dataKota = List<KotaM>();
  var dataProvinsi = List<ProvinsiM>();
  @override
  void initState() {
    super.initState();
    _getCurrentToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getCurrentToken() async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    _getCurrentLocation(token);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var kecamatan = namaKecamatan == null ? '' : namaKecamatan.toLowerCase();
    var kota = namaKota == null ? '' : namaKota.toLowerCase();
    var provinsi = namaProvinsi == null ? '' : namaProvinsi.toLowerCase();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
                width: 35,
                fit: BoxFit.fill,
                image: new AssetImage('assets/logo.png')),
            Container(
              width: 5,
            ),
            Text(
              'm-Bangun',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'SUNDAY',
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.place,
                  size: 15,
                  color: Colors.grey[600],
                ),
                Text(
                  'Lokasi Anda',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
//                  Container(
//                    height: 2,
//                  ),
            InkWell(
                onTap: () => _modalListKota(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        namaKecamatan == null
                            ? Container()
                            : Text(
                                namaKecamatan == null
                                    ? ''
                                    : '${kecamatan[0].toUpperCase()}${kecamatan.substring(1)}',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xffb16a085))),
                        namaKecamatan == null ? Container() : Text(', '),
                        namaKota == null
                            ? Container()
                            : Text(
                                namaKota == null
                                    ? ''
                                    : '${kota[0].toUpperCase()}${kota.substring(1)}',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xffb16a085))),
                      ],
                    ),
                    Text(
                        namaProvinsi == null
                            ? 'Pilih lokasi'
                            : '${provinsi[0].toUpperCase()}${provinsi.substring(1)}',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Color(0xffb16a085))),
                  ],
                ))
          ],
        )
      ],
    );
  }

  void _getCurrentLocation(token) async {
    String currentIdProvinsi =
        await LocalStorage.sharedInstance.readValue('idProvinsi');
    if (currentIdProvinsi == null) {
      print(currentIdProvinsi);
    } else {
      Api.getProvinsiById(token, currentIdProvinsi).then((value) {
        var result = json.decode(value.body);
        setState(() {
          namaProvinsi = result['data']['nama_propinsi'];
        });
      });
      String currentIdKota =
          await LocalStorage.sharedInstance.readValue('idKota');
      if (currentIdKota != 'null') {
        Api.getKotaById(token, currentIdKota).then((value) {
          var result = json.decode(value.body);
          setState(() {
            namaKota = result['data']['nama_kabkota'];
          });
        });
      } else {
        setState(() {
          namaKota = null;
        });
      }
      String currentIdKecamatan =
          await LocalStorage.sharedInstance.readValue('idKecamatan');
      if (currentIdKecamatan != 'null') {
        Api.getKecamatanById(token, currentIdKecamatan).then((value) {
          var result = json.decode(value.body);
          setState(() {
            namaKecamatan = result['data']['nama_kecamatan'];
          });
        });
      } else {
        setState(() {
          namaKecamatan = null;
        });
      }
    }
  }

  _modalListKota() async {
    String currentIdProvinsi =
        await LocalStorage.sharedInstance.readValue('idProvinsi');
    Navigator.push(
      context,
      SlideRightRoute(
          page: WidgetSelectLokasi(
        idProvinsi: currentIdProvinsi,
      )),
    ).then((value) {
      _getCurrentToken();
    });
  }
}