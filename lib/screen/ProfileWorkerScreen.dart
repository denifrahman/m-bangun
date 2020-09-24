import 'package:apps/Utils/values/colors.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/BlocProject.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Profile/TopContainer.dart';
import 'package:apps/widget/Profile/WidgetMyFavorite.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sup/sup.dart';

class ProfileWorkerScreen extends StatelessWidget {
  ProfileWorkerScreen({Key key}) : super(key: key);

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(color: AppColors.kDarkBlue, fontSize: 20.0, fontWeight: FontWeight.w700, letterSpacing: 1.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocProject blocProject = Provider.of<BlocProject>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        elevation: 0,
        title: Text(
          'Detail Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: blocProfile.detailProfile.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Column(
                children: <Widget>[
                  TopContainer(
                    height: 100,
                    width: width,
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
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
                                      blocProfile.detailProfile[0].foto,
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
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: dataProvider.verified ? 5 : 0),
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          text: TextSpan(
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                              ),
                                              text: blocProfile.detailProfile[0].nama),
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
                                        color: Colors.grey[400],
                                      ),
                                      text: blocProfile.detailProfile[0].email,
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
                  Expanded(
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
                                    subheading('Detail Mitra'),
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
                          WidgetMyFavorite(
                            icon: Icons.account_balance,
                            iconBackgroundColor: Colors.orange,
                            title: blocProfile.detailProfile[0].jenisMitra.toUpperCase(),
                            subtitle: 'Jenis Mitra',
                          ),
                          SizedBox(height: 15.0),
                          WidgetMyFavorite(
                            icon: Icons.card_membership,
                            iconBackgroundColor: Colors.cyan,
                            title: blocProfile.detailProfile[0].namaPemilik,
                            subtitle: 'Nama Pemilik',
                          ),
                          SizedBox(height: 15.0),
                          WidgetMyFavorite(
                            icon: Icons.place,
                            iconBackgroundColor: AppColors.kRed,
                            title: blocProfile.detailProfile[0].alamat,
                            subtitle: 'Alamat',
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subheading('Keahlian Mitra'),
                              GestureDetector(
                                onTap: () {},
                                child: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: AppColors.mainColor,
                                  child: Icon(
                                    Icons.style,
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 100,
                            child: ListView.builder(
                                itemCount: blocProfile.jenisLayananMitra.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: WidgetMyFavorite(
                                      icon: Icons.style,
                                      iconBackgroundColor: Colors.amber,
                                      title: blocProfile.jenisLayananMitra[index].nama,
                                      subtitle: 'Keahlian Mitra',
                                    ),
                                  );
                                }),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subheading('Proyek Selesai'),
                              GestureDetector(
                                onTap: () {},
                                child: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.done_all,
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 150,
                            child: blocProject.listBids.isEmpty
                                ? Center(
                              child: Sup(
                                title: Text('Tidak ada proyek selesai', style: TextStyle(fontSize: 12),),
                                image: Image.asset(
                                  'assets/icons/empty_cart.png',
                                  height: 60,
                                ),
                              ),
                            )
                                : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: blocProject.listBids.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 120,
                                    height: 150,
                                    child: GridTile(
                                      header: Image.network(
                                        blocProject.listBids[index].foto1,
                                        errorBuilder: (context, urlImage, error) {
                                          print(error.hashCode);
                                          return Image.asset(
                                            'assets/logo.png',
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                      child: Container(),
                                      footer: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(blocProject.listBids[index].nama),
                                                  Icon(
                                                    Icons.done_all,
                                                    color: Colors.green,
                                                    size: 12,
                                                  )
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    blocProject.listBids[index].tipeLokasi,
                                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                                  ),
                                                  Text(
                                                    blocProject.listBids[index].updatedAt,
                                                    style: TextStyle(fontSize: 10, color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
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
    );
  }
}
