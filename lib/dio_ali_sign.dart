library dio_ali_sign;

import 'package:ali_cloudapi_sign/ali_cloudapi_sign.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

/// dio Interceptor 给通过网关的请求加上签名
/// @required [gatewayHosts] 网关域名，可以是多个域名
/// @required [gatewayAppkey] Appkey
/// @required [gatewayAppsecret] Appsecret
/// optional [gatewayStage] PRE/TEST ，为空是表示生产环境
class AliSignInterceptors extends InterceptorsWrapper {
  final List<String> gatewayHosts;
  final String gatewayAppkey;
  final String gatewayAppsecret;
  final String gatewayStage;

  AliSignInterceptors({
    @required this.gatewayHosts,
    @required this.gatewayAppkey,
    @required this.gatewayAppsecret,
    this.gatewayStage = '',
  }) {
    assert(gatewayHosts.isNotEmpty);
    assert(gatewayAppkey.isNotEmpty);
    assert(gatewayAppsecret.isNotEmpty);
    AliSign.gatewayHosts = gatewayHosts;
    AliSign.gatewayAppkey = gatewayAppkey;
    AliSign.gatewayAppsecret = gatewayAppsecret;
    AliSign.gatewayStage = gatewayStage;
  }

  @override
  Future onRequest(RequestOptions options) {
    options.contentType = Headers.jsonContentType;
    options.responseType = ResponseType.json;

    if (AliSign.gatewayHosts.contains(options.uri.host)) {
      var signHeaders =
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
