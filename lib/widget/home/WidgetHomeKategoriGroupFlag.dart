import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/KategoriScreenNew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetHomeKategoriGroupFlag extends StatelessWidget {
  WidgetHomeKategoriGroupFlag({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Column(
      children: [
        Container(
          height: 15,
        ),
//        Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: Container(
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Text('PRODUK', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'SUNDAY')),
//                InkWell(
//                  child: Text(
//                    'Semua',
//                    style: TextStyle(fontSize: 12, color: Color(0xffb16a085)),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
        Container(
          height: 95,
          width: MediaQuery.of(context).size.width,
          child: GridView.count(
            scrollDirection: Axis.horizontal,
//            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 1,
            children: List.generate(dataProvider.groupData.length, (j) {
              return Container(
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () => _openKategori(context, dataProvider.groupData[j]),
                      child: new Container(
                          height: 60,
                          width: 60,
                          margin: EdgeInsets.only(bottom: 6, top: 6),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            gradient: new LinearGradient(
                                colors: [Color(0xffb16a085).withOpacity(0.1), Colors.white],
                                begin: const FractionalOffset(7.0, 10.1),
                                end: const FractionalOffset(0.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: new Center(
                            child: Image.network(
                              dataProvider.groupData[j].thumbdnail,
                              fit: BoxFit.cover,
                              width: 40,
                            ),
                          )),
                    ),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      strutStyle: StrutStyle(fontSize: 10.0),
                      text: TextSpan(
                        style: TextStyle(color: Colors.grey[800], fontSize: 12),
                        text: dataProvider.groupData[j].groupNama,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  _openKategori(context, flag) {
    Provider.of<DataProvider>(context).getKategoriByFlag(flag.groupKategoriId);
    Navigator.push(
        context,
        SlideRightRoute(
            page: KategoriScreenNew(
          title: flag.groupNama,
        )));
  }

  openSubkategori(chilrdern) {}
}
