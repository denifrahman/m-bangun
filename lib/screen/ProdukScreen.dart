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
        title: Text(this.namaKategori),
        actions: <Widget>[
          IconButton(
              icon: Icon(
            Icons.filter_list,
            color: Colors.red,
          ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              WidgetSearch(),
              WidgetListProduk(
                idSubKategori: this.idSubKategori,
              )
            ],
          ),
        ),
      ),
    );
  }
}
