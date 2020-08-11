import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/screen/ProdukDetailScreen.dart';
import 'package:apps/screen/ProdukScreen.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
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
                        'Temukan produk bangunan disini',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    blocProduk.getAllProductByParam({'': ''});
                    Navigator.push(
                        context,
                        SlideRightRoute(
                            page: ProdukScreen(
                          namaKategori: 'Semua',
                        )));
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
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: false,
            physics: new NeverScrollableScrollPhysics(),
            children: List.generate(blocProduk.listRecentProduct.length, (j) {
              final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
              var harga = blocProduk.listRecentProduct.isEmpty ? '0' : blocProduk.listRecentProduct[j].harga;
              var hargaFormat = Money.fromInt(harga == null ? 0 : int.parse(harga), IDR);
              return Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () {
                    blocProduk.getAllProductByParam({'id': blocProduk.listRecentProduct[j].id});
                    Provider.of<BlocOrder>(context).getCart();
                    Navigator.push(context, SlideRightRoute(page: ProdukDetailScreen()));
                  },
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: getPostImages(blocProduk.listRecentProduct[j].foto),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 150,
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.grey[800], fontSize: 9, fontWeight: FontWeight.normal), text: blocProduk.listRecentProduct[j].nama),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          text: hargaFormat.toString()),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          text: TextSpan(
                                              style: TextStyle(color: Colors.grey, fontSize: 7, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
                                              text: blocProduk.listRecentProduct[j].namaToko + ' '),
                                        ),
                                        blocProduk.listRecentProduct.isEmpty
                                            ? Container()
                                            : blocProduk.listRecentProduct[j].jenisToko == 'official_store'
                                                ? Image.asset(
                                                    'assets/icons/verified.png',
                                                    height: 8,
                                                  )
                                                : Container()
                                      ],
                                    ),
                                  ),
                                  SmoothStarRating(
                                    rating: 3,
                                    isReadOnly: true,
                                    color: Colors.amber,
                                    size: 7,
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
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
    var urlImage = 'https://m-bangun.com/api-v2/assets/toko/' + url;
    if (url == null) {
      return SizedBox();
    }
    return Image.network(
      urlImage,
      fit: BoxFit.cover,
      errorBuilder: (context, urlImage, error) {
        print(error.hashCode);
        return Image.asset('assets/logo.png');
      },
    );
  }
}