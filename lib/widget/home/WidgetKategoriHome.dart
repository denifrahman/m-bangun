import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/KategoriScreen.dart';
import 'package:apps/screen/SubKategoriScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';

class WidgetKategoriHome extends StatefulWidget {
  WidgetKategoriHome({Key key}) : super(key: key);

  @override
  _WidgetKategoriHomeState createState() {
    return _WidgetKategoriHomeState();
  }
}

class _WidgetKategoriHomeState extends State<WidgetKategoriHome> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Kategori', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
              InkWell(
                onTap: () => {_openKategori()},
                child: Text(
                  'Semua',
                  style: TextStyle(fontSize: 12, color: Color(0xffb16a085)),
                ),
              ),
            ],
          ),
        ),
        dataProvider.getDataKategori.isEmpty
            ? Container(
          margin: EdgeInsets.only(top: 20),
          child: Center(child: LoadingDoubleFlipping.square(size: 30, backgroundColor: Colors.red)),
        )
            : Container(
            height: 220,
            margin: EdgeInsets.only(top: 25),
            width: MediaQuery.of(context).size.width,
            child: GridView.count(
              shrinkWrap: true,
              primary: true,
              physics: new NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children: List.generate(dataProvider.getDataKategori.length, (index) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () => openSubkategori(dataProvider.getDataKategori[index]),
                        child: new Container(
                            height: 60,
                            width: 60,
                            margin: EdgeInsets.only(bottom: 6),
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
                                dataProvider.getDataKategori[index].produkkategorithumbnail == null
                                    ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                                    : dataProvider.getDataKategori[index].produkkategorithumbnail,
                                fit: BoxFit.cover,
                                width: 40,
                              ),
                            )),
                      ),
                      Text(
                        dataProvider.getDataKategori[index].produkkategorinama,
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                );
              }),
            ))
      ],
    );
  }

  _openKategori() {
    Navigator.push(
      context,
      SlideRightRoute(page: KategoriScreen()),
    );
  }

  void openSubkategori(param) {
    Navigator.push(
        context,
        SlideRightRoute(
            page: SubKategoriScreen(
          idKategori: int.parse(param.produkkategoriid),
          namaKategori: param.produkkategorinama,
        )));
  }
}
