import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dio_ali_sign/dio_ali_sign.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void main() {
  final String urlGet = Platform.environment['urlGet'];

  final String urlPost = Platform.environment['urlPost'];

  Dio dio = Dio();

  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 90));

  dio.interceptors.add(AliSignInterceptors(
      gatewayHosts: Platform.environment['gatewayHosts']?.split(","),
      gatewayAppkey: Platform.environment['gatewayAppkey'],
      gatewayAppsecret: Platform.environment['gatewayAppsecret']));
  test('test get request', () async {
    var response = await dio.get(urlGet);
    expect(response.data, contains('url'));
  });

  test('test post request', () async {
    var response = await dio.post(urlPost, data: {"a": "1"});
    expect(response.data, contains('url'));
  });
}
