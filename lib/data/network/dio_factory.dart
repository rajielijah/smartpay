
// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../app/constant.dart';


const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "Authorization";


class DioFactory {

  Future<Dio> getDio() async {
    Dio dio = Dio();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
    };

    dio.options = BaseOptions(
        baseUrl: Constant.baseUrl,
        headers: headers);

    if (kReleaseMode) {
    } else {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: false));
    }

    return dio;
  }
}
