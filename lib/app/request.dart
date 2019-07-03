import 'dart:io';
import 'package:dio/dio.dart';

import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:tianyue/common/net/custom_cache_interceptor.dart';

class Request {
  static const String baseUrl = 'http://192.168.4.32/';

  static Future<dynamic> get({String action, Map params}) async {
    return Request.mock(action: action, params: params);
  }

  static Future<dynamic> getByHttpClient(String url) async {
    var dio = new Dio();
    dio.options.baseUrl = "https://baidu.com";
    dio.interceptors.add(CacheInterceptor());
    Response<String> response = await dio.get(url);
    String responseBody = response.data;
    return json.decode(responseBody);
//
//    // 实例化
//    HttpClient httpClient = new HttpClient();
//    // 打开Http连接
//    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
//    // 请求头
//    // 等待连接服务器
//    var response = await request.close();
//    // 获取响应内容
//    String responseBody = await response.transform(utf8.decoder).join();
//    //关闭httpClient
//    httpClient.close();
//    return json.decode(responseBody);


  }


  static Future<dynamic> getByHttpHtml(String url) async {
    // 实例化
    HttpClient httpClient = new HttpClient();
    // 打开Http连接
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    // 请求头
    // 等待连接服务器
    var response = await request.close();
    // 获取响应内容
    String responseBody = await response.transform(utf8.decoder).join();
    //关闭httpClient
    httpClient.close();
    return responseBody;
  }

  static Future<dynamic> getByDio({String url, Map params}) async {
    var dio = Request.createDio();
    Response<Map> response =
        await dio.get("/get_home_page/section_data");
    var data = response.data;
    return data;
  }

  static Future<dynamic> post({String action, Map params}) async {
    return Request.mock(action: action, params: params);
  }

  static Future<dynamic> mock({String action, Map params}) async {
    var responseStr = await rootBundle.loadString('mock/$action.json');
    var responseJson = json.decode(responseStr);
    return responseJson['data'];
  }

  static Dio createDio() {

    return Dio();
  }
}
