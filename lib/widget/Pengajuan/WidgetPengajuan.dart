import 'dart:convert';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/SubKategoriM.dart';
import 'package:apps/models/jenis_pengajuan.dart';
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
  var dataJenisPengajuan = new List<JenisPengajuan>();
  var dataSubKategori = new List<SubKategoriM>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String jenispengajuanid;

  @override
  void initState() {
    super.initState();
    getAllJenisPengajuan();
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
              _dropdownJenisPengajuan(),
              Container(
                height: 20,
              ),
              jenispengajuanid == '1' ? _buildFormRqt() : jenispengajuanid == '2' ? _buildFormPelatihanKerja():Container()
            ],
          ),
        ),
      ),
    );
  }

Widget _buildFormPelatihanKerja(){
  return Column(
    children: <Widget>[
      Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  // focusNode: myFocusNodeNamaPerusahaan,
                  // controller: namaPerusahaanController,
                  validator: (String arg) {
                    if (arg.length < 1)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Universitas",
                      hintText: 'Universitas',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      hasFloatingPlaceholder: true),
                ),
              ),
            ),
      Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  // focusNode: myFocusNodeNamaPerusahaan,
                  // controller: namaPerusahaanController,
                  validator: (String arg) {
                    if (arg.length < 1)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Fakultas",
                      hintText: 'Fakultas',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      hasFloatingPlaceholder: true),
                ),
              ),
            ),
      Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  // focusNode: myFocusNodeNamaPerusahaan,
                  // controller: namaPerusahaanController,
                  validator: (String arg) {
                    if (arg.length < 1)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Jurusan",
                      hintText: 'Jurusan',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      hasFloatingPlaceholder: true),
                ),
              ),
            ),
    ],
  );
}
  Widget _buildFormRqt() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Dimensi (cm)'),
        Container(height: 10,),
        Row(
          children: <Widget>[
            Expanded(
              // width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  // focusNode: myFocusNodeNamaPerusahaan,
                  // controller: namaPerusahaanController,
                  validator: (String arg) {
                    if (arg.length < 1)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Panjang",
                      hintText: 'Panjang',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      hasFloatingPlaceholder: true),
                ),
              ),
            ),
            Expanded(
              // width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  // focusNode: myFocusNodeNamaPerusahaan,
                  // controller: namaPerusahaanController,
                  validator: (String arg) {
                    if (arg.length < 1)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Lebar",
                      hintText: 'Lebar',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      hasFloatingPlaceholder: true),
                ),
              ),
            ),
            Expanded(
              // width: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  // focusNode: myFocusNodeNamaPerusahaan,
                  // controller: namaPerusahaanController,
                  validator: (String arg) {
                    if (arg.length < 1)
                      return 'Harus di isi';
                    else
                      return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Tinggi",
                      hintText: 'Tinggi',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffb16a085),
                        ),
                      ),
                      hasFloatingPlaceholder: true),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _dropdownJenisPengajuan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          'Jenis Pengajuan',
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w800, color: Colors.black),
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
              "Jenis Pengajuan",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            value: jenispengajuanid,
            onChanged: (String newValue) {
              setState(() {
                jenispengajuanid = newValue;
              });
              _onchangeKategori(newValue);
            },
            items: dataJenisPengajuan.map((JenisPengajuan item) {
              return new DropdownMenuItem<String>(
                value: item.jenispengajuanid.toString(),
                child: new Text(
                  item.jenispengajuannama.toString(),
                  style: TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  void getAllJenisPengajuan() async {
    String tokenValid = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllJenisPengajuan(tokenValid).then((response) {
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataJenisPengajuan =
            list.map((model) => JenisPengajuan.fromJson(model)).toList();
      });
    });
  }

  void _onchangeKategori(String newValue) async {
    String token = await LocalStorage.sharedInstance.readValue('token');
   
  }

  void _onchangeSubKategori(String newValue) {}
}
