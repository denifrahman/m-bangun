import 'package:apps/Utils/Component/ButtonFullWidth.dart';
import 'package:apps/Utils/Component/ButtonSmall.dart';
import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocChatService.dart';
import 'package:apps/screen/streamChatting/presentation/pages/ChannelPage.dart';
import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ListMitra extends StatefulWidget {
  ListMitra({Key key, @required this.idBidangKeahlianMitra, @required this.title}) : super(key: key);
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
    provider.getMitraByParam({'id_bidang_keahlian': widget.idBidangKeahlianMitra.toString(),'aktif':'1'});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BlocAuth>(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Chat dengan ahli '+widget.title)),
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
                      _createChannel(context, item.idGoogle);
                    },
                    contentPadding: EdgeInsets.all(10),
                    title: Text(item.nama,),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.namaBidangKeahlian ,style: TextStyle(fontSize: 12,)),
                        SizedBox(height: 20,),
                        Text('Curiculum Vitae :' ,style: TextStyle(color: Colors.black, fontSize: 12),),
                        Text(item.pengalamanKerja, style: Theme.of(context).textTheme.caption,),
                        SizedBox(height: 5,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ButtonSmall(color: Colors.cyan[800],title: 'Chat',),
                          ],
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      child: ClipOval(
                        child: Image.network(baseURLMobile + '/' + '/assets/img/toko/' + item.foto.toString(), height: 50, width: 50, errorBuilder: (context, urlImage, error) {
                          print(error.hashCode);
                          return Image.asset('assets/logo.png');
                        }),
                      ),
                    ),
                    // trailing: Column(
                    //   children: [
                    //     SizedBox( height: 10,),
                    //     ButtonSmall(color: Colors.cyan[800],title: 'Chat',),
                    //   ],
                    // ),
                  ),
                );
              },
            ),
    );
  }

  Future _createChannel(
    BuildContext context,
    idGoogle, [
    String name,
  ]) async {
    final client = Provider.of<ChatModel>(context).client;
    final channel = client.channel('messaging', extraData: {
      'members': [
        client.state.user.id,
        '081331339866',
      ],
      if (name != null) 'name': name,
    });
    var result = await channel.watch();
    if (result != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return StreamChannel(
              child: ChannelPage(),
              channel: channel,
            );
          },
        ),
      );
    }
  }
}
