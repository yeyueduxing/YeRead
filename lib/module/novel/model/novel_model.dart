import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tianyue/app/request.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/comic/bean/comic_home_list_entity.dart';
import 'package:tianyue/module/comic/bean/comic_rank_entity.dart';
import 'package:tianyue/module/comic/bean/comic_recommend_entity.dart';
import 'package:tianyue/module/comic/model/states/reducers.dart';
import 'package:tianyue/module/novel/bean/novel_book.dart';
import 'package:tianyue/module/novel/bean/novel_book_statistics_entity.dart';
import 'package:tianyue/module/novel/bean/novel_book_tags_entity.dart';
import 'package:tianyue/module/novel/bean/novel_booklist.dart';
import 'package:tianyue/module/novel/bean/novel_booklist_detail_entity.dart';
import 'package:tianyue/module/novel/bean/novel_booklist_entity.dart';
import 'package:tianyue/module/novel/bean/novel_cate_info_entity.dart';
import 'package:tianyue/module/novel/bean/novel_chapter_detail_entity.dart';
import 'package:tianyue/module/novel/bean/novel_comment_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_detail_entity.dart';
import 'package:tianyue/module/novel/bean/novel_menu_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_post.dart';
import 'package:tianyue/module/novel/bean/novel_post_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_rank_entity.dart';
import 'package:tianyue/module/novel/bean/novel_rank_response_entity.dart';
import 'package:tianyue/module/novel/bean/novel_search_hotword_entity.dart';

/**
 *
 * 小说数据处理
 */
class NovelModel{

  /**
   * 获取漫画首页数据
   */
  static Future<List<NovelBook>> getRank(String rankParam) async {

    String url = "http://api.zhuishushenqi.com/ranking/"+rankParam;
    print(url);
    var responseJson = await Request.getByHttpClient(url);
    NovelRankEntity enity = NovelRankEntity.fromJson(responseJson);
    List<NovelBook> books = [];
    if(enity!=null){
      books = enity.ranking.books;
    }
    return books;
  }

  /**
   * 获取所有的排行榜
   */
  static Future<NovelRankResponseEntity> getAllRank() async {

    String url = "http://api.zhuishushenqi.com/ranking/gender";
    var responseJson = await Request.getByHttpClient(url);
    NovelRankResponseEntity enity = NovelRankResponseEntity.fromJson(responseJson);

    return enity;
  }

  /**
   * 获取详情
   */
  static Future<NovelDetailEntity> getNovelDetail(String cid) async {
    String url = "http://api.zhuishushenqi.com/book/"+cid;
    print(url);
    var responseJson = await Request.getByHttpClient(url);
    NovelDetailEntity enity = NovelDetailEntity.fromJson(responseJson);
    return enity;
  }

  /**
   * 获取书籍讨论
   */
  static Future<NovelPostListEntity> getNovelpost(String cid,int start,int limit) async {
    String url = "http://api.zhuishushenqi.com/post/by-book?book=${cid}&sort=updated&type=normal&start=${start}&limit=${limit}";
    print(url);
    var responseJson = await Request.getByHttpClient(url);
    NovelPostListEntity enity = NovelPostListEntity.fromJson(responseJson);
    return enity;
  }


  /**
   * 获取书籍书评
   */
  static Future<NovelCommentListEntity> getNovelComment(String cid,int start,int limit) async {
    String url = "http://api.zhuishushenqi.com/post/review/by-book?book=${cid}&sort=updated&type=normal&start=${start}&limit=${limit}";
    print(url);
    var responseJson = await Request.getByHttpClient(url);
    NovelCommentListEntity enity = NovelCommentListEntity.fromJson(responseJson);
    return enity;
  }

  /**
   * 获取书籍书评
   */
  static Future<NovelMenuListEntity> getNovelChapter(String cid) async {
    String url = "http://api.zhuishushenqi.com/mix-atoc/${cid}?view=chapters";
    print(url);
    var responseJson = await Request.getByHttpClient(url);
    NovelMenuListEntity enity = NovelMenuListEntity.fromJson(responseJson);
    return enity;
  }

