import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/KecamatanM.dart';
import 'package:apps/models/KotaM.dart';
import 'package:apps/models/ProvinsiM.dart';
import 'package:apps/provider/Api.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WidgetSelectLokasi extends StatefulWidget {
  final String idProvinsi;

  WidgetSelectLokasi({Key key, this.idProvinsi}) : super(key: key);

  @override
  _WidgetSelectLokasiState createState() {
    return _WidgetSelectLokasiState();
  }
}

class _WidgetSelectLokasiState extends State<WidgetSelectLokasi> {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  String idKota;
  String idProvinsi;
  String idKecamatan;
  String namaProvinsi,namaKota,namaKecamatan;
  var dataKota = List<KotaM>();
  var dataProvinsi = List<ProvinsiM>();
  var dataKecamatan = List<KecamatanM>();
  @override
  void initState() {
    super.initState();
    _getCurrentToken();
    print(widget.idProvinsi);
  }

  @override
  void dispose() {
    super.dispose();
  }
  void _getAllProvinsi(token) async{
    Api.getAllProvinsi(token).then((value){
      var result = json.decode(value.body);
      Iterable list = result['data'];
      setState(() {
        dataProvinsi =
            list.map((model) => ProvinsiM.fromMap(model)).toList();
      });
//      _getCurrentProvinsi(token);
    });
  }
  void _getAllKecamatanByIdKota(token) async{
    Api.getAllKecamatanByIdKota(token, idKota).then((value){
      var result = json.decode(value.body);
      Iterable list = result['data'];
      setState(() {
        dataKecamatan =
            list.map((model) => KecamatanM.fromMap(model)).toList();
      });
//      _getCurrentProvinsi(token);
    });
  }
  void _getCurrentToken() async{
    String token = await LocalStorage.sharedInstance.readValue('token');
    _getAllProvinsi(token);
  }
  void _onchangeKota(String newValue) async{
    String token = await LocalStorage.sharedInstance.readValue('token');
    _getAllKecamatanByIdKota(token);
  }
  _simpanKota() {
    print(idProvinsi);
    LocalStorage.sharedInstance
        .writeValue(key: 'idProvinsi', value: idProvinsi);
    LocalStorage.sharedInstance
        .writeValue(key: 'idKota', value: idKota == null ? 'null' : idKota);
    print(idKota);
    LocalStorage.sharedInstance.writeValue(
        key: 'idKecamatan', value: idKecamatan == null ? 'null' : idKecamatan);
    Navigator.pop(context);
  }

  void _onchangeProvinsi(String newValue) async{
    String token = await LocalStorage.sharedInstance.readValue('token');
    _getAllKotaByIdprovinsi(token);
  }

  void _getAllKotaByIdprovinsi(String token) {
    Api.getAllKotaByIdProvinsi(token,idProvinsi).then((value){
      var result = json.decode(value.body);
//      print(result);
      Iterable list = result['data'];
      setState(() {
        dataKota =
            list.map((model) => KotaM.fromMap(model)).toList();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih lokasi'),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width:
                        MediaQuery.of(context).size.width -
                            10,
                        child: DropdownButtonFormField<String>(
                          isDense: true,
                          hint: new Text(
                            "Pilih Provinsi",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12),
                          ),
                          value: widget.idProvinsi,
                          onChanged: (String newValue) {
                            setState(() {
                              idProvinsi = newValue;
                            });
                            _onchangeProvinsi(newValue);
                          },
                          items: dataProvinsi
                              .map((ProvinsiM item) {
                            return new DropdownMenuItem<String>(
                              value:
                              item.idPropinsi.toString(),
                              child: new Text(
                                item.namaPropinsi.toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        width:
                        MediaQuery.of(context).size.width -
                            10,
                        child: DropdownButtonFormField<String>(
                          isDense: true,
                          hint: new Text(
                            "Pilih Kota",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12),
                          ),
                          value: idKota,
                          onChanged: (String newValue) {
                            setState(() {
                              idKota = newValue;
                            });
                            _onchangeKota(newValue);
                          },
                          items: dataKota
                              .map((KotaM item) {
                            return new DropdownMenuItem<String>(
                              value:
                              item.idKabkota.toString(),
                              child: new Text(
                                item.namaKabkota.toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        width:
                        MediaQuery.of(context).size.width -
                            10,
                        child: DropdownButtonFormField<String>(
                          isDense: true,
                          hint: new Text(
                            "Pilih Kecamatan",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12),
                          ),
                          value: idKecamatan,
                          onChanged: (String newValue) {
                            setState(() {
                              idKecamatan = newValue;
                            });
                            _onchangeKecamatan(newValue);
                          },
                          items: dataKecamatan
                              .map((KecamatanM item) {
                            return new DropdownMenuItem<String>(
                              value:
                              item.idKecamatan.toString(),
                              child: new Text(
                                item.namaKecamatan.toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Expanded(
                flex:1,
                child: RoundedLoadingButton(
                  child: Text('Simpan',
                      style:
                      TextStyle(color: Colors.white)),
                  color: Colors.red,
                  controller: _btnController,
                  onPressed: () => _simpanKota(),
                ),
              )
            ],
          )),
    );
  }

  void _onchangeKecamatan(String newValue) {
//    LocalStorage.sharedInstance
//        .writeValue(key: 'idKecamatan', value: newValue);
  }
}
