import 'dart:io';
import 'package:dio/dio.dart';

import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tianyue/common/cache/custom_cache_manager.dart';
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
  }


  static Future<dynamic> getByHttpHtml(String url) async {
    var dio = new Dio();
    dio.options.baseUrl = "https://baidu.com";
    dio.interceptors.add(CacheInterceptor());
    Response<String> response = await dio.get(url);
    String responseBody = response.data;
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
