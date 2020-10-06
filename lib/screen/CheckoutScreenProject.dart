import 'dart:convert';

import 'package:apps/Utils/SnapWidgetMidtrans.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/widget/ShippingAddress/WidgetListPembayaran.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CheckoutScreenProject extends StatelessWidget {
  final body;
  final int index;
  final int subtotal;

  CheckoutScreenProject({Key key, this.body, this.subtotal, this.index}) : super(key: key);
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  final RoundedLoadingButtonController _btnControllerMetodeBayar = new RoundedLoadingButtonController();
  final RoundedLoadingButtonController _btnControllerALamatPenerima = new RoundedLoadingButtonController();
  final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int totalDalamKota = 0;
  int totalRajaOngkir = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    AppBar appBar = AppBar(
      elevation: 0,
      title: Text('Checkout Proyek'),
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      body: ModalProgressHUD(
        inAsyncCall: false,
        child: Column(
          children: [
            Container(
              height: (MediaQuery.of(context).size.height * 0.9 - appBar.preferredSize.height) - MediaQuery.of(context).padding.top,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      Container(
                        color: blocOrder.listMetodePembayaranSelected.isEmpty ? Colors.red.withOpacity(0.2) : Colors.white,
                        margin: const EdgeInsets.only(top: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text('Metode Pembayaran'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  blocOrder.listMetodePembayaranSelected.isEmpty ? '-' : blocOrder.listMetodePembayaranSelected['metode_pembayaran'],
                                ),
                                Text(blocOrder.listMetodePembayaranSelected.isEmpty ? '' : blocOrder.listMetodePembayaranSelected['nama_bank'],
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                            leading: Icon(FontAwesomeIcons.creditCard),
                            trailing: Container(
                              height: 30,
                              width: 80,
                              margin: const EdgeInsets.only(top: 10.0),
//                                  padding: const EdgeInsets.only(left: 90.0, right: 20.0),
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                      child: RoundedLoadingButton(
                                    child: Text('Ubah', style: TextStyle(color: Colors.white, fontSize: 12)),
                                    color: Colors.cyan[700],
                                    controller: _btnControllerMetodeBayar,
                                    onPressed: () {
                                      blocProfile.getAllUserAddress(blocAuth.idUser);
                                      blocOrder.getMetodePembayaran();
                                      Navigator.push(context, SlideRightRoute(page: WidgetListPembayaran())).then((value) {
                                        Provider.of<BlocProfile>(context).getUserAddressDefault(blocAuth.idUser);
                                        _btnControllerMetodeBayar.reset();
                                      });
                                      print('stop');
                                    },
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            'Subtotal',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                        Container(
                          child: Text(
                            Money.fromInt((this.subtotal), IDR).toString(),
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Text('Bayar', style: TextStyle(color: Colors.white, fontSize: 18)),
                        color: Colors.green,
                        onPressed: () {
                          if (blocOrder.listMetodePembayaranSelected.isNotEmpty) {
                            makePayment(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void makePayment(context) {
    var dataPost = json.decode(body);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    var phoneNumber = '';
    if (blocOrder.listMetodePembayaranSelected['kode'] == 'permata_va') {
      phoneNumber = blocAuth.currentUserLogin['no_hp'].toString().substring(2);
    } else {
      phoneNumber = blocAuth.currentUserLogin['no_hp'].toString();
    }

    var no_order = "PROJ-" + dataPost['no_order'].toString();
    var bodyPayment = {
      "enabled_payments": [blocOrder.listMetodePembayaranSelected['kode'].toString().toLowerCase()],
      blocOrder.listMetodePembayaranSelected['kode'].toString().toLowerCase(): {"va_number": phoneNumber},
      "transaction_details": {"order_id": no_order.toString(), "gross_amount": this.subtotal.toString()},
      "item_details": [
        {"id": '1', "price": this.subtotal.toString(), "quantity": "1", "name": "Pembayaran Survey"}
      ],
      "expiry": {"start_time": "${Jiffy(DateTime.now()).format("yyyy-MM-dd HH:mm:ss")} +0700", "duration": 120, "unit": "minute"},
      "customer_details": {
        "first_name": blocAuth.currentUser.displayName.toString(),
        "last_name": "",
        "email": blocAuth.currentUser.email.toString(),
        "phone": blocAuth.currentUserLogin['no_hp'].toString(),
      }
    };
    var data = json.encode(bodyPayment);
//    print(data);
    var result = blocOrder.makePayment(data);
    result.then((value) {
      dataPost['token_va'] = value['token'];
      dataPost['no_order'] = no_order;
      dataPost['duration'] = '120';
      dataPost['unit'] = 'minute';
      if (value['token'] != null) {
        Map bodyPost = {'data': json.encode(dataPost)};
//        print(bodyPost);
        Navigator.push(
            context,
            SlideRightRoute(
                page: SnapWidgetMidtrans(
              urlSnap: value['redirect_url'],
              tokenSnap: value['token'],
              param: 'project',
              bodyTransaction: bodyPost,
            )));
//        var param = {
//          'id': dataPost['no_order'].toString(),
//        };
//        blocOrder.getProjectByOrder(param);
      }
    });
  }

  void _showToast(String message, Color color) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(seconds: 3),
    ));
  }
}
