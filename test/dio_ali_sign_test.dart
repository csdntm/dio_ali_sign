import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test/test.dart';

import 'package:dio_ali_sign/dio_ali_sign.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void main() {
  final urlGet = Platform.environment['urlGet'];

  final urlPost = Platform.environment['urlPost'];

  var dio = Dio();

  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 90));

  dio.interceptors.add(AliSignInterceptors(
      gatewayHosts: Platform.environment['gatewayHosts']?.split(','),
      gatewayAppkey: Platform.environment['gatewayAppkey'],
      gatewayAppsecret: Platform.environment['gatewayAppsecret'],
      gatewayStage: ''));
  test('test get request', () async {
    var response = await dio.get(urlGet);
    expect(response.data, contains('url'));
  });

  test('test post request', () async {
    var response = await dio.post(urlPost, data: {'a': '1'});
    expect(response.data, contains('url'));
  });

  test('test post file', () async {
    var formData = FormData.fromMap({
      'name': 'wendux',
      'age': 25,
      'file': await MultipartFile.fromFile('./pubspec.yaml',
          filename: 'pubspec.yaml')
    });
    var response = await dio.post(urlPost, data: formData);

    expect(response.data, contains('files'));
  });
}
