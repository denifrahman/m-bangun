import 'package:apps/Utils/PreviewFoto.dart';
import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/providers/BlocProject.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Aktivity/Pengajuan/component/WidgetDeskripsiProduk.dart';
import 'package:apps/widget/Aktivity/Pengajuan/component/WidgetDetailBahanProduk.dart';
import 'package:apps/widget/Aktivity/Pengajuan/component/WidgetDetailLokasi.dart';
import 'package:apps/widget/Aktivity/Pengajuan/component/WidgetLaporanAkhir.dart';
import 'package:apps/widget/Aktivity/Pengajuan/component/WidgetListPekerja.dart';
import 'package:apps/widget/Aktivity/Pengajuan/component/WidgetListPembayaran.dart';
import 'package:apps/widget/Aktivity/Pengajuan/component/WidgetSurveyInformation.dart';
import 'package:apps/widget/Kontrak/WidgetKontrak.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';

class WidgetDetailPengajuanKontrak extends StatelessWidget {
  WidgetDetailPengajuanKontrak({Key key, @required this.param}) : super(key: key);

  final Map<String, String> param;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    var data = dataProvider.getdataProdukById;
    BlocProject blocProject = Provider.of<BlocProject>(context);
    return Scaffold(
      body: blocProject.isLoading
          ? SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('Waiting'),
                  ),
                  body: Center(
                    child: PKCardListSkeleton(
//                      totalLines: 3,
                        ),
                  ),
                ),
              ),
            )
          : Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: NestedScrollView(
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          automaticallyImplyLeading: true,
                          expandedHeight: 200.0,
                          floating: false,
                          pinned: true,
                          leading: Container(
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            padding: EdgeInsets.all(3),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.black26,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            collapseMode: CollapseMode.parallax,
                            title: Container(
                              padding: EdgeInsets.only(left: 50, right: 20),
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                strutStyle: StrutStyle(fontSize: 14.0),
                                text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 14,
                                    ),
                                    text: data == null ? '' : dataProvider.getdataProdukById['data'][0]['produknama']),
                              ),
                            ),
                            background: Carousel(
                              autoplay: false,
                              overlayShadow: false,
                              noRadiusForIndicator: true,
                              images: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteTransition(
                                          animationType: AnimationType.slide_down,
                                          builder: (context) => PreviewFoto(
                                            urlFoto: blocProject.listProjectDetail[0].foto1 == null ? dataProvider.fotoNull : baseURL + '/api-v2/assets/toko/' +
                                                blocProject.listProjectDetail[0].foto1,
                                          ),
                                        ));
                                  },
                                  child: Image.network(
                                    blocProject.listProjectDetail[0].foto1 == null ? dataProvider.fotoNull : baseURL + '/api-v2/assets/toko/' +
                                        blocProject.listProjectDetail[0].foto1,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteTransition(
                                          animationType: AnimationType.slide_down,
                                          builder: (context) => PreviewFoto(
                                            urlFoto: blocProject.listProjectDetail[0].foto2 == null ? dataProvider.fotoNull : baseURL + '/api-v2/assets/toko/' +
                                                blocProject.listProjectDetail[0].foto2,
                                          ),
                                        ));
                                  },
                                  child: Image.network(
                                    blocProject.listProjectDetail[0].foto3 == null ? dataProvider.fotoNull : baseURL + '/api-v2/assets/toko/' +
                                        blocProject.listProjectDetail[0].foto3,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteTransition(
                                          animationType: AnimationType.slide_down,
                                          builder: (context) => PreviewFoto(
                                            urlFoto: blocProject.listProjectDetail[0].foto3 == null ? dataProvider.fotoNull : baseURL + '/api-v2/assets/toko/' +
                                                blocProject.listProjectDetail[0].foto3,
                                          ),
                                        ));
                                  },
                                  child: Image.network(
                                    blocProject.listProjectDetail[0].foto3 == null ? dataProvider.fotoNull : baseURL + '/api-v2/assets/toko/' +
                                        blocProject.listProjectDetail[0].foto3,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteTransition(
                                          animationType: AnimationType.slide_down,
                                          builder: (context) => PreviewFoto(
                                            urlFoto: blocProject.listProjectDetail[0].foto4 == null ? dataProvider.fotoNull : baseURL + '/api-v2/assets/toko/' +
                                                blocProject.listProjectDetail[0].foto4,
                                          ),
                                        ));
                                  },
                                  child: Image.network(
                                    blocProject.listProjectDetail[0].foto4 == null ? dataProvider.fotoNull : baseURL + '/api-v2/assets/toko/' +
                                        blocProject.listProjectDetail[0].foto4,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ],
                              dotSize: 4.0,
                              dotSpacing: 15.0,
                              dotColor: Colors.lightGreenAccent,
                              indicatorBgPadding: 3.0,
                              dotBgColor: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              child: WidgetDeskripsiProduk(
                                created: blocProject.listProjectDetail[0].createdAt,
                                lokasi: blocProject.listProjectDetail[0].alamatLengkap,
                                nama: blocProject.listProjectDetail[0].nama,
                                jenisLayanan: blocProject.listProjectDetail[0].namaLayanan,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: WidgetDetailLokasi(
                                alamatLengkap: blocProject.listProjectDetail[0].alamatLengkap,
                              ),
                            ),
                            param['status'] == 'survey'
                                ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: WidgetSurveyInformation(),
                            )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: WidgetDetailBahanProduk(),
                            ),
                            param['status'] == 'setuju' || param['status'] == 'proses'
                                ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: WidgetListPekerja(
                                param: param,
                                    ),
                                  )
                                : Container(),
                            param['status'] == 'proses' || param['status'] == 'setuju'
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: WidgetKontrak(
                                      param: 'owner',
                                    ),
                                  )
                                : Container(),
                            param['status'] == 'setuju' || param['status'] == 'proses'
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: WidgetListPembayaran(param: param),
                                  )
                                : Container(),
                            param['status'] == 'proses' || param['status'] == 'selesai'
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: WidgetLaporanAkhir(),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
