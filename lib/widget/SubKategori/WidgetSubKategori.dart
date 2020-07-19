import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/SubKategoriM.dart';
import 'package:apps/providers/Api.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/ProdukScreen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetSubKategori extends StatefulWidget {
  final int idKategori;
  final flag;

  WidgetSubKategori({Key key, this.idKategori, this.flag}) : super(key: key);

  @override
  _WidgetSubKategoriState createState() {
    return _WidgetSubKategoriState();
  }
}

class _WidgetSubKategoriState extends State<WidgetSubKategori> {
  var dataSubKategori = new List<SubKategoriM>();

  @override
  void initState() {
    super.initState();
    getSubKategoriByIdKategori();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getSubKategoriByIdKategori() async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllSubKategoriByIdKategori(token, widget.idKategori.toString()).then((response) {
      print(response.body);
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataSubKategori = list.map((model) => SubKategoriM.fromMap(model)).toList();
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
          itemCount: dataSubKategori.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                onTap: () => _openListProdukBySubKategori(dataSubKategori[index]),
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.network(
                      dataSubKategori[index].produkkategorisubthubmnail == null
                          ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                          : dataSubKategori[index].produkkategorisubthubmnail,
                      width: 45,
                    ),
                    title: Text(dataSubKategori[index].produkkategorisubnama),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  _openListProdukBySubKategori(param) {
    Provider.of<DataProvider>(context).setidSubKategori(param.produkkategorisubid);
    Provider.of<DataProvider>(context).setProdukListByParam();
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    if (widget.flag == '2' || widget.flag == '3' || widget.flag == '4') {
      Navigator.push(
          context,
          SlideRightRoute(
              page: ProdukScreen(
            namaKategori: param.produkkategorisubnama,
            idSubKategori: param.produkkategorisubid,
          )));
    } else if (dataProvider.userSubKategori == param.produkkategorisubnama) {
      Navigator.push(
          context,
          SlideRightRoute(
              page: ProdukScreen(
            namaKategori: param.produkkategorisubnama,
            idSubKategori: param.produkkategorisubid,
          )));
    } else {
      Flushbar(
        title: "Error",
        message: "Silahkan login / member anda tidak sesuai",
        duration: Duration(seconds: 15),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.BOTTOM,
        icon: Icon(
          Icons.assignment_turned_in,
          color: Colors.white,
        ),
      )..show(context);
    }
  }
}
