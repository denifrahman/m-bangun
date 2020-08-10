import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/screen/ProdukDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WidgetProdukTerjual extends StatelessWidget {
  WidgetProdukTerjual({
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
                      Text('Produk Terjual',
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
          height: MediaQuery.of(context).size.height * 0.35,
          child: GridView.count(
            crossAxisCount: 1,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              blocProduk.listProdukTerjual.isEmpty ? 1 : blocProduk.listProdukTerjual.length,
                  (j) {
                if (blocProduk.listProdukTerjual.isEmpty) {
                  return Center(
                    child: Text('Tidak ada data'),
                  );
                } else {
                  return Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      onTap: () {
                        blocProduk.getProductById(blocProduk.listRecentProduct[j].id);
                        Provider.of<BlocOrder>(context).getCart();
                        Navigator.push(context, SlideRightRoute(page: ProdukDetailScreen()));
                      },
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: getPostImages(blocProduk.listProdukTerjual[j].foto),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 150,
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.grey[800], fontSize: 14, fontWeight: FontWeight.normal), text: blocProduk.listProdukTerjual[j].nama),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.normal), text: blocProduk.listProdukTerjual[j].namaToko),
                                    ),
                                  ),
                                  SmoothStarRating(
                                    rating: 3,
                                    isReadOnly: true,
                                    size: 10,
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
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  getPostImages(String url) {
    if (url == null) {
      return SizedBox();
    }
    return Image.asset(
      'assets/kategori/' + url,
      fit: BoxFit.cover,
    );
  }
}
