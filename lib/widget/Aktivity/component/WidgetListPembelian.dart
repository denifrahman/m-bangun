import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/widget/Tagihan/WidgetTagihan.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetListPembelian extends StatelessWidget {
  final String title;

  WidgetListPembelian({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(this.title),
      ),
      body: blocOrder.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                onRefresh(context);
              },
              child: ListView.builder(
                itemCount: blocOrder.listOrder.length,
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      var param = {
                        'id': blocOrder.listOrder[index].id,
                      };
                      blocOrder.getOrderDetailByParam(param);
                      Navigator.push(context, SlideRightRoute(page: WidgetTagihan()));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image.network(
                            'https://m-bangun.com/api-v2/assets/toko/' + blocOrder.listOrder[index].foto,
                            width: 100,
                            height: 100,
                          ),
                          title: Text(blocOrder.listOrder[index].namaToko, style: TextStyle(fontSize: 14)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '(INV:' + blocOrder.listOrder[index].noOrder + ')',
                                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
                              ),
                              Text(Money.fromInt((int.parse(blocOrder.listOrder[index].total)), IDR).toString(), style: TextStyle(fontStyle: FontStyle.normal, fontSize: 12)),
                            ],
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                Icon(Icons.watch_later, color: Colors.red),
                                Text(
                                  Jiffy(DateTime.parse(blocOrder.listOrder[index].batasBayar.toString())).format("dd/MM/yyyy"),
                                  style: TextStyle(fontSize: 9, color: Colors.grey),
                                ),
                                Text(Jiffy(DateTime.parse(blocOrder.listOrder[index].batasBayar.toString())).format("HH:mm"), style: TextStyle(fontSize: 9, color: Colors.grey))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  onRefresh(context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    blocOrder.setCountPembelian();
    if (title == 'Menunggu Pembayaran') {
      var param = {'id_pembeli': blocAuth.idUser.toString(), 'status_pembayaran': title == 'Menunggu Pembayaran' ? 'menunggu' : 'terbayar'};
      blocOrder.getOrderByParam(param);
    } else {
      var param = {'id_pembeli': blocAuth.idUser.toString(), 'status_order': title.toString() == 'Menunggu Konfirmasi' ? 'menunggu_konfirmasi' : title.toString()};
      blocOrder.getOrderByParam(param);
    }
  }
}
