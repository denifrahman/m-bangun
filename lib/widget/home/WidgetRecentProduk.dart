import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:apps/screen/SubKategoriScreen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

class WidgetRecentProduk extends StatelessWidget {
  WidgetRecentProduk({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Column(
      children: <Widget>[
        dataProvider.dataRecentProduk.isEmpty
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
                            Text('Toko',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                )),
                            Text(
                              'Dapatkan bahan bangunan berkualitas',
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
          height: 80,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 5, right: 5, top: 10),
              itemCount: dataProvider.dataRecentProduk.length,
              itemBuilder: (context, index) {
                MaterialColor _mc = RandomColor()
                    .randomMaterialColor(colorHue: ColorHue.custom(Range.staticValue(HSLColor.fromColor(Color(0xfff19066)).hue.toInt())), colorSaturation: ColorSaturation.random);
                return Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    onTap: () async {
                      DataProvider dataProvider = Provider.of<DataProvider>(context);
                      if (dataProvider.isLogin) {
                        Navigator.push(
                            context,
                            SlideRightRoute(
                                page: SubKategoriScreen(
                              flag: dataProvider.dataRecentProduk[index].produkkategoriflag,
                              namaKategori: dataProvider.dataRecentProduk[index].produkkategorinama,
                            )));
                      } else {
                        Navigator.push(context, SlideRightRoute(page: LoginScreen()));
                      }
                      dataProvider.getSubKategoriByIdKategori(dataProvider.dataRecentProduk[index].produkkategoriid);
                    },
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                              decoration: new BoxDecoration(
                                gradient: new LinearGradient(
                                    colors: [
                                      _mc.shade200,
                                      _mc.shade100,
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
//                              color: _mc.shade50,
                              width: 200,
                              padding: EdgeInsets.all(10),
                              child: Center(
                                  child: Text(
                                dataProvider.dataRecentProduk[index].produkkategorinama,
                                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                              ))),
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
