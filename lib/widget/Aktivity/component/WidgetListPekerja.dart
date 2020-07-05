import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Helper/WidgetFotoCircular.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetListPekerja extends StatelessWidget {
  const WidgetListPekerja({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    return ExpansionTileCard(
      elevation: 2,
      colorCurve: Curves.ease,
      initiallyExpanded: true,
      leading: Icon(
        Icons.group_work,
        color: Colors.orange,
      ),
      title: Text('Daftar Pekerja'),
      children: <Widget>[
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dataProvider.listBidding.length == 0
                  ? 'Belum ada yang memilih pekerjaan anda'
                  : 'Silahkan pilih pekerja salah satu rekomendasi dari kami'),
              dataProvider.listBidding.length == 0
                  ? Container()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: ListView.builder(
                          itemCount: dataProvider.listBidding.length,
                          itemBuilder: (context, index) {
                            var harga = dataProvider.listBidding[index].bidprice;
                            var hargaFormat = Money.fromInt(harga == null ? 0 : int.parse(harga), IDR);
                            return Column(
                              children: [
                                ListTile(
                                  leading: WidgetFotoCircular(
                                    dataProvider: dataProvider,
                                    userFoto: dataProvider.listBidding[index].userfoto,
                                  ),
                                  title: Text(dataProvider.listBidding[index].userbidnama +
                                      ' (' +
                                      dataProvider.listBidding[index].bidwaktupengerjaan +
                                      ' Hari' +
                                      ')'),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(dataProvider.listBidding[index].biddeskripsi),
//                                Text(dataProvider.listBidding[index].bidwaktupengerjaan + ' Hari'),
                                      Text(
                                        hargaFormat.toString(),
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.done_all),
                                  ),
                                ),
                                Divider()
                              ],
                            );
                          }),
                    ),
            ],
          ),
        )
      ],
    );
  }
}
