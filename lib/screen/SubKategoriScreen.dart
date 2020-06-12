import 'package:apps/widget/SubKategori/WidgetSubKategori.dart';
import 'package:flutter/material.dart';

class SubKategoriScreen extends StatelessWidget {
  final int idKategori;
  final String namaKategori;

  SubKategoriScreen({Key key, this.idKategori, this.namaKategori})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(this.namaKategori),
      ),
      body: WidgetSubKategori(
        idKategori: this.idKategori,
      ),
    );
  }
}
