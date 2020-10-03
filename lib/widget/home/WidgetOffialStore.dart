import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/screen/DetailTokoScreen.dart';
import 'package:flutter/material.dart';

class WidgetOffialStore extends StatelessWidget {
  const WidgetOffialStore({
    Key key,
    @required this.blocProduk,
  }) : super(key: key);

  final BlocProduk blocProduk;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Official Toko',
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
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: GridView.count(
            scrollDirection: Axis.horizontal,
            crossAxisCount: 1,
            children: List.generate(blocProduk.listOfficialStore.length, (j) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                  onTap: () {
                    blocProduk.getDetailStore(blocProduk.listOfficialStore[j].id);
                    _detailToko(context, blocProduk.listOfficialStore[j]);
                  },
                  child: new ClipOval(
                    child: new Center(
                      child: Image.network(
                        baseURL + '/api-v2/assets/toko/' + blocProduk.listOfficialStore[j].foto,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, urlImage, error) {
                          print(error.hashCode);
                          return Image.asset(
                            'assets/logo.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
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
