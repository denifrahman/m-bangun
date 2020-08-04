import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WidgetMenuPembelian extends StatelessWidget {
  WidgetMenuPembelian({Key key}) : super(key: key);
  var dataList = ['Menunggu Pembayaran', 'Menunggu Konfirmasi', 'Dikemas', 'Dikirim', 'Ulasan', 'Selesai'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(bottom: 50),
      child: ListView.builder(
        itemCount: dataList.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () => _openPengajuan(dataList[index]),
              child: ListTile(
                  title: Text(dataList[index]),
                  leading: dataList[index] == 'Menunggu Pembayaran'
                      ? Icon(
                          Icons.new_releases,
                          color: Colors.blue,
                        )
                      : dataList[index] == 'Menunggu Konfirmasi'
                          ? Icon(
                              Icons.watch_later,
                              color: Colors.amber,
                            )
                          : dataList[index] == 'Dikemas'
                              ? Icon(
                                  FontAwesomeIcons.shoppingBag,
                                  color: Colors.deepOrange,
                                )
                              : dataList[index] == 'Dikirim'
                                  ? Icon(
                                      FontAwesomeIcons.truckPickup,
                                      color: Colors.cyan,
                                    )
                                  : dataList[index] == 'Ulasan'
                                      ? Icon(Icons.comment, color: Colors.red)
                                      : dataList[index] == 'Selesai'
                                          ? Icon(
                                              Icons.assignment_turned_in,
                                              color: Colors.green,
                                            )
                                          : Icon(Icons.delete, color: Colors.red),
                  trailing: Icon(Icons.arrow_forward_ios)),
            ),
          );
        },
      ),
    );
  }

  _openPengajuan(String dataList) {}
}
