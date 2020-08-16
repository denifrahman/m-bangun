import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/widget/Aktivity/Pembelian/component/WidgetDetailOrderProdukPembelian.dart';
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
                      if (blocOrder.listOrder[index].statusOrder == null || blocOrder.listOrder[index].statusPembayaran == 'menunggu_pembayaran') {
                        var param = {
                          'id': blocOrder.listOrder[index].id,
                        };
                        blocOrder.getOrderTagihanByParam(param);
                        Navigator.push(context, SlideRightRoute(page: WidgetTagihan()));
                      }
                      if (blocOrder.listOrder[index].statusOrder == 'menunggu konfirmasi' || blocOrder.listOrder[index].statusPembayaran == 'terbayar') {
                        var param = {
                          'id_order': blocOrder.listOrder[index].id,
                        };
                        blocOrder.getOrderProdukByParam(param);
                        Navigator.push(
                            context,
                            SlideRightRoute(
                                page: WidgetDetailOrderProdukPembelian(
                              title: blocOrder.listOrder[index].statusOrder,
                              order: blocOrder.listOrder[index],
                            ))).then((value) {
                          blocOrder.getOrderProdukByParam(param);
                        });
                      }
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image.network('https://m-bangun.com/api-v2/assets/toko/' + blocOrder.listOrder[index].foto, width: 50, height: 100,
                              errorBuilder: (context, urlImage, error) {
                                print(error.hashCode);
                                return Image.asset('assets/logo.png');
                              }),
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
                                Icon(
                                  Icons.watch_later,
                                  color: Colors.red,
                                  size: 20,
                                ),
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
      var param = {'id_pembeli': blocAuth.idUser.toString(), 'status_order': title.toString(), 'status_pembayaran': 'terbayar'};
      blocOrder.getOrderByParam(param);
    }
  }
}
