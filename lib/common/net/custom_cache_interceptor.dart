import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tianyue/common/cache/custom_cache_manager.dart';

/**
 *
 * 网络请求缓存拦截器
 *
 */
class CacheInterceptor extends InterceptorsWrapper {
  CacheInterceptor();


  @override
  onRequest(RequestOptions options) async{
    FileInfo info = await CustomCacheManager().getFileFromCache(options.uri.toString());
    if(info!=null){
      print("使用缓存"+options.uri.toString());
      String data = await info.file.readAsString();
      Response response = new Response(data:data);
      return response;
    }
    return options;
  }

  @override
  onResponse(Response response) async{
    String body = response.data;
    await CustomCacheManager().putStringFile(response.request.uri.toString(), body);
  }

  @override
  onError(DioError e) {
    print('onError: $e');
  }
}