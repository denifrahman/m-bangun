import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Aktivity/component/WidgetViewPdfPengajuan.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetDetailBahanPengajuan extends StatelessWidget {
  const WidgetDetailBahanPengajuan({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    var data = dataProvider.getdataProdukById;
    return ExpansionTileCard(
      elevation: 2,
      colorCurve: Curves.easeInExpo,
      initiallyExpanded: true,
      leading: Icon(Icons.assignment),
      title: Text('Deskripsi & Rab'),
      children: <Widget>[
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: data == null
                  ? Text('')
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            dataProvider.getdataProdukById['data'][0]['produkdeskripsi'],
                            textAlign: TextAlign.start,
                          ),
                          leading: InkWell(
                            onTap: () {
                              var url =
                                  'http://m-bangun.com/api/assets/pdf/file_rab_' + dataProvider.getdataProdukById['data'][0]['produkid'] + '.pdf';
                              var title = 'Rab';
                              Navigator.push(
                                  context,
                                  SlideRightRoute(
                                      page: WidgetViewPdfPengajuan(
                                    urlPdf: url,
                                    title: title,
                                  )));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.attach_file,
                                  color: Colors.blue,
                                ),
                                Text('Buka')
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
            ))
      ],
    );
  }
}
