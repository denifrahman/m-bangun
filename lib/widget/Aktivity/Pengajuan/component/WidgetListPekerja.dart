import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/BlocProject.dart';
import 'package:apps/screen/ProfileWorkerScreen.dart';
import 'package:apps/widget/Helper/WidgetFotoCircular.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WidgetListPekerja extends StatefulWidget {
  const WidgetListPekerja({Key key, this.param}) : super(key: key);
  final param;

  @override
  _WidgetListPekerjaState createState() => _WidgetListPekerjaState();
}

class _WidgetListPekerjaState extends State<WidgetListPekerja> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');

  @override
  Widget build(BuildContext context) {
    BlocProject blocProject = Provider.of<BlocProject>(context);
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    return ExpansionTileCard(
      elevation: 2,
      colorCurve: Curves.ease,
      initiallyExpanded: true,
      leading: Icon(
        Icons.group_work,
        color: Colors.orange,
      ),
      title: Text('Daftar Pekerja'),
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
              Text(blocProject.listBids.length == 0 ? 'Belum ada yang memilih pekerjaan anda' : 'Silahkan pilih pekerja salah satu rekomendasi dari kami dibawah ini :'),
              blocProject.listBids.length == 0
                  ? Container()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: ListView.builder(
                          itemCount: blocProject.listBids.length,
                          itemBuilder: (context, index) {
                            var jenisMitra = blocProject.listBids[index].jenisMitra;
                            print(blocProject.listBids[index].status);
                            return InkWell(
                              onTap: () {
//                                print(blocProject.listBids.where((element) => element.status == '1').length);
//                                if (blocProject.listBids.where((element) => element.status == '1').length == 0) {
//                                  if (widget.param['status'] == 'setuju') {
                                _showDialog(blocProject.listBids[index]);
//                                  }
//                                }
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: WidgetFotoCircular(
                                      userFoto: blocProject.listBids[index].fotoMitra,
                                    ),
                                    title: Text(blocProject.listBids[index].namaMitra.toUpperCase()),
                                    subtitle: Text(
                                      '(' + jenisMitra.toString().toUpperCase() + ')',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.grey, fontSize: 13),
                                    ),
                                    trailing: blocProject.listBids[index].status == '1'
                                        ? Icon(
                                            Icons.done_all,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            Icons.done_all,
                                            color: Colors.grey[300],
                                          ),
                                  ),
                                  Divider()
                                ],
                              ),
                            );
                          }),
                    ),
            ],
          ),
        )
      ],
    );
  }

  void _showDialog(param) {
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocProject blocProject = Provider.of<BlocProject>(context);
    if (!blocAuth.isLogin) {
      Flushbar(
        title: "Error",
        message: "Silahkan login / daftar member",
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.BOTTOM,
        icon: Icon(
          Icons.assignment_turned_in,
          color: Colors.white,
        ),
      )..show(context);
    } else {
      Future<void> future = showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            autovalidate: false,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.95,
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Apakah Anda Yakin?',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.clear))
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Penawaran Harga'),
                        Text(
                          Money.fromInt((int.parse(param.harga)), IDR).toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Waktu pengerjaan'),
                        Text(
                          param.waktuPengerjaan + ' Hari',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4, child: Text('Catatan')),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.48,
                          child: Text(
                            param.deskripsi,
                            textAlign: TextAlign.right,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Foto'),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Image.network(baseURL + '/' + pathBaseUrl + '/assets/bid/' + param.fotoBid, width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9, height: 200,
                          errorBuilder: (context, urlImage, error) {
                            print(error.hashCode);
                            return Image.asset(
                              'assets/logo.png',
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.5,
                            );
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Lihat profile'),
                        Container(
                          child: Container(
                            height: 40.0,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: FlatButton(
                              height: 30,
                              onPressed: () {
                                blocProfile.getMitraByParam({'id': param.idMitra.toString()});
                                blocProfile.getJenisLayananByParam({'id_mitra': param.idMitra.toString()});
                                blocProject.getBidsByParam({'id_mitra': param.idMitra.toString(), 'status_proyek': 'selesai'});
                                Navigator.push(context, SlideRightRoute(page: ProfileWorkerScreen())).then((value) {
                                  Navigator.pop(context);
                                  blocProject.getBidsByParam({"id_projek": param.idProjek.toString(), 'id_user': param.idUser.toString()});
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.perm_contact_calendar,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  Text(
                                    'Profile',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Anda tidak dapat mengganti mitra yang sudah terpilih, pastikan anda sudah melihat profile mitra yang akan anda pilih!'),
                    SizedBox(
                      height: 20,
                    ),
                    blocProject.listBids
                        .where((element) => element.status == '1')
                        .length == 0
                        ? RoundedLoadingButton(
                      height: 40,
                      child: Text('Setuju', style: TextStyle(color: Colors.white)),
                      color: Colors.green,
                      controller: _btnController,
                      onPressed: () => updateBidToKontrak(param),
                    )
                        : Container()
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  updateBidToKontrak(param) async {
    BlocProject blocProject = Provider.of<BlocProject>(context);
    var map = new Map<String, dynamic>();
    map['id_user'] = param.idUser;
    map['id'] = param.id;
    map['id_projek'] = param.idProjek;
    print(map);
    var result = blocProject.updateSelectedBid(map);
    result.then((value) async {
      if (value) {
        _btnController.success();
        await new Future.delayed(const Duration(seconds: 2));
        Navigator.pop(context);
        blocProject.getProjectByOrder({
          'no_order': blocProject.listProjectDetail[0].noOrder.toString(),
        });
      } else {
        _btnController.error();
        await new Future.delayed(const Duration(seconds: 2));
        Navigator.pop(context);
      }
    });
  }
}
