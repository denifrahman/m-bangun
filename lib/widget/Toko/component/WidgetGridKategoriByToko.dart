import 'package:apps/providers/BlocProduk.dart';
import 'package:flutter/material.dart';

class WidgetGridKategoriByToko extends StatelessWidget {
  const WidgetGridKategoriByToko({
    Key key,
    @required this.blocProduk,
  }) : super(key: key);

  final BlocProduk blocProduk;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: GridView.count(
        scrollDirection: Axis.horizontal,
//            physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 1,
        children: List.generate(blocProduk.listCategoryByToko.length, (j) {
          return Container(
            child: Column(
              children: <Widget>[
                InkWell(
//                  onTap: () => _openKategori(context, dataProvider.groupData[j]),
                  child: new Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.only(bottom: 5, top: 0),
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
                      child: Image.asset(
                        'assets/kategori/' + blocProduk.listCategoryByToko[j].icon,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                    text: blocProduk.listCategoryByToko[j].nama,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
