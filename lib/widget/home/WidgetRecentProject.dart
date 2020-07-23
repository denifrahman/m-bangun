import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Produk/WidgetDetailProduk.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidhetRecentProject extends StatelessWidget {
  WidhetRecentProject({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Column(
      children: <Widget>[
        dataProvider.dataRecentProject.isEmpty
            ? Container(
                margin: EdgeInsets.only(top: 50),
                child: Center(child: LoadingDoubleFlipping.square(size: 30, backgroundColor: Colors.red)),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Project Terbaru',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                )),
                            Text(
                              'Dapatkan project sesuai dengan kemampuan anda disini',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        child: Text(
                          '',
                          style: TextStyle(fontSize: 12, color: Color(0xffb16a085)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 5, right: 5, top: 10),
              itemCount: dataProvider.dataRecentProject.length,
              itemBuilder: (context, index) {
                final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
                var harga = dataProvider.dataRecentProject[index].produkharga;
                var hargaFormat = Money.fromInt(harga == null ? 0 : int.parse(harga), IDR);
                return Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, SlideRightRoute(page: WidgetDetailProduk()));
                      dataProvider.getProdukById(dataProvider.dataRecentProject[index].produkid);
                      dataProvider.chekUserBidding(dataProvider.dataRecentProject[index].produkid);
                    },
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Image.network(
                            dataProvider.dataRecentProject[index].produkthumbnail == null
                                ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                                : dataProvider.dataRecentProject[index].produkthumbnail,
                            fit: BoxFit.cover,
                            width: 190,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 190,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  text: TextSpan(
                                      style: TextStyle(color: Colors.grey[800], fontSize: 14, fontWeight: FontWeight.bold), text: dataProvider.dataRecentProject[index].produknama),
                                ),
                                Text(
                                  hargaFormat.toString(),
                                  style: TextStyle(color: Colors.red),
                                ),
                                Text(Jiffy(dataProvider.dataRecentProject[index].produkcreate).fromNow(), style: TextStyle(color: Colors.grey[500], fontSize: 12))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 2,
                  margin: EdgeInsets.all(10),
                );
              }),
        )
      ],
    );
  }
}
