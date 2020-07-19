import 'package:apps/widget/SubKategori/WidgetSubKategori.dart';
import 'package:flutter/material.dart';

class SubKategoriScreen extends StatelessWidget {
  final int idKategori;
  final String namaKategori;
  final String flag;

  SubKategoriScreen({Key key, this.idKategori, this.namaKategori, this.flag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    print(this.flag);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(this.namaKategori),
      ),
      body: WidgetSubKategori(
        idKategori: this.idKategori,
        flag: this.flag,
      ),
    );
  }
}
