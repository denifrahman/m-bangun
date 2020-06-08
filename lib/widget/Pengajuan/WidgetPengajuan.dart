import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/KategoriM.dart';
import 'package:apps/models/SubKategoriM.dart';
import 'package:apps/provider/Api.dart';
import 'package:flutter/material.dart';

class WidgetPengajuan extends StatefulWidget {
  WidgetPengajuan({Key key}) : super(key: key);

  @override
  _WidgetPengajuanState createState() {
    return _WidgetPengajuanState();
  }
}

class _WidgetPengajuanState extends State<WidgetPengajuan> {
  var dataKategori = new List<KategoriM>();
  var dataSubKategori = new List<SubKategoriM>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String idKategori;
  String idSubKategori;

  @override
  void initState() {
    super.initState();
    _getAllByFilterParam();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidate: false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                'Kategori Request',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 10,
                child: DropdownButtonFormField<String>(
                  isDense: true,
                  validator: (String arg) {
                    if (arg == null)
                      return 'Silahkan pilih terbelih dahulu';
                    else
                      return null;
                  },
                  hint: new Text(
                    "Pilih Kategori",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  value: idKategori,
                  onChanged: (String newValue) {
                    setState(() {
                      idKategori = newValue;
                    });
                    _onchangeKategori(newValue);
                  },
                  items: dataKategori.map((KategoriM item) {
                    return new DropdownMenuItem<String>(
                      value: item.produkkategoriid.toString(),
                      child: new Text(
                        item.produkkategorinama.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                height: 20,
              ),
              idKategori == null ? Container() : _dropdownSubKategori()
            ],
          ),
        ),
      ),
    );
  }

  Widget _dropdownSubKategori() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Sub Kategori Request',
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 10,
          child: DropdownButtonFormField<String>(
            isDense: true,
            validator: (String arg) {
              if (arg == null)
                return 'Sub kategori harus di isi';
              else
                return null;
            },
            hint: new Text(
              "Pilih Sub Kategori",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            value: idSubKategori,
            onChanged: (String newValue) {
              setState(() {
                idSubKategori = newValue;
              });
              _onchangeSubKategori(newValue);
            },
            items: dataSubKategori.map((SubKategoriM item) {
              return new DropdownMenuItem<String>(
                value: item.produkkategorisubid.toString(),
                child: new Text(
                  item.produkkategorisubnama.toString(),
                  style: TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _getAllByFilterParam() async {
    String tokenValid = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllByFilterParam(tokenValid, '1').then((response) {
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataKategori = list.map((model) => KategoriM.fromMap(model)).toList();
      });
    });
  }

  void _onchangeKategori(String newValue) async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllSubKategoriByIdKategori(token, newValue.toString())
        .then((response) {
      print(response.body);
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataSubKategori =
            list.map((model) => SubKategoriM.fromMap(model)).toList();
      });
    });
  }

  void _onchangeSubKategori(String newValue) {}
}
