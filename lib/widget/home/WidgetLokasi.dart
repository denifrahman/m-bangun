import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/Utils/TitleHeader.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/KotaM.dart';
import 'package:apps/models/ProvinsiM.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Home/WidgetSelectLokasi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    var kecamatan = dataProvider.namaKecamatan == null ? '' : dataProvider.namaKecamatan.toLowerCase();
    var kota = dataProvider.namaKota == null ? '' : dataProvider.namaKota.toLowerCase();
    var provinsi = dataProvider.namaProvinsi == null ? '' : dataProvider.namaProvinsi.toLowerCase();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.only(bottom: 6, top: 6),
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
              title: "m-Bangun",
              color: Colors.white,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.place,
                  size: 15,
                  color: Colors.white,
                ),
                Text(
                  'Lokasi Anda',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
            InkWell(
                onTap: () => _modalListKota(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        dataProvider.namaKecamatan == null
                            ? Container()
                            : Text(dataProvider.namaKecamatan == null ? '' : '${kecamatan[0].toUpperCase()}${kecamatan.substring(1)}',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Color(0xffb16a085))),
                        dataProvider.namaKecamatan == null ? Container() : Text(', '),
                        dataProvider.namaKota == null
                            ? Container()
                            : Text(dataProvider.namaKota == null ? '' : '${kota[0].toUpperCase()}${kota.substring(1)}',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Color(0xffb16a085))),
                      ],
                    ),
                    Text(dataProvider.namaProvinsi == null || dataProvider.namaProvinsi == '' ? 'Pilih lokasi' : '${provinsi[0].toUpperCase()}${provinsi.substring(1)}',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white)),
                  ],
                ))
          ],
        )
      ],
    );
  }

  _modalListKota() async {
    String currentIdProvinsi = await LocalStorage.sharedInstance.readValue('idProvinsi');
    Navigator.push(
      context,
      SlideRightRoute(
          page: WidgetSelectLokasi(
        idProvinsi: currentIdProvinsi,
      )),
    ).then((value) {
      Provider.of<DataProvider>(context).getCurrentLocation();
    });
  }
}
