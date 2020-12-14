import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/screen/streamChatting/presentation/pages/ChannelPage.dart';
import 'package:apps/widget/Login/LoginWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class StreamChatting extends StatefulWidget {
  StreamChatting({Key key}) : super(key: key);

  @override
  _StreamChattingState createState() => _StreamChattingState();
}

class _StreamChattingState extends State<StreamChatting> {
  @override
  void initState() {
    super.initState();
  }

  final client = Client(
    'd9yg7epnra2p',
    logLevel: Level.INFO,
    persistenceEnabled: true,
  );

  @override
  Widget build(BuildContext context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    // TODO: implement build
    return blocAuth.isLogin ? ChannelListPage() : LoginWidget();
  }
}

class ChannelListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Chat'),
      ),
      body: ChannelsBloc(
        child: ChannelListView(
          filter: {
            'members': {
              '\$in': [StreamChat.of(context).user.id],
            }
          },
          sort: [SortOption('last_message_at')],
          pagination: PaginationParams(
            limit: 20,
          ),
          channelWidget: ChannelPage(),
        ),
      ),
    );
  }
}
