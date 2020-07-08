library dio_ali_sign;

import 'package:ali_cloudapi_sign/ali_cloudapi_sign.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AliSignInterceptors extends InterceptorsWrapper {
  final List<String> gatewayHosts;
  final String gatewayAppkey;
  final String gatewayAppsecret;
  final String gatewayStage;

  AliSignInterceptors({
    @required this.gatewayHosts,
    @required this.gatewayAppkey,
    @required this.gatewayAppsecret,
    this.gatewayStage = "",
  }) {
    AliSign.gatewayHosts = this.gatewayHosts;
    AliSign.gatewayAppkey = this.gatewayAppkey;
    AliSign.gatewayAppsecret = this.gatewayAppsecret;
    AliSign.gatewayStage = this.gatewayStage;
  }

  @override
  Future onRequest(RequestOptions options) {
    options.contentType = Headers.jsonContentType;
    options.responseType = ResponseType.json;

    if (AliSign.gatewayHosts.contains(options.uri.host)) {
      Map<String, String> signHeaders =
          AliSign.creatAliGatewaySign(options.method, options.uri);

      options.headers.addAll(signHeaders);
    }
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    return super.onError(err);
  }
}
