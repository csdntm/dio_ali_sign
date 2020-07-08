# dio_ali_sign

用于阿里网关签名的 dio 拦截器

## Getting Started

```

  dio.interceptors.add(AliSignInterceptors(
      gatewayHosts: [], //["domain1","domain2"]
      gatewayAppkey: "xxxx",
      gatewayAppsecret: "xxxx"),
      gatewayStage:"PRE");

```