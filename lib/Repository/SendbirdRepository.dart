import 'dart:async';

import 'package:apps/Api/RestSendBird.dart';
class SendbirdChat {
  Rest _rest = Rest();
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Api-Token': "22e24fb7fd22ac7587163530a093492414d967be",
  };
  var url = "https://api-186AD435-F974-4BFE-8C54-9B64A4D69EAC.sendbird.com/v3/users/";

  Future listUsers() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Api-Token': "22e24fb7fd22ac7587163530a093492414d967be",
    };
    var url = "https://api-186AD435-F974-4BFE-8C54-9B64A4D69EAC.sendbird.com/v3/users/";
    final response = await _rest.getFrom(url, headers);
    print(response);
    return response;
  }

  Future createUser(String userId) async {
    Map<String, dynamic> body = {
      'user_id': userId,
      'nickname': userId,
      'profile_url': ""
    };
    // var result =
    // await this._rest.postTo(this.url, this.headers, body);
    // return result;
  }

  Future<bool> deleteUser(String userId) async {
    String parentURL = this.url;
    String finalURL = '$parentURL$userId';
    // var result = await this._rest.delete(finalURL, this.headers);
    // return result;
  }

  // OPEN CHANNELS
  Future<List> listOpenChannels() async {
    var result =
    await this._rest.getFrom(this.url, this.headers);
    return result["channels"];
  }

  Future createOpenChannel({String name, List<String> userIds}) async {
    Map<String, dynamic> body = {
      'name': name,
      'operator_ids': userIds,
    };
    // var result = await this
    //     ._rest
    //     .postTo(this.url, this.headers, body);
    // return result;
  }

  Future<bool> deleteOpenChannel(String channelUrl) async {
    String parentURL = this.url;
    String finalURL = '$parentURL$channelUrl';
    // var result = await this._rest.delete(finalURL, this.headers);
    // return result;
  }

  Future<List> getOpenChannelMessages(String channelUrl) async {
    String parentURL = this.url;
    String now = DateTime.now().toUtc().millisecondsSinceEpoch.toString();
    String finalURL = '$parentURL$channelUrl/messages?message_ts=$now';
    var result = await this._rest.getFrom(finalURL, this.headers);
    return result["messages"];
  }

  Future<void> sendOpenChannelMessage(
      {String channelUrl, String originUserId, String message}) async {
    String parentURL = this.url;
    String finalURL = '$parentURL$channelUrl/messages';
    Map<String, dynamic> body = {
      'message_type': 'MESG',
      'user_id': originUserId,
      'message': message,
    };
    // var result = await this._rest.postTo(finalURL, this.headers, body);
    // return result;
  }
}
