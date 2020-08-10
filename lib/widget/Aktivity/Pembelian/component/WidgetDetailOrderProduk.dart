import 'package:apps/providers/BlocOrder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetDetailOrderProduk extends StatelessWidget {
  final String title;

  WidgetDetailOrderProduk({Key key, this.title}) : super(key: key);
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
                      subtitle: Text(Money.fromInt((int.parse(blocOrder.listOrder[j].total)), IDR).toString(), style: TextStyle(fontStyle: FontStyle.normal, fontSize: 12)),
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
