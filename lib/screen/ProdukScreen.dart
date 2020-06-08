import 'package:apps/widget/Produk/WidgetListProduk.dart';
import 'package:apps/widget/WidgetSearch.dart';
import 'package:flutter/material.dart';

class ProdukScreen extends StatelessWidget {
  final String namaKategori;
  final String idSubKategori;

  ProdukScreen({Key key, this.namaKategori, this.idSubKategori})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(this.namaKategori),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.filter_list,
            color: Color(0xffb16a085),
          ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
                height: 50,
                padding: EdgeInsets.only(bottom: 10),
                child: WidgetSearch()),
            Expanded(
//              height: 200,
              flex: 2,
              child: WidgetListProduk(
                idSubKategori: this.idSubKategori,
              ),
            )
          ],
        ),
      ),
    );
  }
}
