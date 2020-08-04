import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/Utils/values/colors.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/ApplyBid/WidgetApplyBidList.dart';
import 'package:apps/widget/Login/LoginWidget.dart';
import 'package:apps/widget/Profile/TopContainer.dart';
import 'package:apps/widget/Profile/WidgetMyFavorite.dart';
import 'package:apps/widget/Profile/WidgetProfile.dart';
import 'package:flutter/material.dart';
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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: !blocAuth.connection
          ? Center(
              child: InkWell(
                  onTap: () {
                    dataProvider.getToken();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.network_check,
                        color: Colors.grey,
                        size: 50,
                      ),
                      Text('Tidak Ada Koneksi Internet'),
                      Container(
                        height: 10,
                      ),
                      Container(
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            dataProvider.getToken();
                          },
                          child: Text(
                            'Coba Lagi',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ),
                      ),
              ],
            )),
      )
          : blocAuth.isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : !blocAuth.isLogin
          ? Container(
        color: Colors.white,
        child: LoginWidget(
          primaryColor: Color(0xFFb16a085),
          backgroundColor: Colors.white,
          page: '/BottomNavBar',
        ),
      )
          : SafeArea(
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
                        color: AppColors.kDarkBlue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(context, SlideRightRoute(page: WidgetProfile()));
                            blocProfile.getProfileUser(blocAuth.idUser);
                          },
                          icon: Icon(Icons.edit, color: AppColors.kDarkBlue, size: 20.0),
                        ),
                        IconButton(
                          onPressed: () {
                            blocAuth.handleSignOut();
                            Provider.of<BlocOrder>(context).clearCart();
                          },
                          icon: Icon(Icons.exit_to_app, color: Colors.grey[400], size: 20.0),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
//                        color: Colors.red,
//                            width: 200,
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
                                blocAuth.currentUser.photoUrl == null ? dataProvider.fotoNull : blocAuth.currentUser.photoUrl,
                                fit: BoxFit.cover,
                                width: 80,
                              ),
                            )),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.6,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                !dataProvider.verified
                                    ? Container()
                                    : Container(child: Image(width: 18, fit: BoxFit.contain, image: new AssetImage('assets/icons/verified.png'))),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.5,
                                  margin: EdgeInsets.only(left: dataProvider.verified ? 5 : 0),
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: AppColors.kDarkBlue,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        text: blocAuth.currentUser.displayName),
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
                                  color: Colors.grey[800],
                                ),
                                text: blocAuth.currentUser.email,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ]),
            ),
            !dataProvider.verified
                ? Container()
                : Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subheading('Detail Akun'),
                              GestureDetector(
                                onTap: () {},
                                child: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: AppColors.mainColor,
                                  child: Icon(
                                    Icons.perm_contact_calendar,
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          WidgetMyFavorite(
                            icon: Icons.alarm,
                            iconBackgroundColor: AppColors.kRed,
                            title: '(${dataProvider.userKategori})',
                            subtitle: dataProvider.userSubKategori,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subheading('Pekerjaanku'),
                              GestureDetector(
                                onTap: () {},
                                child: calendarIcon(),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          InkWell(
                            onTap: () {
                              dataProvider.getAllBidByUserIdAndStatusId('8');
                              Navigator.push(
                                  context,
                                  SlideRightRoute(
                                      page: WidgetApplyBidList(
                                        param: 'New',
                                        statusId: '8',
                                      )));
                            },
                            child: WidgetMyFavorite(
                              icon: Icons.new_releases,
                              iconBackgroundColor: Colors.blue,
                              title: 'New',
                              subtitle: 'Bid pekerjaan baru anda',
                            ),
                          ),
                          SizedBox(height: 15.0),
                          InkWell(
                            onTap: () {
                              dataProvider.getAllBidByUserIdAndStatusId('10');
                              Navigator.push(context, SlideRightRoute(page: WidgetApplyBidList(param: 'Kontrak', statusId: '10')));
                            },
                            child: WidgetMyFavorite(
                              icon: Icons.event_note,
                              iconBackgroundColor: Colors.green,
                              title: 'Kontrak',
                              subtitle: 'Penandatangan kontrak kerja',
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          InkWell(
                            onTap: () {
                              dataProvider.getAllBidByUserIdAndStatusId('12');
                              Navigator.push(context, SlideRightRoute(page: WidgetApplyBidList(param: 'Progress', statusId: '12')));
                            },
                            child: WidgetMyFavorite(
                              icon: Icons.blur_circular,
                              iconBackgroundColor: AppColors.kDarkYellow,
                              title: 'Progress',
                              subtitle: 'Proses Pengerjaan dan laporan',
                            ),
                          ),
                          SizedBox(height: 15.0),
                          InkWell(
                            onTap: () {
                              dataProvider.getAllBidByUserIdAndStatusId('13');
                              Navigator.push(context, SlideRightRoute(page: WidgetApplyBidList(param: 'Done', statusId: '13')));
                            },
                            child: WidgetMyFavorite(
                              icon: Icons.check_circle_outline,
                              iconBackgroundColor: AppColors.kBlue,
                              title: 'Done',
                              subtitle: 'Project telah selesai',
                            ),
                          ),
                          SizedBox(height: 15.0),
                          InkWell(
                            onTap: () {
                              dataProvider.getAllBidByUserIdAndStatusId('9');
                              Navigator.push(context, SlideRightRoute(page: WidgetApplyBidList(param: 'Batal', statusId: '9')));
                            },
                            child: WidgetMyFavorite(
                              icon: Icons.delete_outline,
                              iconBackgroundColor: Colors.red,
                              title: 'Batal',
                              subtitle: 'Apply di batalkan / di tolak ',
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
//      floatingActionButton: !dataProvider.connection
//          ? null
//          : !dataProvider.isLogin
//          ? null
//          : dataProvider.verified
//          ? null
//          : FloatingActionButton.extended(
//        onPressed: () {
//          Navigator.push(
//              context,
//              PageRouteTransition(
//                animationType: AnimationType.slide_up,
//                builder: (context) => UpdateAkunScreen(),
//              )).then((value) {
//            dataProvider.getProfile();
//          });
//          dataProvider.getKategoriByFlag('1');
//        },
//        backgroundColor: Color(0xffb16a085),
//        tooltip: 'Update akun anda',
//        icon: Icon(Icons.credit_card),
//        label: Text("Update Akun"),
//      ),
    );
  }
}
