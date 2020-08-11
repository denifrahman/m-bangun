import 'package:apps/models/Cart.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

const List<BoxShadow> shadow = [BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)];

class ShopItemList extends StatefulWidget {
  final Function onRemove;
  final int index;
  ChilrdernBean chilrdern;

  ShopItemList({Key key, this.onRemove, this.index, this.chilrdern}) : super(key: key);

  @override
  _ShopItemListState createState() => _ShopItemListState();
}

class _ShopItemListState extends State<ShopItemList> {
  int quantity = 1;
  final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');

  @override
  Widget build(BuildContext context) {
    BlocOrder blocOrder = Provider.of(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        child: Container(
          color: Colors.white38,
          child: Column(
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      child: Image.network(
                        'https://m-bangun.com/api-v2/assets/toko/' + widget.chilrdern.foto,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          margin: EdgeInsets.only(top: 0),
                          child: Text(
                            widget.chilrdern.nama,
                            maxLines: 1,
                            style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Harga ',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Text(Money.fromInt((int.parse(widget.chilrdern.harga)), IDR).toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              Text('Jumlah', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                            onChanged: (value) {
                              var body = {
                                'id': widget.chilrdern.id,
                                'id_produk': widget.chilrdern.idProduk,
                                'catatan': value,
                                'jumlah': widget.chilrdern.jumlah.toString(),
                                'harga': widget.chilrdern.harga.toString(),
                                'subtotal': widget.chilrdern.subtotal
                              };
                              blocOrder.updateCart(body);
                            },
                            initialValue: widget.chilrdern.catatan,
                            style: TextStyle(fontSize: 11),
                            maxLines: 2,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: 'Catatan untuk penjual',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 11, fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal',
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              Text(
                                Money.fromInt((int.parse(widget.chilrdern.harga) * int.parse(widget.chilrdern.jumlah)), IDR).toString(),
                                style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 0.0, top: 0, bottom: 55.0),
                      child: Theme(
                        data: ThemeData(
                            accentColor: Colors.black,
                            textTheme: TextTheme(
                              headline: TextStyle(fontFamily: 'Montserrat', fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                              body1: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                                color: Colors.grey[400],
                              ),
                            )),
                        child: NumberPicker.integer(
                          initialValue: int.parse(widget.chilrdern.jumlah),
                          minValue: 1,
                          maxValue: 10,
                          onChanged: (value) {
                            var body = {
                              'id': widget.chilrdern.id.toString(),
                              'id_produk': widget.chilrdern.idProduk,
                              'jumlah': value.toString(),
                              'harga': widget.chilrdern.harga.toString(),
                              'subtotal': (int.parse(widget.chilrdern.harga) * value).toString()
                            };
                            blocOrder.updateCart(body);
                          },
                          itemExtent: 30,
                          listViewWidth: 30,
                        ),
                      ),
                    ),
                    Container(
                        child: InkWell(
                            onTap: () {
                              widget.onRemove();
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            )))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}