import 'dart:io';

import 'package:apps/models/Order.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetDetailOrderProdukPembelian extends StatelessWidget {
  final String title;
  final Order order;

  WidgetDetailOrderProdukPembelian({Key key, this.title, this.order}) : super(key: key);
  final List<Location> locations = [
    Location('Kolkata Facility', DateTime(2019, 6, 5, 5, 23, 4), showHour: false, isHere: false, passed: true),
    Location('Hyderabad Facility', DateTime(2019, 6, 6, 5, 23, 4), showHour: false, isHere: false, passed: true),
    Location(
      'Chennai Facility',
      DateTime(2019, 6, 9, 5, 23, 4),
      showHour: false,
      isHere: true,
    ),
    Location(
      'Kerala Facility',
      DateTime(2019, 6, 10, 5, 23, 4),
      showHour: true,
      isHere: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    // TODO: implement build
    AppBar appBar = AppBar(
      title: Text('Detail Produk'),
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[100], image: DecorationImage(image: AssetImage('assets/shipping_background.png'), fit: BoxFit.contain)),
        height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(10),
                itemCount: blocOrder.listOrderDetailProduk.length,
//                  physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, j) {
                  return Card(
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          'https://m-bangun.com/api-v2/assets/toko/' + blocOrder.listOrderDetailProduk[j].foto,
                          errorBuilder: (context, urlImage, error) {
                            print(error.hashCode);
                            return Image.asset('assets/logo.png');
                          },
                          width: 80,
                        ),
                      ),
                      title: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                            text: blocOrder.listOrderDetailProduk[j].namaProduk),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Money.fromInt((int.parse(blocOrder.listOrderDetailProduk[j].subtotal)), IDR).toString(),
                              style: TextStyle(fontStyle: FontStyle.normal, fontSize: 10)),
                          Text(blocOrder.listOrderDetailProduk[j].catatan == null ? '-' : '"' + blocOrder.listOrderDetailProduk[j].catatan + '"',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 9,
                              ))
                        ],
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(blocOrder.listOrderDetailProduk[j].jumlah),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Container(
                  width: 150,
//                    height: 150,
                  child: this.title == 'menunggu_konfirmasi'
                      ? Image.asset(
                          'assets/img/waiting.png',
                          fit: BoxFit.fitWidth,
                        )
                      : this.title == 'dikemas'
                          ? Image.asset(
                              'assets/img/packing.png',
                              fit: BoxFit.fitWidth,
                            )
                          : this.title == 'dikirim'
                              ? Image.asset(
                                  'assets/img/dikirim.png',
                                  fit: BoxFit.fitWidth,
                                )
                              : this.title == 'ulasan'
                                  ? Image.asset(
                                      'assets/img/waiting.png',
                                      fit: BoxFit.fitWidth,
                                    )
                                  : Image.asset(
                                      'assets/img/waiting.png',
                                      fit: BoxFit.fitWidth,
                                    ),
                ),
              ),
            ),
            title.toLowerCase() != 'dikirim'
                ? Container()
                : Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text(
                            title.toLowerCase() == 'dikirim' ? 'Barang diterima' : title == 'menunggu konfirmasi' ? 'Kemas Barang' : title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          color: Color(0xffb16a085),
                          textColor: Colors.white,
                          padding: EdgeInsets.only(left: 11, right: 11, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          onPressed: () async {
                            _showVersionDialog(context, blocOrder, blocAuth);
                          },
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  _showVersionDialog(context, BlocOrder blocOrder, blocAuth) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        String title = "Penerimaan barang";
        String btnLabel = "Terima";
        String btnLabelCancel = "Belum";
        return Platform.isIOS
            ? WillPopScope(
                onWillPop: () {},
                child: new CupertinoAlertDialog(
                  title: Text(title),
                  content: Column(
                    children: <Widget>[
                      Text("Apakah Anda yakin barang sudah anda terima?"),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(btnLabelCancel),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                        child: Text(btnLabel),
                        onPressed: () {
                          Navigator.pop(context);
                          var body = {'id': order.id.toString(), 'status_order': this.title.toLowerCase() == 'dikirim' ? 'ulasan' : '', 'id_toko': order.idToko.toString()};
                          var result = blocOrder.updateOrder(body);
                          result.then((value) {
                            if (value) {
                              Navigator.pop(context);
                              var param = {'id_pembeli': blocAuth.idToko.toString(), 'status_order': title.toString().toLowerCase(), 'status_pembayaran': 'terbayar'};
                              blocOrder.getOrderByParam(param);
                              blocOrder.setIdUser();
                            }
                          });
                        }),
                  ],
                ),
              )
            : WillPopScope(
                onWillPop: () {},
                child: new CupertinoAlertDialog(
                  title: Text(title),
                  content: Column(
                    children: <Widget>[
                      Text("Apakah Anda yakin barang sudah anda terima?"),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(btnLabel),
//                  onPressed: () => _launchURL(PLAY_STORE_URL),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

class Location {
  String city;
  DateTime date;
  bool showHour;
  bool isHere;
  bool passed;

  Location(this.city, this.date, {this.showHour = false, this.isHere = false, this.passed = false});

  String getDate() {
    if (showHour) {
      return DateFormat("K:mm aaa, d MMMM y").format(date);
    } else {
      return DateFormat('d MMMM y').format(date);
    }
  }
}
