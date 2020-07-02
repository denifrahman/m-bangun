import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/jenis_pengajuan.dart';
import 'package:apps/providers/Api.dart';
import 'package:apps/widget/Pengajuan/component/WidgetFormPelatihanKerja.dart';
import 'package:apps/widget/Pengajuan/component/WidgetFormRequest.dart';
import 'package:flutter/material.dart';

class WidgetPengajuan extends StatefulWidget {
  final double height;

  WidgetPengajuan({Key key, this.height}) : super(key: key);

  @override
  _WidgetPengajuanState createState() {
    return _WidgetPengajuanState();
  }
}

class _WidgetPengajuanState extends State<WidgetPengajuan> {
  var dataJenisPengajuan = new List<JenisPengajuan>();
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

  void getAllJenisPengajuan() async {
    String tokenValid = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllJenisPengajuan(tokenValid).then((response) {
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataJenisPengajuan = list.map((model) => JenisPengajuan.fromJson(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              color: Colors.white,
              height: (widget.height) * 0.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(child: _dropdownJenisPengajuan()),
              )),
          Container(
            height: (widget.height) * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  child: jenispengajuanid == '1' ? WidgetFormRequest() : jenispengajuanid == '2' ? WidgetFormPelatihanKerja() : Container()),
            ),
          )
        ],
      ),
    );
  }

  Widget _dropdownJenisPengajuan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - 10,
          child: DropdownButtonFormField<String>(
            isDense: true,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffb16a085),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffb16a085),
                ),
              ),
            ),
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
}
