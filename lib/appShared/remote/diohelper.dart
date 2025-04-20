import 'package:asdsmartcare/networking/api_constants.dart';
import 'package:dio/dio.dart';

// change here from the project
class Diohelper {
  static late Dio dio;
// if error look at  headers
  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: ApiConstants.apiBaseUrl,
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
          }),
    );
  }

  static Future<Response> getData(
      {required String url,
       Map<String, dynamic> ?query,
        String ?token,
      }) async {
    final options = Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return await dio.get(url, queryParameters: query,options: options);
  }

  static Future<Response> PostData({
    required data,
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    final options = Options(
      headers: {
        'Content-Type': 'application/json',
         'Authorization': 'Bearer $token',
      },
    );
    Response<dynamic> res = await dio.post(
      url,
      queryParameters: query,
      data: data,
      options: options,
    );
    print("hello");
    return res;
  }

static Future<Response> DeleteData({
    required String url,
    required data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    final options = Options(
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    Response<dynamic> res = await dio.delete(
      url,
      queryParameters: query,
      options: options,
      data: data,
    );
    print("DELETE >> ${res.statusCode}");
    return res;
  }

}
