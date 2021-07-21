import 'request.dart';
//登录相关接口
class LoginService {
  Request request = new Request();
  Future login(params) async{
    String url = "${request.psgsUrl}/login/loginValidNew2";
    request.sendPost(url, params).then((res) => {
      print(res)
    });
  }
}