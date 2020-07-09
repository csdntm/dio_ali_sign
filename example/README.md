```Dart
import 'package:dio_ali_sign/dio_ali_sign.dart';
import 'package:dio/dio.dart';

void main() async {

  Dio dio = Dio();

  dio.interceptors.add(AliSignInterceptors(
      gatewayHosts: [], //["domain1","domain2"]
      gatewayAppkey: "xxxx",
      gatewayAppsecret: "xxxx"),
      gatewayStage:"PRE");
}
```