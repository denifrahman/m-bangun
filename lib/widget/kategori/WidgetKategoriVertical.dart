import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/KategoriM.dart';
import 'package:apps/provider/Api.dart';
import 'package:flutter/material.dart';

class WidgetKategoriVertical extends StatefulWidget {
  WidgetKategoriVertical({Key key}) : super(key: key);

  @override
  _WidgetKategoriVerticalState createState() {
    return _WidgetKategoriVerticalState();
  }
}

class _WidgetKategoriVerticalState extends State<WidgetKategoriVertical> {
  var dataKategori = new List<KategoriM>();
  @override
  void initState() {
    super.initState();
    _getToken();
  }

  @override
  void dispose() {
    super.dispose();
  }
  void _getToken() async {
    Api.getToken().then((value) {
      var data = json.decode(value.body);
      LocalStorage.sharedInstance
          .writeValue(key: 'token', value: data['data']['token']);
      _getKategori();
    });
  }

  void _getKategori() async {
    String tokenValid = await LocalStorage.sharedInstance.readValue('token');
    Api.getKategori(tokenValid).then((response) {
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataKategori = list.map((model) => KategoriM.fromMap(model)).toList();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          padding: EdgeInsets.only(left: 5, right: 5, top: 10),
          itemCount: dataKategori.length,
          itemBuilder: (context, index) {
            return Card(
              child: Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      dataKategori[index].produkkategorithumbnail,width: 45,
                    ),
                    Divider(),
                    Text(dataKategori[index].produkkategorinama),
                  ],
                ),
              ),
            );
          }),
    );
  }
}