import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/KategoriM.dart';
import 'package:apps/provider/Api.dart';
import 'package:apps/screen/KategoriScreen.dart';
import 'package:apps/screen/SubKategoriScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WidgetKategoriHome extends StatefulWidget {
  WidgetKategoriHome({Key key}) : super(key: key);

  @override
  _WidgetKategoriHomeState createState() {
    return _WidgetKategoriHomeState();
  }
}

class _WidgetKategoriHomeState extends State<WidgetKategoriHome> {
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
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Kategori',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
              InkWell(
                onTap: () => {_openKategori()},
                child: Text(
                  'Semua',
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 5, right: 5, top: 10),
              itemCount: dataKategori.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () => openSubkategori(dataKategori[index]),
                    child: Container(
                      height: 100,
                      width: 100,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.network(
                            dataKategori[index].produkkategorithumbnail,
                            width: 45,
                          ),
                          Divider(),
                          Text(dataKategori[index].produkkategorinama),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }

  _openKategori() {
    Navigator.push(
      context,
      SlideRightRoute(page: KategoriScreen()),
    );
  }

  void openSubkategori(param) {
    Navigator.push(
        context,
        SlideRightRoute(
            page: SubKategoriScreen(
          idKategori: int.parse(param.produkkategoriid),
          namaKategori: param.produkkategorinama,
        )));
  }
}
