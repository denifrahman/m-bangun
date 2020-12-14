import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/screen/KategoriScreen.dart';
import 'package:apps/screen/KonsultasiScreen/presentation/pages/KonsultasiScreen.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:apps/screen/ProfileScreen.dart';
import 'package:apps/widget/Aktivity/Pengajuan/WidgetPengajuanByParamList.dart';
import 'package:apps/widget/Project/PengajuanProject.dart';
import 'package:flutter/cupertino.dart';

final Map<String, WidgetBuilder> routes = {
  '/login': (context) => LoginScreen(),
  '/profile': (context) => ProfileScreen(),
  '/BottomNavBar': (context) => BottomAnimateBar(),
  '/New': (context) => WidgetPengajuanByParamList(),
  '/chat': (context) => KonsultasiScreen(),
  '/request': (context) => PengajuanProject(),
  '/toko': (context) => KategoriScreen(),
};
