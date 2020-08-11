import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/Cart.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/screen/ShippingAddressScreen.dart';
import 'package:apps/widget/Invoice/WidgetWaitingPayment.dart';
import 'package:apps/widget/ShippingAddress/WidgetListCourier.dart';
import 'package:apps/widget/ShippingAddress/WidgetListPembayaran.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money2/money2.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CheckoutScreen extends StatelessWidget {
  final Cart listCart;
  final int subtotal;

  CheckoutScreen({Key key, this.listCart, this.subtotal}) : super(key: key);
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    AppBar appBar = AppBar(
      elevation: 0,
      title: Text('Checkout'),
    );
    return Scaffold(
      key: _scaffoldKey,
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
                          title: Text(listCart.flag, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dikirim dari ',
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(blocProfile.listSubDistrictById.isEmpty ? '' : blocProfile.listSubDistrictById[0].city, style: TextStyle(fontSize: 10)),
                            ],
                          ),
                          leading: Image.network(
                            'https://m-bangun.com/api-v2/assets/toko/' + listCart.chilrdern[0].fotoToko,
                            width: 40,
                            height: 80,
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
                          title: Text('Alamat Penerima', style: TextStyle(fontSize: 12)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        blocProfile.listUserAddressDefault.isEmpty
                                            ? ''
                                            : '#' + blocProfile.listUserAddressDefault[0].namaPenerima + ' ' + '(' + blocProfile.listUserAddressDefault[0].namaAlamat + ')',
                                        style: TextStyle(fontSize: 10)),
                                    Text(blocProfile.listUserAddressDefault.isEmpty ? '' : blocProfile.listUserAddressDefault[0].alamatLengkap, style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                          leading: Icon(FontAwesomeIcons.addressBook),
                          trailing: Container(
                            height: 30,
                            width: 80,
                            child: new Row(
                              children: <Widget>[
                                new Expanded(
                                    child: RoundedLoadingButton(
                                      child: Text('Ubah', style: TextStyle(color: Colors.white, fontSize: 12)),
                                      color: Colors.cyan[700],
                                      controller: _btnController,
                                      onPressed: () {
                                        blocProfile.getAllUserAddress(blocAuth.idUser);
                                        Navigator.push(context, SlideRightRoute(page: ShippingAddressScreen())).then((value) {
                                          Provider.of<BlocProfile>(context).getSubDistrictById(listCart.chilrdern[0].idKecamatan);
                                            Provider.of<BlocProfile>(context).getUserAddressDefault(blocAuth.idUser);
                                            blocOrder.clearCost();
                                            int total = 0;
                                            for (var k = 0; k < this.listCart.chilrdern.length; k++) {
                                              var beratTotal = int.parse(this.listCart.chilrdern[k].berat.toString()) * int.parse(this.listCart.chilrdern[k].jumlah.toString());
                                              total += beratTotal;
                                            }
                                            var param = {
                                              'origin': this.listCart.chilrdern[0].idKecamatan.toString(),
                                              'destination': blocProfile.listUserAddressDefault[0].idKecamatan,
                                              'weight': total.toString()
                                            };
                                          blocOrder.getCost(param);
                                        });
                                        _btnController.reset();
                                      },
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    blocOrder.isLoading
                        ? Container(
                      height: 100,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: PKCardListSkeleton(),
                    )
                        : Container(
                      color: blocOrder.errorShippingAddres ? Colors.red.withOpacity(0.2) : Colors.white,
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Row(
                            children: [
                              Text('Jasa Pengiriman', style: TextStyle(fontSize: 12)),
                              Text(
                                ' (Kurir)',
                                style: TextStyle(color: Colors.grey, fontSize: 10, fontStyle: FontStyle.italic),
                              )
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  blocOrder.listCostSelected.isEmpty
                                      ? '-'
                                      : blocOrder.listCostSelected['kode_kurir'].toString().toUpperCase() +
                                      ' ' +
                                      ' estimasi ' +
                                      blocOrder.listCostSelected['estimasi_pengiriman'],
                                  style: TextStyle(fontSize: 10)),
                              Text(blocOrder.listCostSelected.isEmpty ? '' : '#' + blocOrder.listCostSelected['jenis_service'].toString(),
                                  style: TextStyle(fontSize: 10)),
                              Text(
                                  blocOrder.listCostSelected.isEmpty
                                      ? ''
                                      : Money.fromInt(int.parse(blocOrder.listCostSelected['total_ongkir'].toString()), IDR).toString(),
                                  style: TextStyle(fontSize: 12, color: Colors.black)),
                            ],
                          ),
                          leading: Icon(FontAwesomeIcons.carAlt),
                          trailing: Container(
                            height: 30,
                            width: 80,
                            child: new Row(
                              children: <Widget>[
                                new Expanded(
                                    child: RoundedLoadingButton(
                                      child: Text('Ubah', style: TextStyle(color: Colors.white, fontSize: 12)),
                                      color: Colors.cyan[700],
                                      controller: _btnController,
                                      onPressed: () {
                                        blocProfile.getAllUserAddress(blocAuth.idUser);
                                        Navigator.push(context, SlideRightRoute(page: WidgetLisCourier())).then((value) {
                                          Provider.of<BlocProfile>(context).getSubDistrictById(listCart.chilrdern[0].idKecamatan);
                                          Provider.of<BlocProfile>(context).getUserAddressDefault(blocAuth.idUser);
                                        });
                                        _btnController.reset();
                                      },
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: blocOrder.errorMethodeTransfer ? Colors.red.withOpacity(0.2) : Colors.white,
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text('Metode Pembayaran', style: TextStyle(fontSize: 12)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(blocOrder.listMetodePembayaranSelected.isEmpty ? '-' : blocOrder.listMetodePembayaranSelected['metode_pembayaran'],
                                  style: TextStyle(fontSize: 10)),
                              Text(
                                  blocOrder.listMetodePembayaranSelected.isEmpty
                                      ? ''
                                      : blocOrder.listMetodePembayaranSelected['nama_bank'] + ' ' + blocOrder.listMetodePembayaranSelected['no_rekening'],
                                  style: TextStyle(fontSize: 10, color: Colors.black)),
                              Text(
                                blocOrder.listMetodePembayaranSelected.isEmpty ? '' : 'a.n ' + blocOrder.listMetodePembayaranSelected['nama_rekening'],
                                style: TextStyle(fontSize: 10),
                              )
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
                                      controller: _btnController,
                                      onPressed: () {
                                        blocProfile.getAllUserAddress(blocAuth.idUser);
                                        Navigator.push(context, SlideRightRoute(page: WidgetListPembayaran())).then((value) {
                                          Provider.of<BlocProfile>(context).getSubDistrictById(listCart.chilrdern[0].idKecamatan);
                                          Provider.of<BlocProfile>(context).getUserAddressDefault(blocAuth.idUser);
                                        });
                                        _btnController.reset();
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
                  Container(
                    child: Text('Subtotal'),
                  ),
                  Container(
                    child: Text(
                      blocOrder.listCostSelected.isEmpty
                          ? Money.fromInt((this.subtotal), IDR).toString()
                          : Money.fromInt((this.subtotal + blocOrder.listCostSelected['total_ongkir']), IDR).toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.4,
//                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: RoundedLoadingButton(
                      child: Text('Bayar', style: TextStyle(color: Colors.white)),
                      color: Colors.cyan[700],
                      controller: _btnController,
                      onPressed: () {
                        if (blocOrder.listCostSelected.isEmpty) {
                          _showToast('Silahkan pilih pengiriman', Colors.amber);
                          blocOrder.setErrorShippingAddres(true);
                          _btnController.reset();
                          _showToast('Silahkan pilih metode pembayaran', Colors.amber);
                          blocOrder.setErrorMethodeTransfer(true);
                        } else if (blocOrder.listMetodePembayaranSelected.isEmpty) {
                          _showToast('Silahkan pilih metode pembayaran', Colors.amber);
                          blocOrder.setErrorMethodeTransfer(true);
                          _btnController.reset();
                        } else {
                          Map data_order = {
                            'id_toko': listCart.chilrdern[0].idToko.toString(),
                            'id_pembeli': blocAuth.idUser.toString(),
                            'subtotal': this.subtotal.toString(),
                            'total_ongkir': blocOrder.listCostSelected['total_ongkir'].toString(),
                            'total': (this.subtotal + blocOrder.listCostSelected['total_ongkir']).toString(),
                            'metode_pembayaran': blocOrder.listMetodePembayaranSelected['metode_pembayaran'].toString(),
                            'status_pembayaran': 'menunggu'.toString(),
                            'total_diskon': '0'.toString(),
                            'total_lain_lain': '0'.toString(),
                            'kode_kurir': blocOrder.listCostSelected['kode_kurir'].toString(),
                            'nama_kurir': blocOrder.listCostSelected['nama_kurir'].toString(),
                            'estimasi_pengiriman': blocOrder.listCostSelected['estimasi_pengiriman'].toString(),
                            'jenis_service': blocOrder.listCostSelected['jenis_service'].toString(),
                            'no_rekening': blocOrder.listMetodePembayaranSelected['no_rekening'].toString(),
                            'nama_rekening': blocOrder.listMetodePembayaranSelected['nama_rekening'].toString(),
                            'nama_bank': blocOrder.listMetodePembayaranSelected['nama_bank'].toString(),
                          };
                          Map data_penerima = {
                            'id_user_login': blocAuth.idUser.toString(),
                            'nama_penerima': blocProfile.listUserAddressDefault[0].namaPenerima.toString(),
                            'no_hp_penerima': blocProfile.listUserAddressDefault[0].noHp.toString(),
                            'nama_alamat': blocProfile.listUserAddressDefault[0].namaAlamat.toString(),
                            'id_kecamatan': blocProfile.listUserAddressDefault[0].idKecamatan.toString(),
                            'alamat_lengkap': blocProfile.listUserAddressDefault[0].alamatLengkap.toString(),
                          };
                          List data_produk = [];
                          for (var i = 0; i < listCart.chilrdern.length; i++) {
                            Map dataProduk = {
                              'id_produk': listCart.chilrdern[i].idProduk.toString(),
                              'id_keranjang': listCart.chilrdern[i].id.toString(),
                              'nama_produk': listCart.chilrdern[i].nama.toString(),
                              'harga': listCart.chilrdern[i].harga.toString(),
                              'jumlah': listCart.chilrdern[i].jumlah.toString(),
                                    'subtotal': (int.parse(listCart.chilrdern[i].jumlah.toString()) * int.parse(listCart.chilrdern[i].harga)).toString(),
                                    'berat': listCart.chilrdern[i].berat.toString(),
                                    'slug': listCart.chilrdern[i].nama.toString(),
                                  };
                                  data_produk.add(dataProduk);
                                }
                                blocOrder.setErrorShippingAddres(false);
                                blocOrder.setErrorMethodeTransfer(false);

                                Map body = {'data_order': data_order, 'data_produk': data_produk, 'data_penerima': data_penerima};
                                print(body);
                                Navigator.push(context, SlideRightRoute(page: WidgetWaitingPayment(body: body)));
                                _btnController.reset();
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
    );
  }

  void _showToast(String message, Color color) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(seconds: 3),
    ));
  }
}
