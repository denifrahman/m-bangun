import 'package:apps/Utils/Theme/colors.dart';
import 'package:apps/Utils/WidgetErrorConnection.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/PhoneAuth/presentation/pages/firebase/auth/auth.dart';
import 'package:apps/screen/PhoneAuth/presentation/pages/firebase/auth/phone_auth/get_phone.dart';
import 'package:apps/screen/TokoSayaScreen.dart';
import 'package:apps/providers/BlocChatService.dart';
import 'package:apps/widget/Pendaftaran/WidgetPendaftaran.dart';
import 'package:apps/widget/Pengajuan/component/WidgetCardMenu.dart';
import 'package:apps/widget/Profile/TopContainer.dart';
import 'package:apps/widget/Profile/WidgetMyFavorite.dart';
import 'package:apps/widget/Toko/Pengajuan.dart';
import 'package:apps/widget/penghasilan/WidgetDetailPenghasilan.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key key}) : super(key: key);

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(color: AppColors.kDarkBlue, fontSize: 20.0, fontWeight: FontWeight.w700, letterSpacing: 1.2),
    );
  }

  var dataList = ['New', 'Kontrak', 'Progress', 'Finish', 'Batal'];

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: AppColors.kGreen,
      child: Icon(
        Icons.work,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    final blocProduk = Provider.of<BlocProduk>(context);
    double width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: () async {
        blocAuth.checkSession();
      },
      child: Scaffold(
        body:  ModalProgressHUD(
              inAsyncCall: blocAuth.isLoading,
                          child: SafeArea(
                      child: Column(
                        children: <Widget>[
                          TopContainer(
                            height: 200,
                            width: width,
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Profil',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                          iconSize: 20.0,
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => WidgetPendaftaran()));
                                          }),
                                      IconButton(
                                        onPressed: () async {
                                          await Provider.of<BlocOrder>(context).clearCart();
                                          await Provider.of<BlocOrder>(context).clearCountOrder();
                                          await Provider.of<BlocAuth>(context).handleSignOut();
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PhoneAuthGetPhone()));
                                          await FireBase.auth.signOut();
                                        },
                                        icon: Icon(Icons.exit_to_app, color: Colors.grey[400], size: 20.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    CircularPercentIndicator(
                                      radius: 70.0,
                                      lineWidth: 5.0,
                                      animation: true,
                                      percent: 0.75,
                                      circularStrokeCap: CircularStrokeCap.round,
                                      progressColor: AppColors.kRed,
                                      backgroundColor: AppColors.kDarkYellow,
                                      center: Container(
                                          width: 60.0,
                                          height: 60.0,
                                          child: ClipOval(
                                            child: Image.network(
                                              blocAuth.currentUserLogin['photo_url'] == null ? dataProvider.fotoNull : blocAuth.currentUserLogin['photo_url'],
                                              fit: BoxFit.cover,
                                              width: 80,
                                            ),
                                          )),
                                    ),
                                    blocAuth.currentUserLogin['email'] == null
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => WidgetPendaftaran()));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
                                              child: Center(
                                                child: Text('Lengkapi Profile'),
                                              ),
                                            ),
                                          )
                                        : _buildNameAndEmail(context)
                                  ],
                                ),
                              )
                            ]),
                          ),
                          blocAuth.statusToko == '0'
                              ? InkWell(
                                  onTap: () => _pengajuan(context),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: WidgetCardMenu(
                                      title: 'Buka Toko',
                                      color: Colors.amber[800],
                                      thumbnail: 'assets/icons/store.png',
                                      deskripsi: 'Anda bisa menjual produk anda secara eksklusif di m-Bangun, cukup mengisi detail produk anda dan produk anda siap di untuk dijual!',
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          color: Colors.transparent,
                                          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  subheading('Toko Saya'),
                                                ],
                                              ),
                                              SizedBox(height: 15.0),
                                              InkWell(
                                                onTap: () {
                                                  blocProfile.getTokoByParam({'id_user': blocAuth.idUser.toString()});
                                                  blocProduk.getAllProductByParam({'id_toko': blocAuth.idToko.toString()});
                                                  Navigator.push(context, SlideRightRoute(page: TokoSayaScreen()));
                                                },
                                                child: WidgetMyFavorite(
                                                  icon: Icons.shop,
                                                  iconBackgroundColor: AppColors.kRed,
                                                  title: 'Kelola Toko',
                                                  subtitle: 'Kelola produk, alamat bank anda',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        Container(
                                          color: Colors.transparent,
                                          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  subheading('Penghasilan'),
                                                ],
                                              ),
                                              SizedBox(height: 15.0),
                                              InkWell(
                                                onTap: () {
                                                  blocProfile.getPenghasilanByParam({'id_toko': blocAuth.idToko.toString()});
                                                  Navigator.push(context, SlideRightRoute(page: WidgetDetailPenghasilan()));
                                                },
                                                child: WidgetMyFavorite(
                                                  icon: Icons.credit_card,
                                                  iconBackgroundColor: Colors.green,
                                                  title: 'Lihat Penghasilan',
                                                  subtitle: 'Pembayaran penghasilan anda',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
            )),
    );
  }

  Widget _buildNameAndEmail(context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: MediaQuery.of(context).size.width * 0.6,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Container(child: Image(width: 18, fit: BoxFit.contain, image: new AssetImage('assets/icons/verified.png'))),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              margin: EdgeInsets.only(left: 0),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                    text: blocAuth.currentUserLogin['nama']),
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          strutStyle: StrutStyle(fontSize: 12.0),
          text: TextSpan(
            style: TextStyle(
              color: Colors.grey[300],
            ),
            text: blocAuth.currentUserLogin['email'],
          ),
        ),
      )
    ]);
  }

  _pengajuan(BuildContext context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    Navigator.push(context, SlideRightRoute(page: Pengajuan())).then((value) {
      blocAuth.checkSession();
    });
  }
}
