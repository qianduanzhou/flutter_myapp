import 'package:flutter/cupertino.dart';
import 'package:flutter_myapp/models/user.dart';
import 'package:provider/provider.dart';
import 'request.dart';

class MonitorService {
  final BuildContext context;
  MonitorService(this.context);

  Request request = new Request();
  Future getList([params]) async{
    String url = "${request.iotUrl}/facility/getFacilityRealTimeDataByToken";
    try {
      String token = Provider.of<UserModel>(context, listen: false).token;
      print('token$token');
      params['token'] = token;
      var res = await request.sendGet(url, Map<String, dynamic>.from(params));
      Map<String, dynamic> data = res.data;
      if(data['success'] == true) {
        return data['data'];
      } else {
        throw data;
      }
    } catch (e) {
      throw e;
    }
  }
}