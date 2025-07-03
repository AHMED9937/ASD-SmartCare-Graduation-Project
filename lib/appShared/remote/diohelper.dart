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
   

      {dynamic data,required String url,
       Map<String, dynamic> ?query,
        String ?token,
      }) async {
    final options = Options(
      
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return await dio.get(url, queryParameters: query,options: options,data: data);
  }
static Future<Response> PostData({
  required dynamic data,
  required String url,
  Map<String, dynamic>? query,
  String? token,
  Options? options,             // <-- new optional parameter
}) async {
  // 1. Build default headers
  final defaultHeaders = {
    'Authorization': token != null ? 'Bearer $token' : null,
    // we'll set Content-Type below
  }..removeWhere((_, v) => v == null);

  // 2. Determine content type
  String contentType = 'application/json';
  if (data is FormData) {
    contentType = 'multipart/form-data';
  }

  // 3. Merge headers from caller options (if any)
  final mergedHeaders = <String, dynamic>{
    ...defaultHeaders,
    'Content-Type': contentType,
    if (options?.headers != null) ...options!.headers!,
  };

  // 4. Build final Options
  final finalOptions = options?.copyWith(
    headers: mergedHeaders,
  ) ??
      Options(headers: mergedHeaders);

  // 5. Fire request
  Response<dynamic> res = await dio.post(
    url,
    queryParameters: query,
    data: data,
    options: finalOptions,
  );
  print("POST $url → ${res.statusCode}");
  return res;
}
static Future<Response> PutData({
  required dynamic data,
  required String url,
  Map<String, dynamic>? query,
  String? token,
  Options? options,
}) async {
  // 1. Build default headers
  final defaultHeaders = {
    'Authorization': token != null ? 'Bearer $token' : null,
  }..removeWhere((_, v) => v == null);

  // 2. Determine content type
  String contentType = 'application/json';
  if (data is FormData) {
    contentType = 'multipart/form-data';
  }

  // 3. Merge headers from caller options (if any)
  final mergedHeaders = <String, dynamic>{
    ...defaultHeaders,
    'Content-Type': contentType,
    if (options?.headers != null) ...options!.headers!,
  };

  // 4. Build final Options
  final finalOptions = options?.copyWith(
    headers: mergedHeaders,
  ) ??
      Options(headers: mergedHeaders);

  // 5. Fire request
  Response<dynamic> res = await dio.put(
    url,
    queryParameters: query,
    data: data,
    options: finalOptions,
  );
  print("PUT $url → ${res.statusCode}");
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
