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
import 'package:tianyue/module/novel/bean/novel_comment_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_detail_entity.dart';
import 'package:tianyue/module/novel/bean/novel_menu_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_post.dart';
import 'package:tianyue/module/novel/bean/novel_post_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_rank_entity.dart';
import 'package:tianyue/module/novel/bean/novel_rank_response_entity.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as Html;
import 'package:tianyue/module/video/bean/video.dart';
import 'package:tianyue/module/video/bean/video_catalog.dart';
import 'package:tianyue/module/video/bean/video_catalog_page.dart';
import 'package:tianyue/module/video/bean/video_detail_chapter_entity.dart';
import 'package:tianyue/module/video/bean/video_detail_comment.dart';
import 'package:tianyue/module/video/bean/video_detail_page.dart';
import 'package:tianyue/module/video/bean/video_home_list.dart';
import 'package:tianyue/module/video/bean/video_info_entity.dart';

class VideoModel {
  /**
   * 获取动漫网站首页
   */
  static Future<VideoHomeListEntity> getHome() async {
    String url = "https://donghua.agefans.com/";
    var responseBody = await Request.getByHttpHtml(url);
    List<Video> recommends = getRecommend(responseBody);
    List<Video> updates = getUpdate(responseBody);
    VideoHomeListEntity entity =
        new VideoHomeListEntity(recommends: recommends, updates: updates);
    return entity;
  }

  static List<Video> getRecommend(String responseBody) {
    RegExp reg = new RegExp(r'/recommend">每日推荐</[\s\S]*?</ul');
    Iterable<Match> matches = reg.allMatches(responseBody);
    List<Video> list = [];
    for (Match m in matches) {
      //groupCount返回正则表达式的分组数
      //由于group(0)保存了匹配信息，因此字符串的总长度为：分组数+1
      String match = m.group(0);
      //在此匹配
      list = getItems(match);
    }
    return list;
  }

  static List<Video> getUpdate(String responseBody) {
    RegExp reg = new RegExp(r'update">最近更新[\s\S]*?</ul');
    Iterable<Match> matches = reg.allMatches(responseBody);
    List<Video> list = [];
    for (Match m in matches) {
      //groupCount返回正则表达式的分组数
      //由于group(0)保存了匹配信息，因此字符串的总长度为：分组数+1
      String match = m.group(0);
      //在此匹配
      list = getItems(match);
    }
    return list;
  }

  static List<Video> getItems(String match) {
    RegExp reg = new RegExp(
        r'<li class="anime[\s\S]*?href="(.*?)"[\s\S]*?src="(.*?)"[\s\S]*?alt="(.*?)"[\s\S]*?title="(.*?)"[\s\S]*?/li>');
    Iterable<Match> matches = reg.allMatches(match);
    List<Video> list = [];
    for (Match m in matches) {
      //groupCount返回正则表达式的分组数
      //由于group(0)保存了匹配信息，因此字符串的总长度为：分组数+1
      String title = "";
      String cover = "";
      String sid = "";
      String desc = "";
      for (int i = 0; i < m.groupCount + 1; i++) {
        String match = m.group(i);
        switch (i) {
          case 1:
            sid = match.replaceFirst("/detail/", "");
            break;
          case 2:
            if (match == null || match == "") {
              cover = "";
            } else {
              cover = "http:" + match;
            }
            break;
          case 3:
            title = match;
            break;
          case 4:
            desc = match;
            break;
        }
      }
      if (cover != "") {
        Video video =
            new Video(title: title, cover: cover, sId: sid, shortIntro: desc);
        list.add(video);
      }
    }
    return list;
  }

  static Future<List<Video>> getHomeList(String type, int page) async {
    String url = "https://donghua.agefans.com/${type}?page=${page}";
    var responseBody = await Request.getByHttpHtml(url);
    List<Video> list = [];
    list = getItems(responseBody);
    return list;
  }

