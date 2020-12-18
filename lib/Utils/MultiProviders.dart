import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocChatService.dart';
import 'package:apps/providers/BlocChatting.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/BlocProject.dart';
import 'package:apps/providers/Categories.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/PhoneAuth/presentation/manager/countries.dart';
import 'package:apps/screen/PhoneAuth/presentation/manager/phone_auth.dart';
import 'package:provider/provider.dart';

final List<SingleChildCloneableWidget> multiProviders = [
  ChangeNotifierProvider<DataProvider>(
    create: (_) => DataProvider(),
  ),
  ChangeNotifierProvider<BlogCategories>(
    create: (_) => BlogCategories(),
  ),
  ChangeNotifierProvider<BlocAuth>(
    create: (_) => BlocAuth(),
  ),
  ChangeNotifierProvider<BlocProduk>(
    create: (_) => BlocProduk(),
  ),
  ChangeNotifierProvider<BlocProfile>(
    create: (_) => BlocProfile(),
  ),
  ChangeNotifierProvider<BlocOrder>(
    create: (_) => BlocOrder(),
  ),
  ChangeNotifierProvider<BlocProject>(
    create: (_) => BlocProject(),
  ),
  ChangeNotifierProvider<BlocChatting>(
    create: (_) => BlocChatting(),
  ),
  ChangeNotifierProvider<ChatModel>(
    create: (_) => ChatModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => CountryProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => PhoneAuthDataProvider(),
  ),
];
