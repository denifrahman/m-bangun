import 'package:apps/Api/ApiBaseHelper.dart';
import 'package:apps/Api/RestSendBird.dart';

class ChatRepository {
  Rest rest = Rest();
  ApiBaseHelper _helper = ApiBaseHelper();

  Future getUsers(param) async {
    final response = await rest.getFrom('users', param);
    return response;
  }

  Future getListChannel(param) async {
    final response = await rest.getFrom('group_channels', param);
    return response;
  }

  Future createUser(body) async {
    final response = await rest.post('users', body);
    return response;
  }

  Future getChannelMessage(channelUrl, param) async {
    final response = await rest.getFrom('group_channels/' + channelUrl + '/messages', param);
    return response;
  }

  Future sendMessage(channelUrl,body) async {
    final response = await rest.post('group_channels/' + channelUrl + '/messages',body);
    return response;
  }

  Future readMessage(channelUrl,messageId,body) async {
    final response = await rest.post('group_channels/' + channelUrl + '/messages/'+ messageId,body);
    return response;
  }

  Future getBidangKeahlian(param) async {
    final response = await _helper.get('BidangKeahlian/getAllByParam',param);
    return response;
  }
}
