import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/screen/streamChatting/data/repositories/api.dart';
import 'package:flutter/material.dart';
import 'package:start_jwt/json_web_token.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatModel extends ChangeNotifier {
  /* cunstructor chat service */
  ChatModel() {
    _client = Client(
      APIKEY,
      logLevel: Level.SEVERE,
      tokenProvider: provider,
    );
  }


  /// ***************** START DECLARATION GLOBAL **************** ///

  /* declasai private initialisasi libary chatstream */

  Client _client;

  /* declarasi channel nama (header chat) */

  /* public variable intitalisasi library chatstream */

  Client get client => _client;

  /* end declaration */

  /* private variable channel name (header channel) */
  String _channelName;

  /* global variable channel name (header channel) */
  String get channelName => _channelName;

  /* metode set channelName with string value */
  set channelName(String value) {
    _channelName = value;
    notifyListeners();
  }

  /// ***************** END DECLARATION GLOBAL **************** ///

  /// ***************** START **************** ///
  /* Query get user from api streamchat */

  /*  variable  private data user */
  List<User> _users = [];

  /* variable global data user */
  List<User> get users => _users;

  /* variable private selected user */
  List<User> selectedUsers = [];
  int offset = 0;
  bool loading = false;

  Future<void> queryUsers() {
    _users = [];
    loading = true;
    client
        .queryUsers(
      filter: {'role': 'channel_moderator'},
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
      _users = value.users.toList();
      notifyListeners();
    }).whenComplete(() => loading = false);
  }

  /* End metode query get user */

  /// *************** END ******************* ///

  /// ***************** START **************** ///
  /* Metode set inisialisasi user account chat stream */

  setUser() async {
    await Future.delayed(Duration(seconds: 2));
    if (client.connectionId == null) {
      var userLocal = await LocalStorage.sharedInstance.readValue('chatToken');
      if (userLocal == null) {
        var user = BlocAuth();
        await user.initChat();
        client.setUser(User(id: json.decode(userLocal)['data']['id']), json.decode(userLocal)['token']);
      }
    }
    queryUsers();
  }
}

/* End inisialiasu chat account stream */

/// *************** END ******************* ///

Future<String> provider(String id) async {
  final JsonWebTokenCodec jwt = JsonWebTokenCodec(secret: SECRET);

  final payload = {
    "user_id": id,
  };

  return jwt.encode(payload);
}
