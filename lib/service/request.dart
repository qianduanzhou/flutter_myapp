import 'package:dio/dio.dart';
import 'global.dart';
//请求封装
class Request {
  final String ewaterUrl = '/zcps_ewater';
  final String psgsUrl = '/zcps_psgs';
  final String iotUrl = '/zcps_iot';

  Future sendGet(url, [params]) async{
    Dio dio = new Global().dio;
    late Response response;
    if(params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    return response;
  }

  Future sendPost(url, [params]) async{
    Dio dio = new Global().dio;
    late Response response;
    if(params != null) {
      response = await dio.post(url, data: params);
    } else {
      response = await dio.post(url);
    }
    return response;
  }
}