import 'dart:convert';

import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/widget/Tagihan/WidgetTagihan.dart';
import 'package:apps/widget/Tagihan/WidgetTagihanProject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class WidgetWaitingPayment extends StatefulWidget {
  final body;
  final idOrder;
  final param;

  WidgetWaitingPayment({Key key, this.body, this.idOrder, this.param}) : super(key: key);

  @override
  _WidgetWaitingPaymentState createState() => _WidgetWaitingPaymentState();
}

class _WidgetWaitingPaymentState extends State<WidgetWaitingPayment> {
  @override
  void initState() {
    // TODO: implement initState
    createOrder();
    super.initState();
  }

  createOrder() async {
    await new Future.delayed(const Duration(seconds: 2));
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    if (widget.param == 'project') {
      print(widget.body);
      var result = blocOrder.insertProject(widget.body);
      result.then((value) {
        if (value) {
          var param = {
            'no_order': widget.idOrder.toString(),
          };
          blocOrder.getProjectByOrder(param);
          blocOrder.getTransaksiStatus(widget.idOrder);
          Navigator.push(
              context,
              SlideRightRoute(
                  page: WidgetTagihanProject(
                    param: 'checkout',
                  ))).then((value) {});
        }
      });
    } else {
      print('insertToko');
      BlocOrder blocOrder = Provider.of(context);
      var result = blocOrder.insert(json.encode(widget.body));
      result.then((value) {
        print(value);
        if (value['meta']['success']) {
          var param = {
            'id': value['data']['id_order'].toString(),
          };
          blocOrder.getOrderTagihanByParam(param);
          blocOrder.getTransaksiStatus(widget.idOrder);
          Navigator.push(
              context,
              SlideRightRoute(
                  page: WidgetTagihan(
                param: 'checkout',
              ))).then((value) {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Silahkan Ditunggu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitPouringHourglass(
              color: Colors.amber,
              size: 150.0,
//              controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
            ),
            Container(
              child: Text(
                'Sedang diproses . . .',
                style: TextStyle(fontFamily: 'SUNDAY', fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