  static Future<VideoDetailPage> getVideoDetail(String vid) async {
    String url = "https://donghua.agefans.com/play/" + vid;
    var responseBody = await Request.getByHttpHtml(url);
    VideoInfoEntity info = getVideoDetailInfo(responseBody);
    print(url);
    VideoDetailPage detailPage = new VideoDetailPage();
    List<Video> recommends = [];
    recommends = getDetailRecommend(responseBody);
    List<VideoDetailChapterEntity> chapters =
        getVideoDetailChapter(responseBody);
    List<VideoDetailComment> comments =  getDetailComment(responseBody);
    detailPage.info = info;
    detailPage.chapters = chapters;
    detailPage.recommends = recommends;
    detailPage.comments = comments;
    return detailPage;
  }

  static VideoInfoEntity getVideoDetailInfo(String responseBody) {
    RegExp regAll = new RegExp(r'id="play_imform"[\s\S]*?</ul');
    Iterable<Match> matchesAll = regAll.allMatches(responseBody);
    String infoMatch = "";
    for (Match m in matchesAll) {
      //groupCount返回正则表达式的分组数
      //由于group(0)保存了匹配信息，因此字符串的总长度为：分组数+1
      infoMatch = m.group(0);
    }
    RegExp regDesc = new RegExp(r'play_desc"><p>([\s\S]*?)</p>');
    Iterable<Match> matchesDesc = regDesc.allMatches(responseBody);
    String describe = "";
    for (Match m in matchesDesc) {
      //groupCount返回正则表达式的分组数
      //由于group(0)保存了匹配信息，因此字符串的总长度为：分组数+1
      describe = m.group(1);
      describe = describe.replaceAll("<br />", "\n");
    }
    RegExp regCover = new RegExp(r'play_poster_img".*?src="([\s\S]*?)"');
    Iterable<Match> matchesCover = regCover.allMatches(responseBody);
    String cover = "";
    for (Match m in matchesCover) {
      //groupCount返回正则表达式的分组数
      //由于group(0)保存了匹配信息，因此字符串的总长度为：分组数+1
      cover = "http:" + m.group(1);
    }
    RegExp reg = new RegExp(r'<span class="play_imform_val">(.*?)</span>');
    Iterable<Match> matches = reg.allMatches(infoMatch);
    VideoInfoEntity info = null;
    String time; //播放时间
    String originalTitle; //原版名称
    String title; //名称
    String region; //地区
    String writer; //原作
    String company; //制作公司
    String status; //状态
    String tags; //标签
    String type; //动画种类
    int index = 0;
    for (Match m in matches) {
      //groupCount返回正则表达式的分组数
      //由于group(0)保存了匹配信息，因此字符串的总长度为：分组数+1
      String match = m.group(1);
      switch (index) {
        case 0:
          region = match;
          break;
        case 1:
          type = match;
          break;
        case 2:
          originalTitle = match;
          break;
        case 3:
          title = match;
          break;
        case 4:
          writer = match;
          break;
        case 5:
          company = match;
          break;
        case 6:
          time = match;
          break;
        case 7:
          status = match;
          break;
        case 8:
          tags = match;
          break;
        case 9:
          //title = match;
          break;
        case 10:
          //title = match;
          break;
      }
      index++;
    }
    info = new VideoInfoEntity(
        time: time,
        tags: tags,
        title: title,
        type: type,
        originalTitle: originalTitle,
        company: company,
        writer: writer,
        status: status,
        region: region,
        cover: cover,
        describe: describe);
    return info;
  }

  static List<VideoDetailChapterEntity> getVideoDetailChapter(
      String responseBody) {
    List<VideoDetailChapterEntity> comicChapter =
    new List<VideoDetailChapterEntity>();
    try{
      RegExp regCover = new RegExp(r'var g_playss = ([\s\S]*?);');
      Iterable<Match> matchesCover = regCover.allMatches(responseBody);
      String body = "";
      for (Match m in matchesCover) {
        //groupCount返回正则表达式的分组数
        //由于group(0)保存了匹配信息，因此字符串的总长度为：分组数+1
        body = m.group(1);
      }
      var resonJson = json.decode(body);
      (resonJson as List).forEach((v) {
        comicChapter.add(new VideoDetailChapterEntity.fromJson(v));
      });
    }catch(e){
      print(e.toString());
    }

    return comicChapter;
  }

