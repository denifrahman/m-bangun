import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/screen/DetailTokoScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetSlider extends StatelessWidget {
  const WidgetSlider({
    Key key,
    @required this.blocProduk,
  }) : super(key: key);

  final BlocProduk blocProduk;

  @override
  Widget build(BuildContext context) {
    return blocProduk.isLoading
        ? Container(
            margin: EdgeInsets.only(top: 20),
            height: 150,
            child: PKCardPageSkeleton(
              totalLines: 2,
            ))
        : Container(
            margin: EdgeInsets.only(top: 15),
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: 180,
            child: CarouselSlider(
              options: CarouselOptions(aspectRatio: 2.5, autoPlay: true, enlargeCenterPage: true, autoPlayInterval: Duration(milliseconds: 5000)),
              items: blocProduk.listIklan.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () async {
                        if (i.link == null || i.link == '') {
                          blocProduk.getDetailStore(i.idToko);
                          Navigator.push(
                              context,
                              SlideRightRoute(
                                  page: DetailTokoScreen(
                                id: i.idToko,
                                image: i.baner,
                              )));
                        } else {
                    if (await canLaunch(i.link.toString())) {
                      await launch(i.link.toString());
                    } else {
                      throw 'Could not launch';
                    }
                  }
                },
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.75,
                    child: Image.network(
                      baseURL + '/' + pathBaseUrl + '/assets/iklan/' + i.baner,
                      fit: BoxFit.cover,
                      errorBuilder: (context, urlImage, error) {
                        print(error.hashCode);
                        return Image.asset('assets/logo.png');
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  void _detailToko(context, param) {
    Navigator.push(
        context,
        SlideRightRoute(
            page: DetailTokoScreen(
              id: param.id,
              image: param.fotoSampul,
            )));
  }

  void _openDetailToko(context) {
    Navigator.push(context, SlideRightRoute(page: DetailTokoScreen()));
  }
}
