import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/screen/CheckoutScreen.dart';
import 'package:apps/widget/Keranjang/components/shop_item_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';

class Keranjang extends StatefulWidget {
  Keranjang({Key key}) : super(key: key);

  @override
  _KeranjangState createState() => _KeranjangState();
}

final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');

class _KeranjangState extends State<Keranjang> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    AppBar appBar = AppBar(
      elevation: 0,
      title: Text('Keranjang'),
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: (MediaQuery.of(context).size.height - 20) - (appBar.preferredSize.height + MediaQuery.of(context).padding.top),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: blocOrder.listCart.length,
                        itemBuilder: (_, i) {
                          var subTotal = blocOrder.listCart[i].chilrdern.map<int>((m) => int.parse(m.subtotal)).reduce((a, b) => a + b);
                          return Container(
                            child: Column(
                              children: [
                                Divider(
                                  thickness: 2,
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: ListTile(
                                    title: Text(blocOrder.listCart[i].flag),
                                    leading: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(FontAwesomeIcons.personBooth),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Colors.orangeAccent,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Colors.orangeAccent,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Colors.orangeAccent,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Colors.orangeAccent,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, j) {
                                      return ShopItemList(
                                        chilrdern: blocOrder.listCart[i].chilrdern[j],
                                        index: j,
                                        onRemove: () {
                                          blocOrder.removeCart(blocOrder.listCart[i].chilrdern[j].id);
                                        },
                                      );
                                    },
                                    itemCount: blocOrder.listCart[i].chilrdern.length,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  color: Colors.cyan[500].withOpacity(0.7),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Subtotal',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                                      ),
                                      Text(
                                        blocOrder.listCart[i].chilrdern.length.toString() + ' items',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200, fontSize: 16),
                                      ),
                                      Text(
                                        Money.fromInt(subTotal, IDR).toString(),
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.95,
                                  margin: EdgeInsets.only(top: 5),
                                  height: 50,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.deepOrange),
                                  child: InkWell(
                                    onTap: () {
                                      Provider.of<BlocProfile>(context).getProvince();
                                      Provider.of<BlocProfile>(context).getUserAddressDefault();
                                      Provider.of<BlocProfile>(context).getSubDistrictById(blocOrder.listCart[i].chilrdern[0].idKecamatan);

                                      Navigator.push(
                                          context,
                                          SlideRightRoute(
                                              page: CheckoutScreen(
                                                  listCart: blocOrder.listCart[i],
                                                  subtotal: blocOrder.listCart[i].chilrdern.map<int>((m) => int.parse(m.subtotal)).reduce((a, b) => a + b))));
                                    },
                                    child: Center(
                                      child: Text(
                                        'Checkout',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 20,
            child: Center(child: Text('m-Bangun Shop 2020')),
          )
        ],
      ),
    );
  }
}
