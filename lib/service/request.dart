import 'package:dio/dio.dart';
import 'global.dart';
//请求封装
class Request {
  final String ewaterUrl = '/zcps_ewater';
  final String psgsUrl = '/zcps_psgs';
  final String iotUrl = '/zcps_iot';

  Future sendGet(url, params) async{
    Dio dio = new Global().dio;
    Response response = await dio.get(url, queryParameters: params);
    return response;
  }

  Future sendPost(url, params) async{
    print('sendPost');
    Dio dio = new Global().dio;
    Response response = await dio.post(url, data: params);
    return response;
  }
}