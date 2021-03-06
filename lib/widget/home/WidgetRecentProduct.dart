import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/screen/ProdukDetailScreen.dart';
import 'package:apps/screen/ProdukScreen.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WidgetRecentProduct extends StatelessWidget {
  WidgetRecentProduct({
    Key key,
    @required this.blocProduk,
  }) : super(key: key);
  final BlocProduk blocProduk;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Produk Terbaru',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          )),
                      Text(
                        'Rekomendasi produk terbaru',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    String currentIdProvinsi = await LocalStorage.sharedInstance.readValue('idProvinsi');
                    String currentIdKota = await LocalStorage.sharedInstance.readValue('idKota');
                    String currentIdKecamatan = await LocalStorage.sharedInstance.readValue('idKecamatan');
                    var param = {
                      'id_kecamatan': currentIdKecamatan.toString() == 'null' ? '' : currentIdKecamatan.toString(),
                      'id_kota': currentIdKota.toString() == 'null' ? '' : currentIdKota.toString(),
                      'id_provinsi': currentIdProvinsi.toString() == 'null' ? '' : currentIdProvinsi.toString(),
                      'aktif': '1',
                      'limit': blocProduk.limit.toString(),
                      'offset': blocProduk.offset.toString()
                    };
                    blocProduk.getAllProductByParam(param);
                    Navigator.push(
                        context,
                        SlideRightRoute(
                            page: ProdukScreen(
                              namaKategori: 'Semua',
                                param: param)));
                  },
                  child: Text(
                    'Semua',
                    style: TextStyle(fontSize: 12, color: Color(0xffb16a085)),
                  ),
                ),
              ],
            ),
          ),
        ),
        blocProduk.isLoading
            ? Container(
                margin: EdgeInsets.only(top: 20),
                height: 200,
                child: PKCardListSkeleton(
                  length: 1,
                ))
            : Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: GridView.count(
                  childAspectRatio: 0.8,
                  crossAxisCount: 3,
                  shrinkWrap: false,
                  physics: new NeverScrollableScrollPhysics(),
                  children: List.generate(blocProduk.listRecentProduct.length, (j) {
                    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
                    var harga = blocProduk.listRecentProduct.isEmpty ? '0' : blocProduk.listRecentProduct[j].harga;
                    var hargaFormat = Money.fromInt(harga == null ? 0 : int.parse(harga), IDR);
                    var avgRating = blocProduk.listRecentProduct[j].avg_rating == null ? 0 : blocProduk.listRecentProduct[j].avg_rating;
                    var jumlahRating = blocProduk.listRecentProduct[j].jumlah_rating == null ? '0' : blocProduk.listRecentProduct[j].jumlah_rating;
                    return Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        onTap: () {
                          blocProduk.getDetailProductByParam({'id': blocProduk.listRecentProduct[j].id, 'aktif': '1'});
                          blocProfile.getCityParam({'id': blocProduk.listRecentProduct[j].idKota.toString()});
                    blocOrder.getUlasanProduByParam({'id_produk': blocProduk.listRecentProduct[j].id});
                    Navigator.push(context, SlideRightRoute(page: ProdukDetailScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: getPostImages(blocProduk.listRecentProduct[j].foto),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 100,
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 12), text: blocProduk.listRecentProduct[j].nama),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          text: hargaFormat.toString()),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        blocProduk.listRecentProduct.isEmpty
                                            ? Container()
                                            : blocProduk.listRecentProduct[j].jenisToko == 'official_store'
                                                ? Image.asset(
                                                    'assets/icons/verified.png',
                                                    height: 10,
                                                  )
                                                : Container(),
                                        Container(
                                          margin: EdgeInsets.only(left: 2),
                                          width: MediaQuery.of(context).size.width * 0.20,
                                          child: RichText(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            text: TextSpan(
                                                style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
                                                text: blocProduk.listRecentProduct[j].namaToko + ' '),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Row(
                                    children: [
                                      SmoothStarRating(
                                        rating: double.parse(avgRating.toString()),
                                        isReadOnly: true,
                                        color: Colors.amber,
                                        size: 8,
                                        borderColor: Colors.grey,
                                        filledIconData: Icons.star,
                                        halfFilledIconData: Icons.star_half,
                                        defaultIconData: Icons.star_border,
                                        starCount: 5,
                                        allowHalfRating: true,
                                        spacing: 2.0,
                                        onRated: (value) {
                                          print("rating value -> $value");
                                          // print("rating value dd -> ${value.truncate()}");
                                        },
                                      ),
                                      SizedBox(width: 2,),
                                      Text('($jumlahRating)', style: TextStyle(fontSize: 9, color: Colors.grey),)
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                elevation: 2,
                margin: EdgeInsets.all(10),
              );
            }),
          ),
        ),
      ],
    );
  }

  getPostImages(String url) {
    var urlImage = baseURL + '/' + pathBaseUrl + '/assets/toko/' + url;
    if (url == null) {
      return SizedBox();
    }
    return Image.network(
      urlImage,
      fit: BoxFit.cover,
      errorBuilder: (context, urlImage, error) {
        print(error.hashCode);
        return Image.network(baseURL + '/' + pathBaseUrl + '/assets/toko/No-image-found.jpg');
      },
    );
  }
}
