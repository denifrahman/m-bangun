import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/widget/home/WidgetGridKategori.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetKategori extends StatelessWidget {
  WidgetKategori({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.182,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            child: Container(
              margin: EdgeInsets.only(top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Selamat Datang.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            )),
                        Text(
                          'Semua yang anda butuhkan untuk membangun rumah impian anda ada disini!',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 12, color: Color(0xffb16a085)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          WidgetGridKategori(blocProduk: blocProduk),
        ],
      ),
    );
  }
}
