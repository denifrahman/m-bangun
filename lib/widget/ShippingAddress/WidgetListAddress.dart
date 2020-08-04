import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/widget/ShippingAddress/WidgetUpdateAddress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetListAddress extends StatelessWidget {
  WidgetListAddress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    return SingleChildScrollView(
      child: blocProfile.isLoading
          ? Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                  itemCount: blocProfile.listUserAddress.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Row(
                          children: [
                            Text(blocProfile.listUserAddress[index].namaAlamat),
                            SizedBox(
                              width: 10,
                            ),
                            blocProfile.listUserAddress[index].defaultAlamat == '1'
                                ? Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.green),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'default',
                                        style: TextStyle(fontSize: 8, color: Colors.white),
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text('#' + blocProfile.listUserAddress[index].namaPenerima),
                            SizedBox(
                              width: 10,
                            ),
                            Text(blocProfile.listUserAddress[index].alamatLengkap),
                          ],
                        ),
                        selected: blocProfile.listUserAddress[index].defaultAlamat == '1' ? true : false,
                        trailing: IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          onPressed: () {
                            blocProfile.clearDataCity();
                            blocProfile.getUserAddressById(blocProfile.listUserAddress[index].id);
                            blocProfile.getSubDistrictById(blocProfile.listUserAddress[index].idKecamatan);
                            Navigator.push(context, SlideRightRoute(page: WidgetUpdateAddress())).then((value) {
                              blocProfile.getUserAddress(blocAuth.idUser);
                              blocProfile.clearDataCity();
                            });
                          },
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
