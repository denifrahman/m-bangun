import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocProject.dart';
import 'package:apps/widget/Aktivity/Pengajuan/component/WidgetViewPdfPengajuan.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetLaporanAkhir extends StatelessWidget {
  WidgetLaporanAkhir({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProject blocProject = Provider.of<BlocProject>(context);
    print("aa" + blocProject.listProjectDetail.where((element) => element.fileLaporanAkhir != '').length.toString());
    return ExpansionTileCard(
      elevation: 2,
      colorCurve: Curves.ease,
      initiallyExpanded: true,
      leading: Icon(
        Icons.subject,
        color: Colors.red,
      ),
      title: Text('Laporan Akhir'),
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
                      height: blocProject.listProjectDetail[0].status == 'selesai' ? 40 : 100,
                      child: ListTile(
                        title: SizedBox(
                          width: double.infinity,
                          child: blocProject.listProjectDetail.where((element) => element.fileLaporanAkhir != '').length == 0
                              ? Container(
                                  child: Center(child: Text('Kontrak belum di tersedia')),
                                )
                              : blocProject.listProjectDetail.where((element) => element.fileLaporanAkhir != null).length == 0
                                  ? Container()
                                  : Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              imageCache.clear();
                                              var url = baseURL + pathBaseUrl + 'assets/laporan_proyek/' + blocProject.listProjectDetail[0].fileLaporanAkhir;
                                              var title = 'Laporan';
                                              print(url);
                                              Navigator.push(context, SlideRightRoute(page: WidgetViewPdfPengajuan(urlPdf: url, title: title)));
                                            },
                                            child: Text(
                                              'Baca Laporan',
                                              style: TextStyle(color: Colors.blueAccent),
                                            )),
                                        blocProject.listProjectDetail[0].status == 'selesai'
                                            ? Container()
                                            : Container(
                                                width: MediaQuery.of(context).size.width * 0.8,
                                                child: RaisedButton(
                                                  child: Text("Selesai"),
                                                  color: Color(0xffb16a085),
                                                  textColor: Colors.white,
                                                  padding: EdgeInsets.only(left: 0, right: 0, top: 15, bottom: 15),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                  onPressed: () {
                                                    showDialog<void>(
                                                      context: context,
                                                      barrierDismissible: false, // user must tap button!
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: Text('Penting'),
                                                          content: SingleChildScrollView(
                                                            child: ListBody(
                                                              children: <Widget>[
                                                                Text('Apakah anda yakin ?'),
                                                                Text('Menyelesaikan proyek ini'),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            FlatButton(
                                                              child: Text('Batal'),
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                            ),
                                                            FlatButton(
                                                              child: Text('Setuju'),
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                                var body = {'id': blocProject.listProjectDetail[0].id, 'status': 'selesai'};
                                                                var result = blocProject.updateStatus(body);
                                                                result.then((value) {
                                                                  if (value) {
                                                                    blocProject.getProjectByOrder({
                                                                      'no_order': blocProject.listProjectDetail[0].noOrder.toString(),
                                                                    });
                                                                  }
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
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
