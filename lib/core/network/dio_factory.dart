
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();
  static Dio? dio;
  
  getDio(){

    Duration timeOut=Duration(seconds: 30);

    if(dio==null){
      dio=Dio();
      dio!
      ..options.connectTimeout=timeOut
      .. options.receiveTimeout=timeOut;
      return dio!;
    }else
    return dio!;

  }
  static void addDioInterceptor(){
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }


}