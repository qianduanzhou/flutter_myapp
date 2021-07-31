import 'package:flutter/cupertino.dart';

import 'request.dart';
//登录相关接口
class LoginService {
  final BuildContext context;
  LoginService(this.context);

  Request request = new Request();
  Future login([params]) async{
    String url = "${request.psgsUrl}/login/loginValidNew2";
    try {
      var res = await request.sendPost(url, params);
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
  Future getImage([params]) async{
    String url = "${request.ewaterUrl}/vcode/getImage";
    try {
      var res = await request.sendGet(url, params);
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
  Future getUserInfo([params]) async{
    String url = "${request.ewaterUrl}/sysUser/getUserInfo";
    try {
      var res = await request.sendGet(url, params);
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