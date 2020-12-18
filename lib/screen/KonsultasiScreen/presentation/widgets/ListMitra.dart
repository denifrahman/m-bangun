import 'package:apps/Utils/Component/ButtonSmall.dart';
import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocChatting.dart';
import 'package:apps/screen/KonsultasiScreen/presentation/widgets/ConversationScreen.dart';
import 'package:apps/widget/Pendaftaran/WidgetPendaftaran.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
// import 'package:stream_chat/stream_chat.dart';

class ListMitra extends StatefulWidget {
  ListMitra(
      {Key key, @required this.idBidangKeahlianMitra, @required this.title})
      : super(key: key);
  final idBidangKeahlianMitra;
  final title;

  @override
  _ListMitraState createState() {
    return _ListMitraState();
  }
}

class _ListMitraState extends State<ListMitra> {
  @override
  void initState() {
    getMitraByParam();
    super.initState();
  }

  getMitraByParam() async {
    await Future.delayed(Duration(milliseconds: 1));
    final provider = Provider.of<BlocAuth>(context);
    provider.getMitraByParam({
      'id_bidang_keahlian': widget.idBidangKeahlianMitra.toString(),
      'aktif': '1'
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BlocAuth>(context);
    final blocAuth = Provider.of<BlocAuth>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Chat dengan ahli ' + widget.title)),
      body: provider.isLoading
          ? Container(
              child: PKCardListSkeleton(),
            )
          : ListView.builder(
              itemCount: provider.listMitra.length,
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                var item = provider.listMitra[index];
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
    );
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
}
