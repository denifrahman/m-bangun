import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';

class WidgetHeaderDetailProduct extends StatelessWidget {
  const WidgetHeaderDetailProduct({
    Key key,
    @required this.blocProduk,
    @required this.blocOrder,
    @required this.IDR,
  }) : super(key: key);

  final BlocProduk blocProduk;
  final BlocOrder blocOrder;
  final Currency IDR;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Container(
                    child: Text(
                      Money.fromInt((int.parse(blocProduk.detailProduct[0].harga) * blocOrder.jumlah), IDR).toString(),
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Text(
                      blocProduk.detailProduct[0].nama,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 12,
                            ),
                            Text(' 4.3', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600)),
                            Text(' (30)', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.grey,
                        ),
                        Row(
                          children: [
                            Text('Terjual   ', style: TextStyle(color: Colors.black, fontSize: 12)),
                            Text('100', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.grey,
                        ),
                        Text(
                          'Disukai',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(color: Colors.white, child: Divider()),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Dijual oleh ', style: TextStyle(fontSize: 11)),
                      Text(blocProduk.detailProduct[0].namaToko, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'assets/icons/verified.png',
                        height: 12,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}