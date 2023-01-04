import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http:///192.168.1.2:8080/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
  }) async
  {
    return await dio.get(
        url,
    );
  }
  static Future<Response> deleteData({
    required String url,
  }) async
  {
    return await dio.delete(
      url,
    );
  }

  //unauthorized post request
  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
  }) async
  {
    return dio.post(
      url,
      data: data,
    );
  }

  //authorized post request
  static Future<Response> postDataVer({
    required String url,
    required String token,
    required Map<String, dynamic> data,
  }) async
  {
    return dio.post(
      url,
      options: Options(
          headers: {"Authorization" : "Bearer ${token}"}
      ),
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    required String token,
    required Map<String, dynamic> data,
  }) async
  {
    return dio.put(
      url,
      options: Options(
          headers: {"Authorization" : "Bearer ${token}"}
      ),
      data: data,
    );
  }
}