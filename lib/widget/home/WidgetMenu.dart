import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/screen/KategoriScreenNew.dart';
import 'package:apps/widget/Pengajuan/component/WidgetCardMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetMenu extends StatelessWidget {
  WidgetMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              blocAuth.statusToko == '0'
                  ? InkWell(
                      onTap: () => _openScreen('pengajuan_toko', context),
                      child: WidgetCardMenu(
                        title: 'Buka Toko',
                        color: Colors.amber[800],
                        thumbnail: 'assets/icons/store.png',
                        deskripsi: 'Anda bisa menjual produk anda secara eksklusif di m-Bangun, cukup mengisi detail produk anda dan produk anda siap di untuk publish!',
                      ),
                    )
                  : Container(),
              WidgetCardMenu(
                title: 'Panggil m-Bangun (Segera Hadir)',
                color: Colors.cyan[600],
                thumbnail: 'assets/icons/worker.png',
                deskripsi: 'Mau benerin perabotan rumah atau appartemen? kesulitan cari tukang di tengah kota? kami siap datang untuk melakukan survey!',
              )
            ],
          ),
        ),
      ],
    );
  }

  _openKategori(context, flag) {
//    Provider.of<DataProvider>(context).getKategoriByFlag(flag.groupKategoriId);
    Navigator.push(
        context,
        SlideRightRoute(
            page: KategoriScreenNew(
          title: flag.groupNama,
        )));
  }

  openSubkategori(chilrdern) {}

  _launchURL(String url, context) async {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    if (await canLaunch(url)) {
      await launch(url + '?email=' + blocAuth.currentUser.email);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openScreen(String s, BuildContext context) {
    if (s == 'pengajuan_toko') {
      _launchURL('https://mobile.m-bangun.com', context);
    }
  }
}
