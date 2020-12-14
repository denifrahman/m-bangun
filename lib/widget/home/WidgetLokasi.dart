import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/Utils/TitleHeader.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/KotaM.dart';
import 'package:apps/models/ProvinsiM.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:apps/screen/Notification.dart';
import 'package:apps/providers/BlocChatService.dart';
import 'package:apps/screen/streamChatting/presentation/pages/StreamChat.dart';
import 'package:apps/widget/Home/WidgetSelectLokasi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class WidgetLokasi extends StatefulWidget {
  WidgetLokasi({Key key}) : super(key: key);

  @override
  _WidgetLokasiState createState() {
    return _WidgetLokasiState();
  }
}

class _WidgetLokasiState extends State<WidgetLokasi> {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  String idKota;
  String idProvinsi;
  String namaProvinsi, namaKota, namaKecamatan;
  var dataKota = List<KotaM>();
  var dataProvinsi = List<ProvinsiM>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatModel>(context);
    // TODO: implement build
    final blocAuth = Provider.of<BlocAuth>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.only(bottom: 6, top: 5),
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                gradient: new LinearGradient(
                    colors: [Color(0xffb16a085).withOpacity(0.1), Colors.white],
                    begin: const FractionalOffset(7.0, 10.1),
                    end: const FractionalOffset(0.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: new Center(
                child: Image(width: 35, fit: BoxFit.fill, image: new AssetImage('assets/logo.png')),
              ),
            ),
            Container(
              width: 5,
            ),
            TitleHeader(
              title: "Mbangun",
              color: Colors.white,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        blocAuth.getNotification();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    ),
                    new Positioned(
                      top: 5.0,
                      right: 5.0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                        alignment: Alignment.center,
                        child: Text(
                          blocAuth.coundNotification.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        ),
                      ),
                    )
                  ],
                ),
                Stack(
                  children: <Widget>[
                    IconButton(
                      onPressed: () async {
                        final client = provider.client;
                        if (client.connectionId == null) {
                          await provider.setUser();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => StreamChatting(),
                            ),
                          );
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => StreamChatting(),
                            ),
                          );
                        }
                      },
                      icon: Icon(
                        Icons.message,
                        color: Colors.white,
                      ),
                    ),
                    new Positioned(
                      top: 5.0,
                      right: 5.0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                        alignment: Alignment.center,
                        child: Text(
                          provider.client.state.unreadChannels == null ? '0' : provider.client.state.unreadChannels.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
//            InkWell(
//                onTap: () => _modalListKota(),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.end,
//                  children: <Widget>[
////                    Row(
////                      children: <Widget>[
////                        blocProduk.namaKecamatan == null
////                            ? Container()
////                            : Text(blocProduk.namaKecamatan == null ? '' : '${kecamatan[0].toUpperCase()}${kecamatan.substring(1)}',
////                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Colors.white)),
////                        blocProduk.namaKecamatan == null
////                            ? Container()
////                            : Text(
////                                ', ',
////                                style: TextStyle(color: Colors.white),
////                              ),
////                        blocProduk.namaKota == null
////                            ? Container()
////                            : Text(blocProduk.namaKota == null ? '' : '${kota[0].toUpperCase()}${kota.substring(1)}',
////                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Colors.white)),
////                      ],
////                    ),
////                    Text(blocProduk.namaProvinsi == null || blocProduk.namaProvinsi == '' ? 'Pilih lokasi' : '${provinsi[0].toUpperCase()}${provinsi.substring(1)}',
////                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white)),
//                  ],
//                ))
          ],
        )
      ],
    );
  }

  _modalListKota() async {
    String currentIdProvinsi = await LocalStorage.sharedInstance.readValue('idProvinsi');
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    blocProfile.clearDataCity();
    Navigator.push(
      context,
      SlideRightRoute(page: WidgetSelectLokasi()),
    ).then((value) {
      Provider.of<BlocProduk>(context).getCurrentLocation();
    });
  }
}
