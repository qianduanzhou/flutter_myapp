import 'package:dio/dio.dart';
//全局dio 单例模式
class Global {
  static late final Global _instance;//Global实例
  late Dio dio;//dio对象
  static bool _isInternal = false;//是否初始化

  Global._internal() {
    dio = new Dio(BaseOptions(
      baseUrl: 'https://zhps.zc.gov.cn',
      connectTimeout: 30000,
      receiveTimeout: 3000,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler) {
        // Do something before request is sent
        return handler.next(options); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: return `dio.resolve(response)`.
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: return `dio.reject(dioError)`
      },
      onResponse:(response,handler) {
        // Do something with response data
        return handler.next(response); // continue
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: return `dio.reject(dioError)` 
      },
      onError: (DioError e, handler) {
        // Do something with response error
        return  handler.next(e);//continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: return `dio.resolve(response)`.  
      }
    ));
  }

  factory Global() => _getInstance();

  static Global _getInstance() {
    if(_isInternal == false) {
      _instance = new Global._internal();
      _isInternal = true;
    }
    return _instance;
  }
}