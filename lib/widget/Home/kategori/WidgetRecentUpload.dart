import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/KategoriM.dart';
import 'package:apps/providers/Api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WidgetRecentUpload extends StatefulWidget {
  WidgetRecentUpload({Key key}) : super(key: key);

  @override
  _WidgetRecentUploadState createState() {
    return _WidgetRecentUploadState();
  }
}

class _WidgetRecentUploadState extends State<WidgetRecentUpload> {
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
    Api.getAllKategori(tokenValid).then((response) {
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataKategori = list.map((model) => KategoriM.fromMap(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('News',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
              InkWell(
                child: Text(
                  'Semua',
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 5, right: 5, top: 10),
              itemCount: dataKategori.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    height: 250,
                    width: 180,
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
        )
      ],
    );
  }
}
