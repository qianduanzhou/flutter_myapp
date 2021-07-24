import 'request.dart';
//登录相关接口
class LoginService {
  Request request = new Request();
  Future login([params]) async{
    String url = "${request.psgsUrl}/login/loginValidNew2";
    try {
      var res = await request.sendPost(url, params);
      Map<String, dynamic> data = res.data;
      if(data['success'] == true) {
        return data['data'];
      } else {
        throw data['data'];
      }
    } catch (e) {
      throw e;
    }
  }
  Future getImage([params]) async{
    String url = "${request.ewaterUrl}/vcode/getImage";
    try {
      var res = await request.sendGet(url, params);
      Map<String, dynamic> data = res.data;
      if(data['success'] == true) {
        return data['data'];
      } else {
        throw data['data'];
      }
    } catch (e) {
      throw e;
    }
  }
}