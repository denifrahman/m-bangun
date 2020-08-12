import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/Utils/values/colors.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/widget/Toko/component/WidgetAddProduk.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';

class TokoSayaScreen extends StatelessWidget {
  TokoSayaScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    double width = MediaQuery.of(context).size.width;
    AppBar appBar = AppBar(
      elevation: 0,
      title: Text('Kelola Toko'),
    );
    var appBarHeigh = appBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      body: blocProfile.dataToko.isEmpty
          ? Container(
              child: PKCardProfileSkeleton(),
            )
          : SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(0.0),
                          bottomLeft: Radius.circular(0.0),
                        )),
                    height: (MediaQuery.of(context).size.height - appBarHeigh) * 0.15,
                    width: width,
                    child: ListTile(
                      title: Container(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          strutStyle: StrutStyle(fontSize: 12.0),
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.grey[800],
                            ),
                            text: blocProfile.dataToko['nama_toko'],
                          ),
                        ),
                      ),
                      leading: Container(
                        width: 60.0,
                        height: 60.0,
                        child: ClipOval(
                          child: Image.network(
                            blocAuth.currentUser.photoUrl,
                            fit: BoxFit.cover,
                            width: 80,
                          ),
                        ),
                      ),
                      subtitle: Text(blocProfile.dataToko['jenis_toko']),
                    ),
                  ),
                  blocAuth.statusToko != '0'
                      ? Container()
                      : Container(
                          height: (MediaQuery.of(context).size.height - appBarHeigh) * 0.85 - MediaQuery.of(context).padding.top,
                          child: SingleChildScrollView(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                onRefresh(context);
                              },
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          subheading('Produk Saya'),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context, SlideRightRoute(page: WidgetAddToko())).then((value) {
                                                blocProduk.getAllProductByParam({'id_toko': blocAuth.idToko.toString()});
                                              });
                                            },
                                            child: CircleAvatar(
                                              radius: 25.0,
                                              backgroundColor: AppColors.mainColor,
                                              child: Icon(
                                                Icons.add_circle,
                                                size: 20.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: (MediaQuery.of(context).size.height - appBarHeigh) * 0.8 - MediaQuery.of(context).padding.top - 20,
                                      child: ListView.builder(
                                          padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                                          itemCount: blocProduk.listProducts.length,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              child: ListTile(
                                                leading: Image.network(
                                                  'https://m-bangun.com/api-v2/assets/toko/' + blocProduk.listProducts[index].foto,
                                                  width: 40,
                                                  height: 40,
                                                  errorBuilder: (context, urlImage, error) {
                                                    print(error.hashCode);
                                                    return Image.asset(
                                                      'assets/logo.png',
                                                      width: 40,
                                                      height: 40,
                                                    );
                                                  },
                                                ),
                                                title: Text(blocProduk.listProducts[index].nama),
                                                subtitle: Row(
                                                  children: [
                                                    Text(
                                                      Money.fromInt(int.parse(blocProduk.listProducts[index].harga.toString()), IDR).toString(),
                                                      style: TextStyle(fontSize: 11),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Stok : ' + blocProduk.listProducts[index].stok,
                                                      style: TextStyle(fontSize: 11),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(color: AppColors.kDarkBlue, fontSize: 20.0, fontWeight: FontWeight.w700, letterSpacing: 1.2),
    );
  }

  void onRefresh(BuildContext context) {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    blocProfile.getTokoByParam({'id_user': blocAuth.idUser.toString()});
    blocProduk.getAllProductByParam({'id_toko': blocAuth.idToko.toString()});
  }
}
