import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/ProdukListM.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/screen/ProdukDetailScreen.dart';
import 'package:apps/widget/Produk/WidgetOverViewProduk.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class WidgetListProduk extends StatefulWidget {
  final String idSubKategori;

  WidgetListProduk({Key key, this.idSubKategori}) : super(key: key);

  @override
  _WidgetListProdukState createState() {
    return _WidgetListProdukState();
  }
}

class _WidgetListProdukState extends State<WidgetListProduk> {
  var dataProdukList = new List<ProdukListM>();
  final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
  String idKecamatan = '';
  String idKota = '';
  String idProvinsi = '';
  String key = '';

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
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return GridView.count(
//      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      children: List.generate(
        blocProduk.listProducts.length,
        (j) {
          var harga = blocProduk.listProducts[j].harga;
          var hargaFormat = Money.fromInt(harga == null ? 0 : int.parse(harga), IDR);
          return InkWell(
            onTap: () {
              blocProduk.getAllProductByParam({'id': blocProduk.listProducts[j].id.toString()});
              Navigator.push(context, SlideRightRoute(page: ProdukDetailScreen()));
            },
            child: WidgetOverViewProduk(
              produkNama: blocProduk.listProducts[j].nama,
              namaToko: blocProduk.listProducts[j].namaToko,
              jenisToko: blocProduk.listProducts[j].jenisToko,
              thumbnail: blocProduk.listProducts[j].foto,
              harga: hargaFormat.toString(),
            ),
          );
        },
      ),
    );
  }
}
