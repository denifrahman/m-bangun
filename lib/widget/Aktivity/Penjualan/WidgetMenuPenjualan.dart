import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class WidgetMenuPenjualan extends StatelessWidget {
  WidgetMenuPenjualan({Key key}) : super(key: key);
  var dataList = ['Pesanan Baru', 'Dikemas', 'Dikirim', 'Ulasan', 'Selesai'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    return Container(
      width: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(bottom: 50),
      child: ListView.builder(
        itemCount: dataList.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () => _openPejualan(dataList[index], blocAuth.idUser, context),
              child: ListTile(
                  title: Text(
                    dataList[index],
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: dataList[index] == 'Pesanan Baru'
                      ? Stack(
                          children: <Widget>[
                            Icon(
                              Icons.new_releases,
                              size: 33,
                              color: Colors.blue,
                            ),
                            Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                alignment: Alignment.center,
                                child: Text(
                                  blocOrder.countMenunggu.toString() == '0' ? '' : blocOrder.countMenunggu.toString(),
                                  style: TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),
                            )
                          ],
                        )
                      : dataList[index] == 'Menunggu Konfirmasi'
                          ? Stack(
                              children: <Widget>[
                                Icon(
                                  Icons.watch_later,
                                  size: 33,
                                  color: Colors.amber,
                                ),
                                Positioned(
                                  top: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                    alignment: Alignment.center,
                                    child: Text(
                                      blocOrder.countMenungguKonfirmasi.toString() == '0' ? '' : blocOrder.countMenungguKonfirmasi.toString(),
                                      style: TextStyle(color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : dataList[index] == 'Dikemas'
                              ? Stack(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.shoppingBag,
                                      color: Colors.deepOrange,
                                      size: 33,
                                    ),
                                    Positioned(
                                      top: 0.0,
                                      right: 0.0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                        alignment: Alignment.center,
                                        child: Text(
                                          blocOrder.countDikemas.toString() == '0' ? '' : blocOrder.countDikemas.toString(),
                                          style: TextStyle(color: Colors.white, fontSize: 10),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : dataList[index] == 'Dikirim'
                                  ? Stack(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.truckPickup,
                                          color: Colors.cyan,
                                          size: 33,
                                        ),
                                        Positioned(
                                          top: 0.0,
                                          right: 0.0,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                            alignment: Alignment.center,
                                            child: Text(
                                              blocOrder.countDikirim.toString() == '0' ? '' : blocOrder.countDikirim.toString(),
                                              style: TextStyle(color: Colors.white, fontSize: 10),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : dataList[index] == 'Ulasan'
                                      ? Stack(
                                          children: <Widget>[
                                            Icon(
                                              Icons.comment,
                                              color: Colors.red,
                                              size: 33,
                                            ),
                                            Positioned(
                                              top: 0.0,
                                              right: 0.0,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  blocOrder.countUlasan.toString() == '0' ? '' : blocOrder.countUlasan.toString(),
                                                  style: TextStyle(color: Colors.white, fontSize: 10),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : dataList[index] == 'Selesai'
                                          ? Stack(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.assignment_turned_in,
                                                  size: 33,
                                                  color: Colors.green,
                                                ),
                                                Positioned(
                                                  top: 0.0,
                                                  right: 0.0,
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      blocOrder.countSelesai.toString() == '0' ? '' : blocOrder.countSelesai.toString(),
                                                      style: TextStyle(color: Colors.white, fontSize: 10),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          : Icon(Icons.delete, color: Colors.red),
                  trailing: Icon(Icons.arrow_forward_ios)),
            ),
          );
        },
      ),
    );
  }

  _openPejualan(String dataList, idUser, BuildContext context) {}
}