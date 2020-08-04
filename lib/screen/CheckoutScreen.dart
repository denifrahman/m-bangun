import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/Cart.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/screen/ShippingAddressScreen.dart';
import 'package:apps/widget/ShippingAddress/WidgetListCourier.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CheckoutScreen extends StatelessWidget {
  final Cart listCart;
  final int subtotal;

  CheckoutScreen({Key key, this.listCart, this.subtotal}) : super(key: key);
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    AppBar appBar = AppBar(
      elevation: 0,
      title: Text('Checkout'),
    );
    return Scaffold(
      appBar: appBar,
      body: blocProfile.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  height: (MediaQuery.of(context).size.height * 0.9 - appBar.preferredSize.height) - MediaQuery.of(context).padding.top,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(top: 10.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(listCart.flag, style: TextStyle(fontSize: 12)),
                                subtitle: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Dikirim dari ',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    Text(blocProfile.listSubDistrictById[0].city, style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                                leading: Image.asset(
                                  'assets/icons/store.png',
                                  height: 35,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(top: 10.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text('Tujuan Pengiriman', style: TextStyle(fontSize: 12)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('#' + blocProfile.listUserAddress[0].namaPenerima + ' ' + '(' + blocProfile.listUserAddress[0].namaAlamat + ')',
                                        style: TextStyle(fontSize: 10)),
                                    Text(blocProfile.listUserAddress[0].alamatLengkap, style: TextStyle(fontSize: 10)),
                                    Container(
                                      height: 35,
                                      margin: const EdgeInsets.only(top: 10.0),
                                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                      child: new Row(
                                        children: <Widget>[
                                          new Expanded(
                                              child: RoundedLoadingButton(
                                            child: Text('ubah alamat', style: TextStyle(color: Colors.white, fontSize: 12)),
                                            color: Colors.amber[700],
                                            controller: _btnController,
                                            onPressed: () {
                                              blocProfile.getUserAddress(blocAuth.idUser);
                                              Navigator.push(context, SlideRightRoute(page: ShippingAddressScreen())).then((value) {
                                                Provider.of<BlocProfile>(context).getSubDistrictById(listCart.chilrdern[0].idKecamatan);
                                              });
                                              _btnController.reset();
                                            },
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                leading: Icon(FontAwesomeIcons.addressBook),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(top: 10.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text('Jasa Expedisi', style: TextStyle(fontSize: 12)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('JNT #REG', style: TextStyle(fontSize: 10)),
                                    Text('13.000', style: TextStyle(fontSize: 10)),
                                    Container(
                                      height: 35,
                                      margin: const EdgeInsets.only(top: 10.0),
                                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                      child: new Row(
                                        children: <Widget>[
                                          new Expanded(
                                              child: RoundedLoadingButton(
                                            child: Text('Pilih', style: TextStyle(color: Colors.white, fontSize: 12)),
                                            color: Colors.amber[700],
                                            controller: _btnController,
                                            onPressed: () {
                                              blocProfile.getUserAddress(blocAuth.idUser);
                                              Navigator.push(context, SlideRightRoute(page: WidgetLisCourier())).then((value) {
                                                Provider.of<BlocProfile>(context).getSubDistrictById(listCart.chilrdern[0].idKecamatan);
                                              });
                                              _btnController.reset();
                                            },
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                leading: Icon(FontAwesomeIcons.carAlt),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(top: 10.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text('Metode Pembayaran', style: TextStyle(fontSize: 12)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('JNT #REG', style: TextStyle(fontSize: 10)),
                                    Text('13.000', style: TextStyle(fontSize: 10)),
                                    Container(
                                      height: 35,
                                      margin: const EdgeInsets.only(top: 10.0),
                                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                      child: new Row(
                                        children: <Widget>[
                                          new Expanded(
                                              child: RoundedLoadingButton(
                                            child: Text('Pilih', style: TextStyle(color: Colors.white)),
                                            color: Colors.amber[700],
                                            controller: _btnController,
                                            onPressed: () {
                                              blocProfile.getUserAddress(blocAuth.idUser);
                                              Navigator.push(context, SlideRightRoute(page: WidgetLisCourier())).then((value) {
                                                Provider.of<BlocProfile>(context).getSubDistrictById(listCart.chilrdern[0].idKecamatan);
                                              });
                                              _btnController.reset();
                                            },
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                leading: Icon(FontAwesomeIcons.creditCard),
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
                        Container(
                          child: Text('Subtotal'),
                        ),
                        Container(
                          child: Text(this.subtotal.toString()),
                        ),
                        Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width * 0.4,
//                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: RoundedLoadingButton(
                            child: Text('Bayar', style: TextStyle(color: Colors.white)),
                            color: Colors.cyan[700],
                            controller: _btnController,
                            onPressed: () {
                              blocProfile.getUserAddress(blocAuth.idUser);
                              Navigator.push(context, SlideRightRoute(page: WidgetLisCourier())).then((value) {
                                Provider.of<BlocProfile>(context).getSubDistrictById(listCart.chilrdern[0].idKecamatan);
                              });
                              _btnController.reset();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
