import 'package:dio/dio.dart';

/**
 *
 * 网络请求缓存拦截器
 *
 */
class CacheInterceptor extends InterceptorsWrapper {
  CacheInterceptor();

  var _cache = new Map<Uri, Response>();

  @override
  onRequest(RequestOptions options) {
    Response response = _cache[options.uri];
    if (options.extra["refresh"] == true) {
      print("${options.uri}: force refresh, ignore cache! \n");
      return options;
    } else if (response != null) {
      print("cache hit: ${options.uri} \n");
      return response;
    }
  }

  @override
  onResponse(Response response) {
    _cache[response.request.uri] = response;
  }

  @override
  onError(DioError e) {
    print('onError: $e');
  }
}