import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/KecamatanM.dart';
import 'package:apps/models/KotaM.dart';
import 'package:apps/models/ProvinsiM.dart';
import 'package:apps/providers/Api.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetFilterLokasi extends StatefulWidget {
  WidgetFilterLokasi({Key key}) : super(key: key);

  @override
  _WidgetFilterLokasiState createState() => _WidgetFilterLokasiState();
}

class _WidgetFilterLokasiState extends State<WidgetFilterLokasi> {
  String idKota;
  String idProvinsi;
  String idKecamatan;
  String namaProvinsi, namaKota, namaKecamatan;
  var dataKota = List<KotaM>();
  var dataProvinsi = List<ProvinsiM>();
  var dataKecamatan = List<KecamatanM>();

  @override
  void initState() {
    _getAllProvinsi();
    _getCurrentLocation();
    super.initState();
  }

  void _getCurrentLocation() async {
    String currentIdProvinsi = await LocalStorage.sharedInstance.readValue('idProvinsi');
    String currentIdKota = await LocalStorage.sharedInstance.readValue('idKota');
    String currentIdKecamatan = await LocalStorage.sharedInstance.readValue('idKecamatan');
    if (currentIdProvinsi != 'null') {
      _onchangeProvinsi(currentIdProvinsi);
      setState(() {
        idProvinsi = currentIdProvinsi;
      });
      if (currentIdKota != 'null') {
        setState(() {
          idKota = currentIdKota;
        });
      }
    }
    print(currentIdKecamatan);
    if (currentIdKecamatan != 'null') {
      _onchangeKota(currentIdKota);
    }
    if (currentIdKecamatan != 'null') {
      setState(() {
        idKecamatan = currentIdKecamatan;
      });
    }
  }

  void _getAllProvinsi() async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    Provider.of<DataProvider>(context).setDataKota([]);
    Provider.of<DataProvider>(context).setDataKecamatan([]);

    Api.getAllProvinsi(token).then((value) {
      var result = json.decode(value.body);
      print(result);
      Iterable list = result['data'];
      Provider.of<DataProvider>(context).setDataProvinsi(list.map((model) => ProvinsiM.fromMap(model)).toList());
    });
  }

  void _onchangeProvinsi(String newValue) async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllKotaByIdProvinsi(token, newValue).then((value) {
      var result = json.decode(value.body);
      Iterable list = result['data'];
      Provider.of<DataProvider>(context).setDataKota(list.map((model) => KotaM.fromMap(model)).toList());
    });
  }

  void _onchangeKota(String newValue) async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllKecamatanByIdKota(token, idKota).then((value) {
      var result = json.decode(value.body);
      print(result);
      Iterable list = result['data'];
      Provider.of<DataProvider>(context).setDataKecamatan(list.map((model) => KecamatanM.fromMap(model)).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 10,
                child: DropdownButtonFormField<String>(
                  isDense: true,
                  hint: new Text(
                    "Pilih Provinsi",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  value: idProvinsi,
                  validator: (String arg) {
                    if (arg == null)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  onChanged: (String newValue) {
                    dataProvider.setSelectedKota(null);
                    setState(() {
                      idProvinsi = newValue;
                      idKota = null;
                      idKecamatan = null;
                    });
                    dataProvider.setDataKota([]);
                    dataProvider.setDataKecamatan([]);
                    dataProvider.setSelectedProvinsi(newValue);
                    dataProvider.setSelectedKota(null);
                    dataProvider.setSelectedKecamatan(null);
                    _onchangeProvinsi(newValue);
                  },
                  items: dataProvider.getDataProvinsi.map((ProvinsiM item) {
                    return new DropdownMenuItem<String>(
                      value: item.idPropinsi.toString(),
                      child: new Text(
                        item.namaPropinsi.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 10,
                child: DropdownButtonFormField<String>(
                  isDense: true,
                  hint: new Text(
                    "Pilih Kota",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  value: idKota,
                  validator: (String arg) {
                    if (arg == null)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  onChanged: (String newValue) {
                    setState(() {
                      idKota = newValue;
                      dataKecamatan = [];
                      idKecamatan = null;
                    });
                    dataProvider.setSelectedKota(newValue);
                    dataProvider.setSelectedKecamatan(null);
                    _onchangeKota(newValue);
                  },
                  items: dataProvider.getDataKota.map((KotaM item) {
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
              Container(
                width: MediaQuery.of(context).size.width - 10,
                child: DropdownButtonFormField<String>(
                  isDense: true,
                  hint: new Text(
                    "Pilih Kecamatan",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  value: idKecamatan,
                  validator: (String arg) {
                    if (arg == null)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  onChanged: (String newValue) {
                    setState(() {
                      idKecamatan = newValue;
                    });
                    dataProvider.setSelectedKecamatan(newValue);
                  },
                  items: dataProvider.getDataKecamatan.map((KecamatanM item) {
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
            ],
          ),
        )
      ],
    );
  }
}
