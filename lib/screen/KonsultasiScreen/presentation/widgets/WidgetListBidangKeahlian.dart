import 'package:apps/providers/BlocChatting.dart';
import 'package:apps/screen/KonsultasiScreen/data/models/BidangKeahLianModel.dart';
import 'package:apps/screen/KonsultasiScreen/presentation/widgets/ListMitra.dart';
import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';

class ListBidangKeahlian extends StatefulWidget {
  ListBidangKeahlian({Key key}) : super(key: key);

  @override
  _ListBidangKeahlianState createState() {
    return _ListBidangKeahlianState();
  }
}

class _ListBidangKeahlianState extends State<ListBidangKeahlian> {
  @override
  void initState() {
    getBidangKeahlian();
    super.initState();
  }

  getBidangKeahlian() async {
    await Future.delayed(Duration(milliseconds: 1));
    final provider = Provider.of<BlocChatting>(context);
    await provider.getBidangKeahlianByParam({'aktif': '1'});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BlocChatting>(context);
    // TODO: implement build
    return provider.isLoading
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: PKCardPageSkeleton(
              totalLines: 4,
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            child: GridView.count(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 0.2,
              padding: EdgeInsets.all(10),
              children: List.generate(provider.listBidangKeahlian.length, (j) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () => _openListMitra(context, provider.listBidangKeahlian[j]),
                        child: new Container(
                          height: 65,
                          width: 65,
                          margin: EdgeInsets.only(bottom: 5, top: 0),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            gradient: new LinearGradient(
                                colors: [Color(0xffb16a085).withOpacity(0.1), Colors.white],
                                begin: const FractionalOffset(7.0, 10.1),
                                end: const FractionalOffset(0.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: new Center(
                            child: Image.network(
                              provider.listBidangKeahlian[j].icon.toString(),
                              height: 40,
                              width: 40,
                              errorBuilder: (context, urlImage, error) {
                                print(error.hashCode);
                                return Image.asset('assets/logo.png');
                              },
                            ),
                          ),
                        ),
                      ),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          text: provider.listBidangKeahlian[j].nama,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          );
  }

  _openListMitra(BuildContext context, BidangKeahLianModel listBidangKeahlian) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListMitra(idBidangKeahlianMitra: listBidangKeahlian.id,title: listBidangKeahlian.nama,),
      ),
    );
  }
}
