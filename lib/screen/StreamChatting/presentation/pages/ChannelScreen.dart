import 'package:apps/screen/streamChatting/presentation/pages/ChannelPage.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class CreateChannelPage extends StatefulWidget {
  @override
  _CreateChannelPageState createState() => _CreateChannelPageState();
}

class _CreateChannelPageState extends State<CreateChannelPage> {
  final ScrollController _scrollController = ScrollController();
  Client client;
  List<User> users = [];
  List<User> selectedUsers = [];
  int offset = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Konsultasi',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      floatingActionButton: selectedUsers.isNotEmpty ? _buildFAB(context) : SizedBox(),
      body: _buildListView(),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: _itemBuilder,
      itemCount: users.length,
    );
  }

  Widget _itemBuilder(context, i) {
    final user = users[i];
    print(user);
    return ListTile(
      onLongPress: () {
        _selectUser(user);
      },
      selected: selectedUsers.contains(user),
      onTap: () {
        if (selectedUsers.isNotEmpty) {
          return _selectUser(user);
        }
        _createChannel(context, [user]);
      },
      leading: UserAvatar(
        user: user,
      ),
      title: Text(user.name),
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
      builder: (context) => SimpleDialog(
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

  Future _createChannel(
      BuildContext context,
      List<User> users, [
        String name,
      ]) async {
    final channel = client.channel('messaging', extraData: {
      'members': [
        client.state.user.id,
        ...users.map((e) => e.id),
      ],
      if (name != null) 'name': name,
    });
    await channel.watch();
    Navigator.pushReplacement(
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

  @override
  void initState() {
    super.initState();

    client = StreamChat.of(context).client;

    _scrollController.addListener(() async {
      if (!loading && _scrollController.offset >= _scrollController.position.maxScrollExtent - 100) {
        offset += 25;
        await _queryUsers();
      }
    });

    _queryUsers();
  }

  Future<void> _queryUsers() {
    loading = true;
    return client.queryUsers(
      filter: {'role':'channel_moderator'},
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
    ).then((value) {
      print(value.users[0].id);
      setState(() {
        users = [
          ...users,
          ...value.users,
        ];
      });
    }).whenComplete(() => loading = false);
  }
}
