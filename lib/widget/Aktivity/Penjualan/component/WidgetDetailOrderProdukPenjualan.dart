import 'package:apps/models/Order.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';

class WidgetDetailOrderProdukPenjualan extends StatelessWidget {
  final String title;
  final Order order;

  WidgetDetailOrderProdukPenjualan({Key key, this.title, this.order}) : super(key: key);
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
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    // TODO: implement build
    AppBar appBar = AppBar(
      elevation: 0,
      title: Text('Detail Produk'),
    );
    return Scaffold(
      appBar: appBar,
      body: blocProfile.isLoading
          ? Center(
              child: PKCardPageSkeleton(
              totalLines: 2,
            ))
          : Container(
              decoration: BoxDecoration(color: Colors.grey[100], image: DecorationImage(image: AssetImage('assets/shipping_background.png'), fit: BoxFit.contain)),
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top),
              child: Column(
                children: [
                  Container(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            order.namaPenerima.toUpperCase() + ' ' + '#' + order.namaAlamat,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(order.alamatLengkap, style: TextStyle(fontSize: 14)),
                              Row(
                                children: [
                                  Text(
                                      blocProfile.listSubDistrict[0].rajaongkir.results[0].subdistrictName +
                                          ' ' +
                                          blocProfile.listSubDistrict[0].rajaongkir.results[0].city +
                                          ' ' +
                                          blocProfile.listSubDistrict[0].rajaongkir.results[0].province,
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(order.kodeKurir.toUpperCase(), style: TextStyle(fontSize: 14)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(order.jenisService.toUpperCase(), style: TextStyle(fontSize: 14))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10),
                      itemCount: blocOrder.listOrderDetailProduk.length,
//                  physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, j) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
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
                                      style: TextStyle(fontStyle: FontStyle.normal, fontSize: 12)),
                                  Text(blocOrder.listOrderDetailProduk[j].catatan == null ? '-' : '"' + blocOrder.listOrderDetailProduk[j].catatan + '"',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 9,
                                      ))
                                ],
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'qty',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    Text(blocOrder.listOrderDetailProduk[j].jumlah, style: TextStyle(fontSize: 13, color: Colors.red, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
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
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text(title == 'dikemas' ? 'Kirim Barang' : title == 'menunggu konfirmasi' ? 'Kemas Barang' : title),
                        color: Color(0xffb16a085),
                        textColor: Colors.white,
                        padding: EdgeInsets.only(left: 11, right: 11, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        onPressed: () async {},
                      ),
                    ),
                  )
                ],
              ),
            ),
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
