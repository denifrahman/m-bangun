import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/KategoriScreen.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:apps/screen/SubKategoriScreen.dart';
import 'package:flushbar/flushbar.dart';
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
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: dataProvider.dataKategoriGroupByFlag.length,
            padding: EdgeInsets.only(top: 10),
            itemBuilder: (context, i) {
              print(dataProvider.dataKategoriGroupByFlag[i].chilrdern.isEmpty);
              return Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(dataProvider.dataKategoriGroupByFlag[i].flag.toUpperCase(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'SUNDAY')),
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
                  dataProvider.dataKategoriGroupByFlag[i].chilrdern.isEmpty
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Center(child: LoadingDoubleFlipping.square(size: 30, backgroundColor: Colors.red)),
                        )
                      : Container(
                          height: 95,
                          margin: EdgeInsets.only(top: 25),
                          width: MediaQuery.of(context).size.width,
                          child: GridView.count(
                            scrollDirection: Axis.horizontal,
//                            shrinkWrap: true,
                            primary: true,
//                            physics: new NeverScrollableScrollPhysics(),
                            crossAxisCount: 1,
                            children: List.generate(dataProvider.dataKategoriGroupByFlag[i].chilrdern.length, (j) {
                              print(dataProvider.dataKategoriFlag[j].produkkategorithumbnail);
                              return Container(
                                child: Column(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () => openSubkategori(dataProvider.dataKategoriGroupByFlag[i].chilrdern[j]),
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
                                              dataProvider.dataKategoriGroupByFlag[i].chilrdern[j].produkkategorithumbnail == null
                                                  ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                                                  : dataProvider.dataKategoriGroupByFlag[i].chilrdern[j].produkkategorithumbnail,
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
                                        text: dataProvider.dataKategoriGroupByFlag[i].chilrdern[j].produkkategorinama,
                                      ),
                                    ),
//                                    Text(
//
//                                      style: TextStyle(fontSize: 13),
//                                    )
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                ],
              );
            }),
