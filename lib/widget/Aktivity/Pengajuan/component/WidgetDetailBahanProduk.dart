import 'package:apps/providers/BlocProject.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';

class WidgetDetailBahanProduk extends StatelessWidget {
  const WidgetDetailBahanProduk({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    BlocProject blocProject = Provider.of<BlocProject>(context);
    var data = dataProvider.getdataProdukById;
    return ExpansionTileCard(
      elevation: 2,
      colorCurve: Curves.easeInExpo,
      initiallyExpanded: true,
      leading: Icon(Icons.assignment),
      title: Text('Spesifikasi dan pembayaran'),
      children: <Widget>[
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 70,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Html(
                      data: blocProject.listProjectDetail[0].deskripsi,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        _showDeskripsi(context);
                      },
                      child: Text(
                        'Selengkapnya',
                        style: TextStyle(color: Colors.cyan[600]),
                      ))
                ],
              ),
            ))
      ],
    );
  }

  void _showDeskripsi(context) async {
    BlocProject blocProyek = Provider.of<BlocProject>(context);
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return ChangeNotifierProvider<BlocProject>(
          builder: (context) => BlocProject(),
          child: Consumer<BlocProject>(builder: (context, blocOrder, _) {
            return new Container(
              height: MediaQuery.of(context).size.height * 0.95,
              padding: EdgeInsets.all(15.0),
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Deskripsi Produk',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.clear))
                      ],
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
                        child: Container(
                            color: Colors.white38,
                            child: Html(
                              style: {
                                "div": Style(
                                  fontSize: FontSize.large,
                                ),
                              },
                              data: blocProyek.listProjectDetail[0].deskripsi,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
