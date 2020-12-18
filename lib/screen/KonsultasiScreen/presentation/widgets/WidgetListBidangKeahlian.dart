import 'package:apps/Utils/Component/ButtonSmall.dart';
import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocChatService.dart';
import 'package:apps/providers/BlocChatting.dart';
import 'package:apps/screen/KonsultasiScreen/data/models/BidangKeahLianModel.dart';
import 'package:apps/screen/KonsultasiScreen/presentation/widgets/ConversationScreen.dart';
import 'package:apps/screen/KonsultasiScreen/presentation/widgets/ListMitra.dart';
import 'package:apps/widget/Pendaftaran/WidgetPendaftaran.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
// import 'package:stream_chat/stream_chat.dart';

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
    getMitraByParam();
    super.initState();
  }

  getBidangKeahlian() async {
    await Future.delayed(Duration(milliseconds: 1));
    final provider = Provider.of<BlocChatting>(context);
    await provider.getBidangKeahlianByParam({'aktif': '1'});
  }

  getMitraByParam() async {
    await Future.delayed(Duration(milliseconds: 1));
    final provider = Provider.of<BlocAuth>(context);
    provider.getMitraByParam({'limit': '2'});
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
            child: PKCardListSkeleton(),
          )
        : Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                _buildRecomendasi(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.cyan[600],
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.white,
                      )),
                      Text(
                        'Pilih kategori lainnya',
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                          child: Divider(
                        color: Colors.white,
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 0.2,
                    padding: EdgeInsets.all(10),
                    children:
                        List.generate(provider.listBidangKeahlian.length, (j) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () => _openListMitra(
                                  context, provider.listBidangKeahlian[j]),
                              child: new Container(
                                height: 65,
                                width: 65,
                                margin: EdgeInsets.only(bottom: 5, top: 0),
                                decoration: new BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  gradient: new LinearGradient(
                                      colors: [
                                        Color(0xffb16a085).withOpacity(0.1),
                                        Colors.white
                                      ],
                                      begin: const FractionalOffset(7.0, 10.1),
                                      end: const FractionalOffset(0.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                child: new Center(
                                  child: Image.network(
                                    provider.listBidangKeahlian[j].icon
                                        .toString(),
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
                ),
              ],
            ),
          );
  }

  _openListMitra(BuildContext context, BidangKeahLianModel listBidangKeahlian) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListMitra(
          idBidangKeahlianMitra: listBidangKeahlian.id,
          title: listBidangKeahlian.nama,
        ),
      ),
    ).then((value) {
      getMitraByParam();
    });
  }

  Future _createOrGetConverence({String nama, String fromUser}) async {
    final blocChat = Provider.of<BlocChatting>(context);
    final blocAuth = Provider.of<BlocAuth>(context);
    if (blocAuth.currentUserLogin['email'] == null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => WidgetPendaftaran()));
      Flushbar(
        title: "Maaf",
        message: 'Silahkan lengkapi profil anda',
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.TOP,
        icon: Icon(
          Icons.assignment_turned_in,
          color: Colors.white,
        ),
      )..show(context);
    } else {
      var chatRoomId = await blocChat.getChatRoomId(
          sendBy: blocAuth.currentUserChat.uid, sendFrom: fromUser);
      var dataMember = [blocAuth.currentUserChat.uid, fromUser];
      await blocChat.createChatRoom(
          chatroomId: chatRoomId,
          member: dataMember,
          owner: blocAuth.currentUserChat.uid);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConversationScreen(
            fromUser: nama,
          ),
        ),
      );
    }
  }

  Widget _buildRecomendasi() {
    final blocAuth = Provider.of<BlocAuth>(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rekomendasi',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text('Rekomendasi untuk anda'),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: blocAuth.listMitra.length,
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                var item = blocAuth.listMitra[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      _createOrGetConverence(
                          nama: blocAuth.listMitra[index].nama,
                          fromUser: blocAuth.listMitra[index].noHp);
                    },
                    contentPadding: EdgeInsets.all(10),
                    title: Text(
                      item.nama,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.namaBidangKeahlian,
                            style: TextStyle(
                              fontSize: 12,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Curiculum Vitae :',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        Text(
                          item.pengalamanKerja,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: ButtonSmall(
                        color: Colors.cyan[800],
                        title: 'Chat',
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      child: ClipOval(
                        child: Image.network(
                            baseURLMobile +
                                '/' +
                                '/assets/img/toko/' +
                                item.foto.toString(),
                            height: 50,
                            width: 50,
                            errorBuilder: (context, urlImage, error) {
                          print(error.hashCode);
                          return Image.asset('assets/logo.png');
                        }),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
