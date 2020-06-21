import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/Utils/values/colors.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/UpdateAkunScreen.dart';
import 'package:apps/widget/Login/LoginWidget.dart';
import 'package:apps/widget/Profile/ActiveProjectCard.dart';
import 'package:apps/widget/Profile/TopContainer.dart';
import 'package:apps/widget/Profile/WidgetMyFavorite.dart';
import 'package:apps/widget/Profile/WidgetProfile.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key key}) : super(key: key);

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(color: AppColors.kDarkBlue, fontSize: 20.0, fontWeight: FontWeight.w700, letterSpacing: 1.2),
    );
  }

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
    print(dataProvider.userFoto);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: !dataProvider.isLogin
          ? LoginWidget(
              primaryColor: Color(0xFFb16a085),
              backgroundColor: Colors.white,
              page: '/BottomNavBar',
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
                                  dataProvider.setLoading(true);
                                  dataProvider.getProfile();
                                },
                                icon: Icon(Icons.edit, color: AppColors.kDarkBlue, size: 20.0),
                              ),
                              IconButton(
                                onPressed: () {
                                  dataProvider.logout(context);
                                },
                                icon: Icon(Icons.exit_to_app, color: Colors.grey[400], size: 20.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircularPercentIndicator(
                              radius: 90.0,
                              lineWidth: 5.0,
                              animation: true,
                              percent: 0.75,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: AppColors.kRed,
                              backgroundColor: AppColors.kDarkYellow,
                              center: Container(
                                  width: 80.0,
                                  height: 80.0,
                                  child: ClipOval(
                                    child: Image.network(
                                      dataProvider.userFoto == null ? dataProvider.fotoNull : dataProvider.userFoto,
                                      fit: BoxFit.cover,
                                      width: 100,
                                    ),
                                  )),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      !dataProvider.verified
                                          ? Container()
                                          : Container(
                                              child: Image(width: 18, fit: BoxFit.contain, image: new AssetImage('assets/icons/verified.png'))),
                                      Container(
                                        width: 200,
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
                                              text: dataProvider.userNama),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    dataProvider.userEmail,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400,
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
                                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                                      WidgetMyFavorite(
                                        icon: Icons.alarm,
                                        iconBackgroundColor: Colors.blue,
                                        title: 'New',
                                        subtitle: 'Bid pekerjaan baru anda',
                                      ),
                                      SizedBox(height: 15.0),
                                      WidgetMyFavorite(
                                        icon: Icons.blur_circular,
                                        iconBackgroundColor: Colors.green,
                                        title: 'Kontrak',
                                        subtitle: 'Penandatangan kontrak kerja',
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      WidgetMyFavorite(
                                        icon: Icons.blur_circular,
                                        iconBackgroundColor: AppColors.kDarkYellow,
                                        title: 'In Progress',
                                        subtitle: 'Proses Pengerjaan dan laporan pekerjaan',
                                      ),
                                      SizedBox(height: 15.0),
                                      WidgetMyFavorite(
                                        icon: Icons.check_circle_outline,
                                        iconBackgroundColor: AppColors.kBlue,
                                        title: 'Done',
                                        subtitle: '18 tasks now. 13 started',
                                      ),
                                      SizedBox(height: 15.0),
                                      WidgetMyFavorite(
                                        icon: Icons.delete_outline,
                                        iconBackgroundColor: Colors.red,
                                        title: 'Batal',
                                        subtitle: 'Apply di batalkan / di tolak ',
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      subheading('Perkerjaan Aktif'),
                                      SizedBox(height: 5.0),
                                      Row(
                                        children: <Widget>[
                                          ActiveProjectsCard(
                                            cardColor: AppColors.kGreen,
                                            loadingPercent: 0.25,
                                            title: 'Medical App',
                                            subtitle: '9 hours progress',
                                          ),
                                          SizedBox(width: 20.0),
                                          ActiveProjectsCard(
                                            cardColor: AppColors.kRed,
                                            loadingPercent: 0.6,
                                            title: 'Making History Notes',
                                            subtitle: '20 hours progress',
                                          ),
                                        ],
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
      floatingActionButton: dataProvider.userKategori != null
          ? null
          : dataProvider.isLogin
              ? null
              : FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageRouteTransition(
                          animationType: AnimationType.slide_up,
                          builder: (context) => UpdateAkunScreen(),
                        )).then((value) {
                      dataProvider.getProfile();
                    });
                  },
                  backgroundColor: Color(0xffb16a085),
                  tooltip: 'Update akun anda',
                  icon: Icon(Icons.credit_card),
                  label: Text("Update Akun"),
                ),
    );
  }
}