  static List<Video> getDetailRecommend(String body) {
    RegExp regCover = new RegExp(r'ul_li_a8([\s\S]*?)</ul>');
    Iterable<Match> matchesCover = regCover.allMatches(body);
    String recomBody = "";
    for (Match m in matchesCover) {
      //groupCount返回正则表达式的分组数
      //由于group(0)保存了匹配信息，因此字符串的总长度为：分组数+1
      recomBody = m.group(0);
    }
    RegExp reg = new RegExp(
        r'<li class="anime[\s\S]*?href="(.*?)"[\s\S]*?data-src="(.*?)"[\s\S]*?anime_icon1_name">(.*?)</div');
    Iterable<Match> matches = reg.allMatches(recomBody);
    List<Video> list = [];
    print(matches);
    for (Match m in matches) {
      //groupCount返回正则表达式的分组数
      //由于group(0)保存了匹配信息，因此字符串的总长度为：分组数+1
      String title = "";
      String cover = "";
      String sid = "";
      for (int i = 0; i < m.groupCount + 1; i++) {
        String match = m.group(i);
        switch (i) {
          case 1:
            sid = match.replaceFirst("/detail/", "");
            break;
          case 2:
            if (match == null || match == "") {
              cover = "";
            } else {
              cover = "http:" + match;
            }
            break;
          case 3:
            title = match;
            break;
        }
      }
      Video video = new Video(
        title: title,
        cover: cover,
        sId: sid,
      );
      list.add(video);
    }
    return list;
  }

  /**
   * 获取评论
   */
  static List<VideoDetailComment> getDetailComment(String body) {
    RegExp regCover = new RegExp(r'comment_list([\s\S]*?)current_comment_page');
    Iterable<Match> matchesCover = regCover.allMatches(body);
    String recomBody = "";
    for (Match m in matchesCover) {
      //groupCount返回正则表达式的分组数
      //由于group(0)保存了匹配信息，因此字符串的总长度为：分组数+1
      recomBody = m.group(0);
    }
    RegExp reg = new RegExp(
        r'<li class="comment[\s\S]*?commentcell_user">(.*?)<[\s\S]*?commentcell_content"> <div>(.*?)<[\s\S]*?ime asciifont">(.*?)<');
    Iterable<Match> matches = reg.allMatches(recomBody);
    List<VideoDetailComment> list = [];
    print(matches);
    for (Match m in matches) {
      //groupCount返回正则表达式的分组数
      //由于group(0)保存了匹配信息，因此字符串的总长度为：分组数+1
      String title = "";
      String content = "";
      String time = "";
      for (int i = 0; i < m.groupCount + 1; i++) {
        String match = m.group(i);
        switch (i) {
          case 1:
            title = match;
            break;
          case 2:
            content = match;
            break;
          case 3:
            time = match;
            break;
        }
      }
      VideoDetailComment video = new VideoDetailComment(title,content,time);
      list.add(video);
    }
    return list;
  }


  static Future<VideoCatalogPage> getCatalogList(String type, int page) async {
    String url = "https://donghua.agefans.com/catalog/${type}-${page}";
    var responseBody = await Request.getByHttpHtml(url);
    print(url);
    VideoCatalogPage pageData = new VideoCatalogPage();
    List<VideoCatalog> list = [];
    list = getCatalogListTypes(responseBody);
    List<VideoInfoEntity> items = getVideoCataLogItems(responseBody);
    pageData.catalogs = list;
    pageData.items = items;
    return pageData;
  }

