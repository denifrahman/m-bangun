import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocChatService.dart';
import 'package:apps/screen/streamChatting/presentation/pages/ChannelPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ListChannel extends StatefulWidget {
  ListChannel({Key key}) : super(key: key);

  @override
  _ListChannelState createState() {
    return _ListChannelState();
  }
}

class _ListChannelState extends State<ListChannel> {
  final ScrollController _scrollController = ScrollController();
  List<User> users = [];
  List<User> selectedUsers = [];
  int offset = 0;
  bool loading = false;

  @override
  void initState() {
    _setUser();
    super.initState();
  }

  _setUser() async {
    await Future.delayed(Duration(seconds: 2));
    final client = Provider
        .of<ChatModel>(context)
        .client;
    if (Provider
        .of<BlocAuth>(context)
        .isLogin) {
      if (client.connectionId == null) {
        var userLocal = await LocalStorage.sharedInstance.readValue('`chatToken`');
        if (userLocal == null) {
          var user = await Provider.of<BlocAuth>(context).initChat();
          client.setUser(User(id: user['data']['id']), user['token']);
        } else {
          client.setUser(User(id: json.decode(userLocal)['data']['id']), json.decode(userLocal)['token']);
        }
      }
      _scrollController.addListener(() async {
        if (!loading && _scrollController.offset >= _scrollController.position.maxScrollExtent - 100) {
          offset += 25;
          await Provider.of<ChatModel>(context).queryUsers();
        }
      });
      await Provider.of<ChatModel>(context).queryUsers();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<ChatModel>(context);

    if (!Provider
        .of<BlocAuth>(context)
        .isLogin) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.1,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Login Untuk Chat dengan Konsultan kami',
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle1,
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.5,
                  height: 40,
                  decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: IconButton(
                    color: Colors.white,
                    iconSize: 18,
                    onPressed: () async {
                      // Navigator.push(context, MaterialPageRoute(builder: (ctx) => LoginScreen(param: 'home',)));
                      BlocAuth blocAuth = Provider.of<BlocAuth>(context);
                      blocAuth.checkSession();
                      _setUser();
                    },
                    icon: Icon(FontAwesomeIcons.google),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Chat dengan Ahli'),
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          height: client.users.length < 2 ? MediaQuery
              .of(context)
              .size
              .height * 0.2 : MediaQuery
              .of(context)
              .size
              .height * 0.35,
          child: _buildListView(),
        ),
      );
    }
  }

  ListView _buildListView() {
    final client = Provider.of<ChatModel>(context);
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: _itemBuilder,
      itemCount: client.users.length,
    );
  }

  Widget _itemBuilder(context, i) {
    final client = Provider.of<ChatModel>(context);
    final user = client.users[i];
    final jiffyDate = Jiffy(user.lastActive?.toLocal());
    return Card(
      elevation: 0,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        onLongPress: () {
          _selectUser(user);
        },
        selected: selectedUsers.contains(user),
        onTap: () {
          if (selectedUsers.isNotEmpty) {
            print('chat');
            return _selectUser(user);
          }
          print(user.id);
          _createChannel(context, [user]);
        },
        leading: Stack(
          overflow: Overflow.visible,
            children: [
              UserAvatar(
                user: user,
              ),
              Positioned(
                right: 0,
                bottom: -3,
                child: Icon(
                  Icons.circle,
                  size: 13,
                  color: user.online ? Colors.lightGreen : Colors.grey,
                ),
              ),
            ],
        ),
        trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(20.0)
              ),
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
            child: Text(
              'Chat',
              style: TextStyle(color: Colors.white, fontSize: 11),
            )),
        subtitle: Text(
          'Active ${jiffyDate.isBefore(Jiffy()) ? jiffyDate.fromNow() : 'now'}',
          style: Theme
              .of(context)
              .primaryTextTheme
              .subtitle2,
        ),
        title: Text(user.name, style: Theme
            .of(context)
            .textTheme
            .bodyText1),
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.done),
      onPressed: () async {
        String name;
        if (selectedUsers.length > 1) {
          name = await _showEnterNameDialog(context);
          if (name?.isNotEmpty != true) {
            return;
          }
        }

        _createChannel(context, selectedUsers, name);
      },
    );
  }

  Future<String> _showEnterNameDialog(BuildContext context) {
    final controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) =>
          SimpleDialog(
            contentPadding: const EdgeInsets.all(16),
            title: Text('Enter a name for the channel'),
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              ButtonBar(
                children: [
                  FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.pop(context, controller.text),
                    child: Text('Ok'),
                  ),
                ],
              ),
            ],
          ),
    );
  }

  Future _createChannel(BuildContext context, List<User> users, [String name,]) async {
    final client = Provider
        .of<ChatModel>(context)
        .client;
    final channel = client.channel('messaging', extraData: {
      'members': [
        client.state.user.id,
        ...users.map((e) => e.id),
      ],
      if (name != null) 'name': name,
    });
    await channel.watch();
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

  void _selectUser(User user) {
    if (!selectedUsers.contains(user)) {
      setState(() {
        selectedUsers.add(user);
      });
    } else {
      setState(() {
        selectedUsers.remove(user);
      });
    }
  }

  Future<void> _queryUsers() {
    final client = Provider
        .of<ChatModel>(context)
        .client;
    loading = true;
    return client
        .queryUsers(
      filter: {'role': 'user'},
      pagination: PaginationParams(
        limit: 25,
        offset: offset,
      ),
      sort: [
        SortOption(
          'name',
          direction: SortOption.ASC,
        ),
      ],
    )
        .then((value) {
      // print(value.users[0].id);
      setState(() {
        users = [
          ...users,
          ...value.users,
        ];
      });
    }).whenComplete(() => loading = false);
  }
}
