import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/KategoriScreenNew.dart';
import 'package:apps/widget/Pengajuan/component/WidgetCardMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetMenu extends StatelessWidget {
  WidgetMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              WidgetCardMenu(
                title: 'Buka Toko',
                color: Colors.amber[800],
                thumbnail: 'assets/icons/store.png',
                deskripsi: 'Anda bisa menjual produk anda secara eksklusif di m-Bangun, cukup mengisi detail produk anda dan produk anda siap di untuk publish!',
              ),
              WidgetCardMenu(
                title: 'Panggil m-Bangun',
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
}

