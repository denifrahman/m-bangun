import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class WidgetViewProduk extends StatelessWidget {
  final String produkNama;
  final String thumbnail;
  final String kab;
  final String prov;
  final String tgl;
  final String harga;

  WidgetViewProduk({Key key, this.produkNama, this.thumbnail, this.kab, this.prov, this.tgl, this.harga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridTile(
          child: Image.network(
            thumbnail == null
                ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                : thumbnail,
            fit: BoxFit.fitHeight,
            // width: 80,
          ),
          footer: Container(
            height: 107,
            color: Colors.black87.withOpacity(0.7),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    strutStyle: StrutStyle(fontSize: 12.0),
                    text: TextSpan(
                      style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                      text: produkNama,
                    ),
                  ),
                  Text(harga, style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.w700)),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.grey,
                            size: 11,
                          ),
                          Text(' '),
                          Text(
                            Jiffy(tgl).fromNow(),
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.place,
                            color: Colors.grey,
                            size: 11,
                          ),
                          Text(' '),
                          Text(kab, style: TextStyle(fontSize: 11, color: Colors.white)),
                          Text(', '),
                          Text(prov, style: TextStyle(fontSize: 11, color: Colors.white))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
