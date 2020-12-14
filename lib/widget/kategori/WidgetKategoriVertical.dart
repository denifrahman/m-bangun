import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/Categories.dart';
import 'package:apps/models/KategoriM.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/screen/ProdukScreen.dart';
import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';

class WidgetKategoriVertical extends StatefulWidget {
  WidgetKategoriVertical({Key key}) : super(key: key);

  @override
  _WidgetKategoriVerticalState createState() {
    return _WidgetKategoriVerticalState();
  }
}

class _WidgetKategoriVerticalState extends State<WidgetKategoriVertical> {
  var dataKategori = new List<KategoriM>();

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
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    return blocProduk.isLoading
        ? SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PKCardPageSkeleton(
                totalLines: 4,
              ),
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            child:GridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              crossAxisCount: 3,
              crossAxisSpacing: 0.2,
              padding: EdgeInsets.all(10),
              children: List.generate(blocProduk.listCategory.length, (j) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () => _openListProduk(context, blocProduk.listCategory[j]),
                        child: new Container(
                          height: 65,
                          width: 65,
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
                            child: Image.network(
                              baseURL + '/' + pathBaseUrl + '/assets/kategori/' + blocProduk.listCategory[j].icon.toString(),
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                      ),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          text: blocProduk.listCategory[j].nama,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          );
  }

  _openListProduk(BuildContext context, Categories listCategory) {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    var param = {'id_kategori': listCategory.id.toString(), 'aktif': '1', 'limit': blocProduk.limit.toString(), 'offset': blocProduk.offset.toString()};
    Provider.of<BlocProduk>(context).getAllProductByParam(param);
    Navigator.push(
        context,
        SlideRightRoute(
            page: ProdukScreen(
              param: param,
              namaKategori: listCategory.nama,
            )));
  }
}