  /**
   * 获取书籍书评
   */
  static Future<List<NovelBooklist>> getBookList(bool isMale,String sort,String tag,int start,int limit) async {
    String gender = "female";
    if(isMale==true){
      gender = "male";
    }
    if(tag==null || tag==""){
      tag = "";
    }else{
      tag = "&tag=${tag}";
    }
    String url = "http://api.zhuishushenqi.com/book-list?duration=${sort}&start=${start}&limit=${limit}${tag}&gender=${gender}";
    print(url);
    var responseJson = await Request.getByHttpClient(url);
    NovelBooklistEntity enity = NovelBooklistEntity.fromJson(responseJson);
    List<NovelBooklist> list = [];
    if(enity!=null){
      list = enity.bookLists;
    }
    return list;
  }

  /**
   * 获取书单分类详情
   */
  static Future<NovelBookTagsEntity> getBooklistTags() async {
    String url = "http://api.zhuishushenqi.com/cats/lv2";
    print(url);
    var responseJson = await Request.getByHttpClient(url);
    NovelBookTagsEntity enity = NovelBookTagsEntity.fromJson(responseJson);
    return enity;
  }

  /**
   * 带书籍数量的父分类
   */
  static Future<NovelBookStatisticsEntity> getBookStatistics() async {
    String url = "http://api.zhuishushenqi.com/cats/lv2/statistics";
    print(url);
    var responseJson = await Request.getByHttpClient(url);
    NovelBookStatisticsEntity enity = NovelBookStatisticsEntity.fromJson(responseJson);
    return enity;
  }

  /**
   *获取分类详情
   */
  static Future<NovelCateInfoEntity> getBookCategoriesInfo(String gender,String major,String  minor,int start,int limit) async {
    String url = "http://api.zhuishushenqi.com/book/by-categories?gender=${gender}&type=hot&major=${major}&minor=${minor}&start=${start}&limit=${limit}";
    print(url);
    var responseJson = await Request.getByHttpClient(url);
    NovelCateInfoEntity enity = NovelCateInfoEntity.fromJson(responseJson);
    print("不为空");
    return enity;
  }

  /**
   *获取分类详情
   */
  static Future<List<NovelBook>> getBookSearchList(String query,int start,int limit) async {
    String url = "http://api.zhuishushenqi.com/book/fuzzy-search?query=${query}&start=${start}&limit=${limit}";
    print(url);
    List<NovelBook> list = [];
    var responseJson = await Request.getByHttpClient(url);
    NovelCateInfoEntity enity = NovelCateInfoEntity.fromJson(responseJson);
    if(enity!=null){
      list = enity.books;
    }
    return list;
  }
  /**
   *获取搜索推荐
   */
  static Future<List<NovelSearchHotwordSearchhotword>> getBookSearchHotwords() async {
    String url = "http://api.zhuishushenqi.com/book/search-hotwords";
    print(url);
    List<NovelSearchHotwordSearchhotword> list = [];
    var responseJson = await Request.getByHttpClient(url);
    NovelSearchHotwordEntity enity = NovelSearchHotwordEntity.fromJson(responseJson);
    if(enity!=null){
      list = enity.searchHotWords;
    }
    return list;
  }

  static Future<List<NovelBook>> getBookRecommend(String novelId) async {
    String url = "http://api.zhuishushenqi.com/book/${novelId}/recommend";
    print(url);
    var responseJson = await Request.getByHttpClient(url);
    NovelCateInfoEntity enity = NovelCateInfoEntity.fromJson(responseJson);
    List<NovelBook> list = [];
    if(enity!=null){
      list = enity.books;
    }
    return list;
  }

  /**
   * 获取书单详情
   */
  static Future<NovelBooklistDetailEntity> getBooklistDetail(String sId) async {
    String url = "http://novel.juhe.im/booklists/"+sId;
    print(url);
    Dio dio = new Dio(); // 使用默认配置
    Map<String,dynamic> headers = new Map();
    headers['Accept-Language'] = "zh-CN";
    // 配置dio实例
    dio.options.baseUrl=url;
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout=3000;
    dio.options.headers = headers;

    var response = await dio.request(url);

    var responseJson = json.decode(response.data);
    NovelBooklistDetailEntity enity = NovelBooklistDetailEntity.fromJson(responseJson);
    return enity;
  }


  /**
   * 获取章节详情
   */
  static Future<NovelChapterInfo> getBookDetailInfo(String link) async {
    String url = "http://chapter2.zhuishushenqi.com/chapter/"+Uri.encodeComponent(link);
    print(url);
    var responseJson = await Request.getByHttpClient(url);
    NovelChapterDetail enity = NovelChapterDetail.fromJson(responseJson);
    NovelChapterInfo info = new NovelChapterInfo();
    info = enity.chapter;
    return info;
  }
}