//        Container(
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Text('Proyek', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'SUNDAY')),
//              InkWell(
//                onTap: () => {_openKategori()},
//                child: Text(
//                  'Semua',
//                  style: TextStyle(fontSize: 12, color: Color(0xffb16a085)),
//                ),
//              ),
//            ],
//          ),
//        ),
//        dataProvider.dataKategoriFlagProyek.isEmpty
//            ? Container(
//                margin: EdgeInsets.only(top: 20),
//                child: Center(child: LoadingDoubleFlipping.square(size: 30, backgroundColor: Colors.red)),
//              )
//            : Container(
//                height: 220,
//                margin: EdgeInsets.only(top: 25),
//                width: MediaQuery.of(context).size.width,
//                child: GridView.count(
//                  shrinkWrap: true,
//                  primary: true,
//                  physics: new NeverScrollableScrollPhysics(),
//                  crossAxisCount: 3,
//                  children: List.generate(dataProvider.dataKategoriFlagProyek.length, (index) {
//                    return Container(
//                      child: Column(
//                        children: <Widget>[
//                          InkWell(
//                            onTap: () => openSubkategori(dataProvider.dataKategoriFlagProyek[index]),
//                            child: new Container(
//                                height: 60,
//                                width: 60,
//                                margin: EdgeInsets.only(bottom: 6),
//                                decoration: new BoxDecoration(
//                                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                                  gradient: new LinearGradient(
//                                      colors: [Color(0xffb16a085).withOpacity(0.1), Colors.white],
//                                      begin: const FractionalOffset(7.0, 10.1),
//                                      end: const FractionalOffset(0.0, 0.0),
//                                      stops: [0.0, 1.0],
//                                      tileMode: TileMode.clamp),
//                                ),
//                                child: new Center(
//                                  child: Image.network(
//                                    dataProvider.dataKategoriFlagProyek[index].produkkategorithumbnail == null
//                                        ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
//                                        : dataProvider.dataKategoriFlagProyek[index].produkkategorithumbnail,
//                                    fit: BoxFit.cover,
//                                    width: 40,
//                                  ),
//                                )),
//                          ),
//                          Text(
//                            dataProvider.dataKategoriFlagProyek[index].produkkategorinama,
//                            style: TextStyle(fontSize: 13),
//                          )
//                        ],
//                      ),
//                    );
//                  }),
//                ),
//              ),
//        Container(height: 20,),
//        Container(
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Text('Toko', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,fontFamily: 'SUNDAY')),
//              InkWell(
//                onTap: () => {_openKategori()},
//                child: Text(
//                  'Semua',
//                  style: TextStyle(fontSize: 12,  color: Color(0xffb16a085)),
//                ),
//              ),
//            ],
//          ),
//        ),
//        dataProvider.dataKategoriFlaToko.isEmpty
//            ? Container(
//                margin: EdgeInsets.only(top: 20),
//                child: Center(child: LoadingDoubleFlipping.square(size: 30, backgroundColor: Colors.red)),
//              )
//            : Container(
//                height: 220,
//                margin: EdgeInsets.only(top: 25),
//                width: MediaQuery.of(context).size.width,
//                child: GridView.count(
//                  shrinkWrap: true,
//                  primary: true,
//                  physics: new NeverScrollableScrollPhysics(),
//                  crossAxisCount: 3,
//                  children: List.generate(dataProvider.dataKategoriFlaToko.length, (index) {
//                    return Container(
//                      child: Column(
//                        children: <Widget>[
//                          InkWell(
//                            onTap: () => openSubkategori(dataProvider.dataKategoriFlaToko[index]),
//                            child: new Container(
//                                height: 60,
//                                width: 60,
//                                margin: EdgeInsets.only(bottom: 6),
//                                decoration: new BoxDecoration(
//                                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                                  gradient: new LinearGradient(
//                                      colors: [Color(0xffb16a085).withOpacity(0.1), Colors.white],
//                                      begin: const FractionalOffset(7.0, 10.1),
//                                      end: const FractionalOffset(0.0, 0.0),
//                                      stops: [0.0, 1.0],
//                                      tileMode: TileMode.clamp),
//                                ),
//                                child: new Center(
//                                  child: Image.network(
//                                    dataProvider.dataKategoriFlaToko[index].produkkategorithumbnail == null
//                                        ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
//                                        : dataProvider.dataKategoriFlaToko[index].produkkategorithumbnail,
//                                    fit: BoxFit.cover,
//                                    width: 40,
//                                  ),
//                                )),
//                          ),
//                          Text(
//                            dataProvider.dataKategoriFlaToko[index].produkkategorinama,
//                            style: TextStyle(fontSize: 13),
//                          )
//                        ],
//                      ),
//                    );
//                  }),
//                ),
//              )
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
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    dataProvider.getSubKategoriByIdKategori(param.produkkategoriid);
    if (param.produkkategoriflag == 'toko') {
      Navigator.push(
          context,
          SlideRightRoute(
              page: SubKategoriScreen(
            namaKategori: param.produkkategorinama,
          )));
    } else {
      print(dataProvider.isLogin);
      if (dataProvider.isLogin) {
        if (dataProvider.userKategori == param.produkkategorinama) {
          Navigator.push(
              context,
              SlideRightRoute(
                  page: SubKategoriScreen(
                    namaKategori: param.produkkategorinama,
                  )));
        } else {
          Flushbar(
            title: "Error",
            message: "Silahkan login / member anda tidak sesuai",
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            flushbarPosition: FlushbarPosition.BOTTOM,
            icon: Icon(
              Icons.assignment_turned_in,
              color: Colors.white,
            ),
          )
            ..show(context);
        }
      } else {
        Navigator.push(context, SlideRightRoute(page: LoginScreen()));
      }
    }
  }
}
