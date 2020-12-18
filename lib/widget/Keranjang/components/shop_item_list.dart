import 'package:flutter_wordpress/flutter_wordpress.dart';
// import 'package:apps/Utils/Modal/circular_modal.dart';
// import 'package:apps/Utils/Modal/floating_modal.dart';
import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/models/Cart.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:flutter/material.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
  var oldValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          child: Image.network(
                            baseURL + '/' + pathBaseUrl + '/assets/toko/' + widget.chilrdern.foto,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        widget.chilrdern.jenisOngkir == 'include_dalam_kota'
                            ? Text(
                                'Free ongkir \ndalam kota',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10, color: Colors.grey),
                              )
                            : widget.chilrdern.jenisOngkir == 'include'
                                ? Text(
                                    'Free ongkir',
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  )
                                : Text('')
                      ],
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
                            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
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
                                style: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              Text(Money.fromInt((int.parse(widget.chilrdern.harga)), IDR).toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              Text('Jumlah', style: TextStyle(color: Colors.grey, fontSize: 12)),
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
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic),
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
                                style: TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              Text(
                                Money.fromInt((int.parse(widget.chilrdern.harga) * int.parse(widget.chilrdern.jumlah)), IDR).toString(),
                                style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 0.0, top: 0, bottom: 49.0),
                      child: Theme(
                          data: ThemeData(
                              accentColor: Colors.black,
                              textTheme: TextTheme(
                                headline: TextStyle(fontFamily: 'Montserrat', fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                body1: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.grey[400],
                                ),
                              )),
                          child: widget.chilrdern.stok == '1'
                              ? Text(
                                  '1',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                )
                              : InkWell(
                                  onTap: () {
                                    blocOrder.setcounterQty(int.parse(widget.chilrdern.jumlah));
                                    // showFloatingModalBottomSheet(
                                    //     context: context,
                                    //     builder: (context) => StatefulBuilder(builder: (context, setState) {
                                    //           return SingleChildScrollView(
                                    //             controller: ModalScrollController.of(context),
                                    //             child: Container(
                                    //               padding: EdgeInsets.all(10),
                                    //               child: Column(
                                    //                 children: [
                                    //                   Text(
                                    //                     'Jumlah',
                                    //                     style: Theme.of(context).textTheme.subtitle1,
                                    //                   ),
                                    //                   Row(
                                    //                     crossAxisAlignment: CrossAxisAlignment.center,
                                    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    //                     children: [
                                    //                       InkWell(
                                    //                         onTap: () {
                                    //                           setState(() {
                                    //                             blocOrder.setcounterQty(blocOrder.counterQty - 1);
                                    //                           });
                                    //                         },
                                    //                         child: Container(
                                    //                           color: int.parse(widget.chilrdern.jumlah) <= 1 ? Colors.grey : Colors.red,
                                    //                           width: 30,
                                    //                           height: 30,
                                    //                           child: Center(
                                    //                               child: Text(
                                    //                             '-',
                                    //                             style: TextStyle(color: Colors.white),
                                    //                           )),
                                    //                         ),
                                    //                       ),
                                    //                       Text(blocOrder.counterQty.toString()),
                                    //                       InkWell(
                                    //                         onTap: () {
                                    //                           setState(() {
                                    //                             blocOrder.setcounterQty(blocOrder.counterQty + 1);
                                    //                           });
                                    //                         },
                                    //                         child: Container(
                                    //                           color: Colors.red,
                                    //                           width: 30,
                                    //                           height: 30,
                                    //                           child: Center(
                                    //                               child: Text(
                                    //                             '+',
                                    //                             style: TextStyle(color: Colors.white),
                                    //                           )),
                                    //                         ),
                                    //                       )
                                    //                     ],
                                    //                   ),
                                    //                   TextButton(
                                    //                       onPressed: () async {
                                    //                         var body = {
                                    //                           'id': widget.chilrdern.id.toString(),
                                    //                           'id_produk': widget.chilrdern.idProduk,
                                    //                           'jumlah': blocOrder.counterQty.toString(),
                                    //                           'harga': widget.chilrdern.harga.toString(),
                                    //                           'subtotal': (int.parse(widget.chilrdern.harga) * blocOrder.counterQty).toString()
                                    //                         };
                                    //                         Navigator.of(context).pop();
                                    //                         var result = await blocOrder.updateCart(body);
                                    //                       },
                                    //                       child: Container(
                                    //                         width: MediaQuery.of(context).size.width * 0.45,
                                    //                           padding: EdgeInsets.all(10),
                                    //                           decoration: BoxDecoration(
                                    //                             color: Colors.cyan[800],
                                    //                                 borderRadius: BorderRadius.all(Radius.circular(10))
                                    //                           ),
                                    //                           child: Center(child: Text('Simpan',style: TextStyle(color: Colors.white),))))
                                    //                 ],
                                    //               ),
                                    //             ),
                                    //           );
                                    //         })).then((value) {
                                    //   blocOrder.getCart(Provider.of<BlocAuth>(context).idUser);
                                    // });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(widget.chilrdern.jumlah),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.edit,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                )),
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
