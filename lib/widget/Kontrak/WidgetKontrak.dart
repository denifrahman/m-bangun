import 'package:apps/Utils/Signature.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocProject.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Aktivity/Pengajuan/component/WidgetViewPdfPengajuan.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';

class WidgetKontrak extends StatelessWidget {
  const WidgetKontrak({Key key, this.param}) : super(key: key);
  final String param;

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    BlocProject blocProject = Provider.of<BlocProject>(context);
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    return ExpansionTileCard(
      elevation: 2,
      colorCurve: Curves.ease,
      initiallyExpanded: true,
      leading: Icon(
        Icons.mode_edit,
        color: Colors.red,
      ),
      title: Text('Tanda tangan Kontrak'),
      children: <Widget>[
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              blocProject.listBids.where((element) => element.status == '1').length == 0
                  ? Text(
                      'Silahkan pilih salah satu pekerja untuk dan kontrak akan otomatis dibuatkan antara pihak pertama dan pihak kedua',
                      style: TextStyle(fontSize: 12),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ListTile(
                        title: SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text("Tanda Tangan"),
                            color: Color(0xffb16a085),
                            textColor: Colors.white,
                            padding: EdgeInsets.only(left: 11, right: 11, top: 15, bottom: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageRouteTransition(
                                    animationType: AnimationType.slide_up,
                                    builder: (context) => WidgetSignature(
                                      projekId: blocProject.listProjectDetail[0].id,
                                      signature: this.param,
                                    ),
                                  ));
                            },
                          ),
                        ),
                        leading: InkWell(
                          onTap: () {
                            imageCache.clear();
                            var url = 'https://mobile.mbangun.id/kontrak?id=' + blocProject.listProjectDetail[0].id;
                            print(url);
                            var title = 'Kontrak';
                            Navigator.push(context, SlideRightRoute(page: WidgetViewPdfPengajuan(urlPdf: url, title: title)));
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
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