  static List<VideoCatalog> getCatalogListTypes(String body) {
    RegExp regCover = new RegExp(r'class="catalog_type">([\s\S]*?)<[\s\S]*?</tr>');
    Iterable<Match> matchesCover = regCover.allMatches(body);
    List<VideoCatalog> list = [];
    for (Match m in matchesCover) {
      //groupCount返回正则表达式的分组数
      //由于group(0)保存了匹配信息，因此字符串的总长度为：分组数+1
      String title = m.group(1);
      String logbody = m.group(0);
      VideoCatalog log = new VideoCatalog();
      log.title = title;
      log.items = getCatalogListItems(logbody);
      list.add(log);
    }
    return list;
  }
  static List<VideoCatalogItem> getCatalogListItems(String body)  {
    RegExp reg = new RegExp(
        r'href="(.*?)" >([\s\S]*?)</a');
    Iterable<Match> matches = reg.allMatches(body);
    List<VideoCatalogItem> list = [];
    for (Match m in matches) {
      //groupCount返回正则表达式的分组数
      //由于group(0)保存了匹配信息，因此字符串的总长度为：分组数+1
      String title = "";
      String params = "";
      for (int i = 0; i < m.groupCount + 1; i++) {
        String match = m.group(i);
        switch (i) {
          case 2:
            title = match.replaceAll(" ", "");
            title = title.replaceAll("\s", "");
            title = title.replaceAll("\S", "");
            break;
          case 1:
            params = match.replaceAll("-1", "");
            break;
        }
      }
      VideoCatalogItem video = new VideoCatalogItem(title,params);
      list.add(video);
    }
    return list;
  }

  static List<VideoInfoEntity> getVideoCataLogItems(String responseBody) {
    RegExp regAll = new RegExp(r'class="cell blockdiff[\s\S]*?href="/detail/(.*?)"[\s\S]*?src="(.*?)"[\s\S]*?alt="(.*?)"[\s\S]*?class="newname">(.*?)<[\s\S]*?cell_imform_name">(.*?)<[\s\S]*?cell_imform_desc">([\s\S]*?)</div>');
    Iterable<Match> matchesAll = regAll.allMatches(responseBody);
    String infoMatch = "";
    print(matchesAll);
    List<VideoInfoEntity> list = [];
    for (Match m in matchesAll) {
      //groupCount返回正则表达式的分组数
      //由于group(0)保存了匹配信息，因此字符串的总长度为：分组数+1
      String sid = m.group(1);
      String name = m.group(3);
      String desc = m.group(6);
      String cover = "http:"+m.group(2);
      String itemBody = m.group(0);
      VideoInfoEntity info = getVideoCataLogItemsInfo(itemBody);
      info.describe = desc;
      info.sid = sid;
      info.cover = cover;
      info.title = name;
      list.add(info);
    }
    return list;
  }
  static VideoInfoEntity getVideoCataLogItemsInfo(String responseBody) {
    RegExp regAll = new RegExp(r'"cell_imform_value"> (.*?) </span');
    Iterable<Match> matchesAll = regAll.allMatches(responseBody);
    print(matchesAll);
    String time; //播放时间
    String originalTitle; //原版名称
    String title; //名称
    String writer; //原作
    String company; //制作公司
    String status; //状态
    String tags; //标签
    String type; //动画种类
    int index = 0;
    for (Match m in matchesAll) {
      switch(index){
        case 0:
          type = m.group(1);
          break;
        case 1:
          originalTitle = m.group(1);
          break;
        case 2:
          title = m.group(1);
          break;
        case 3:
          time = m.group(1);
          break;
        case 4:
          status = m.group(1);
          break;
        case 5:
          writer = m.group(1);
          break;
        case 6:
          tags = m.group(1);
          break;
        case 7:
          company = m.group(1);
          break;
      }
      index++;
    }
    VideoInfoEntity info = new VideoInfoEntity(
        time: time,
        tags: tags,
        title: title,
        type: type,
        originalTitle: originalTitle,
        company: company,
        writer: writer,
        status: status,);
    return info;
  }
}
