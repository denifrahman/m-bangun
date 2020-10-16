import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/screen/DetailTokoScreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetIklanTokoLink extends StatelessWidget {
  const WidgetIklanTokoLink({
    Key key,
    @required this.blocProduk,
  }) : super(key: key);

  final BlocProduk blocProduk;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 35),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Official Brand',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        )),
                    Text(
                      '',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width,
          height: 85,
          child: GridView.count(
            scrollDirection: Axis.horizontal,
            crossAxisCount: 1,
            children: List.generate(blocProduk.listIklanTokoLink.length, (j) {
              return Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    child: Container(
                      child: ClipOval(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () async {
                            if (await canLaunch(blocProduk.listIklanTokoLink[j].link.toString())) {
                              await launch(blocProduk.listIklanTokoLink[j].link.toString());
                            } else {
                              throw 'Could not launch';
                            }
                          },
                          child: new Center(
                            child: Image.network(
                              baseURL + '/' + pathBaseUrl + '/assets/iklan/' + blocProduk.listIklanTokoLink[j].thumbnail,
                              height: 75,
                              width: 75,
                              fit: BoxFit.cover,
                              errorBuilder: (context, urlImage, error) {
                                return Image.asset(
                                  'assets/logo.png',
                                  height: 70,
                                  width: 70,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                      ),
                      text: blocProduk.listIklanTokoLink[j].nama,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
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
}
