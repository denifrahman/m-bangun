import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/ProdukListM.dart';
import 'package:apps/provider/Api.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:money2/money2.dart';

class WidgetListProduk extends StatefulWidget {
  final String idSubKategori;

  WidgetListProduk({Key key, this.idSubKategori}) : super(key: key);

  @override
  _WidgetListProdukState createState() {
    return _WidgetListProdukState();
  }
}

class _WidgetListProdukState extends State<WidgetListProduk> {
  var dataProdukList = new List<ProdukListM>();
  final IDR = Currency.create('IDR', 0,
      symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
  String idKecamatan = '';
  String idKota = '';
  String idProvinsi = '';
  String key = '';

  @override
  void initState() {
    super.initState();
    _getProdukByParam();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getProdukByParam() async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllProdukByParam(
            token, idKecamatan, idKota, idProvinsi, widget.idSubKategori, key)
        .then((response) {
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataProdukList =
            list.map((model) => ProdukListM.fromMap(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return GridView.count(
//      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      children: List.generate(dataProdukList.length, (j) {
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
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      strutStyle: StrutStyle(fontSize: 12.0),
                      text: TextSpan(
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 11,
                            fontWeight: FontWeight.w700),
                        text: '${dataProdukList[j].produknama}',
                      ),
                    ),
                    trailing: Icon(
                      Icons.favorite_border,
                      size: 14,
                    ),
                  ),
                ),
                Expanded(
                  flex:2,
                  child: Image.network(
                    dataProdukList[j].produkthumbnail == null
                        ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                        : dataProdukList[j].produkthumbnail,
                    fit: BoxFit.fitHeight,
                    // width: 80,
                  ),
                ),
                Expanded(
                  flex:2,
                  // margin: EdgeInsets.only(top: 2),
                  // height: 75,
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Text(harga == null ? '-' : hargaFormat.toString(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: 2),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: Colors.grey,
                                size: 11,
                              ),
                              Text(' '),
                              Text(
                                Jiffy(dataProdukList[j].produkcreate).fromNow(),
                                style: TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                          Container(height: 2,),
                          Row(
                            children: <Widget>[
                              Icon(Icons.place, color: Colors.grey, size: 11,),
                              Text(' '),
                              Text(
                                '${kecamatan[0].toUpperCase()}${kecamatan
                                    .substring(1)}, ${kota[0]
                                    .toUpperCase()}${kota.substring(
                                    1)}\n${provinsi[0]
                                    .toUpperCase()}${provinsi.substring(1)}',
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
      }),
    );
  }

  _openDetailNews(ProdukListM dataProdukList) {}
}
