import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/ProdukListM.dart';
import 'package:apps/provider/Api.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:money2/money2.dart';

class WidgetCari extends StatefulWidget {
  WidgetCari({Key key}) : super(key: key);

  @override
  _WidgetCariState createState() {
    return _WidgetCariState();
  }
}

class _WidgetCariState extends State<WidgetCari> {
  var dataProdukList = new List<ProdukListM>();
  String idKecamatan = '';
  String idKota = '';
  String idProvinsi = '';
  String idSubKategori = '';
  final IDR = Currency.create('IDR', 0,
      symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getProdukByParam(key) async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllProdukByParam(
            token, idKecamatan, idKota, idProvinsi, idSubKategori, key)
        .then((response) {
      var result = json.decode(response.body)['data'];
      if (result == []) {
        setState(() {
          dataProdukList = [];
        });
      } else {
        Iterable list = json.decode(response.body)['data'];
        setState(() {
          dataProdukList =
              list.map((model) => ProdukListM.fromMap(model)).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: FloatingSearchBar.builder(
          pinned: true,
          itemCount: dataProdukList.length,
          padding: EdgeInsets.only(top: 10.0),
          itemBuilder: (BuildContext context, int j) {
            var harga = dataProdukList[j].produkharga;
        var hargaFormat =
            Money.fromInt(harga == null ? 0 : int.parse(harga), IDR);
        var kecamatan = dataProdukList[j].nama_kecamatan == null
            ? ''
            : dataProdukList[j].nama_kecamatan.toLowerCase();
        var kota = dataProdukList[j].nama_kabkota == null
            ? ''
            : dataProdukList[j].nama_kabkota.toLowerCase();
        var provinsi = dataProdukList[j].nama_propinsi == null
            ? ''
            : dataProdukList[j].nama_propinsi.toLowerCase();
        return Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () => _openDetailNews(dataProdukList[j]),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
//                        height: 100,
                  child: ListTile(
                    leading: Image.network(
                      dataProdukList[j].produkthumbnail == null
                          ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                          : dataProdukList[j].produkthumbnail,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          strutStyle: StrutStyle(fontSize: 12.0),
                          text: TextSpan(
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                            text: '${dataProdukList[j].produknama}',
                          ),
                        ),
                        Text(harga == null ? '-' : hargaFormat.toString(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.access_time, color: Colors.grey,
                                    size: 12,),
                                  Text(' '),
                                  Text(
                                    Jiffy(dataProdukList[j].produkcreate)
                                        .fromNow(),
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                              Container(height: 3,),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.place, color: Colors.grey, size: 12,),
                                  Text(' '),
                                  Text(
                                    '${kecamatan[0].toUpperCase()}${kecamatan
                                        .substring(1)}, ${kota[0]
                                        .toUpperCase()}${kota.substring(
                                        1)}\n${provinsi[0]
                                        .toUpperCase()}${provinsi.substring(
                                        1)}',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            );
          },
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () => {Navigator.pop(context)},),
          onChanged: (String value) => _onSearch(value),
          onTap: () {},
          decoration: InputDecoration.collapsed(
            hintText: "Search...",
          ),
        )
    );
  }

  _onSearch(String value) {
    if (value.isNotEmpty) {
      _getProdukByParam(value);
    }
    {
      setState(() {
        dataProdukList = [];
      });
    }
  }

  _openDetailNews(ProdukListM dataProdukList) {}
}