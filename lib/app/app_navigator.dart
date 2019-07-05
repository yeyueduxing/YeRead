import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/module/comic/bean/comic_home_list_entity.dart';
import 'package:tianyue/module/comic/page/comic_detail_scene.dart';
import 'package:tianyue/module/comic/page/comic_list_scene.dart';
import 'package:tianyue/module/comic/page/comic_menu_scene.dart';
import 'package:tianyue/module/comic/page/comic_reader_scene.dart';
import 'package:tianyue/me/login_scene.dart';
import 'package:tianyue/me/web_scene.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/novel/bean/novel_book_statistics_entity.dart';
import 'package:tianyue/module/novel/bean/novel_detail_entity.dart';
import 'package:tianyue/module/novel/bean/novel_menu_list_entity.dart';
import 'package:tianyue/module/novel/page/novel_book_list_scene.dart';
import 'package:tianyue/module/novel/page/novel_detail_scene.dart';
import 'package:tianyue/module/novel/page/novel_post_scene.dart';
import 'package:tianyue/module/novel/page/novel_rank_scene.dart';
import 'package:tianyue/module/novel/page/novice_book_category_info_scene.dart';
import 'package:tianyue/module/novel/page/novice_book_statists_scene.dart';
import 'package:tianyue/module/novel/page/novice_booklist_detail_scene.dart';
import 'package:tianyue/module/novel/page/novice_menu_scene.dart';
import 'package:tianyue/module/video/bean/video.dart';
import 'package:tianyue/module/video/page/video_detail_scene.dart';
import 'package:tianyue/module/video/page/video_play_scene.dart';
import 'package:tianyue/module/video/page/video_recommend_scene.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/reader/reader_scene.dart';
import 'package:tianyue/video/video_detail_scene.dart';

class AppNavigator {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }


  static pushComicDetail(BuildContext context, String url) {
    AppNavigator.push(context, ComicDetailScene(url));
  }

  static pushComicMenu(BuildContext context, ComicDetailInfoEntity info) {
    AppNavigator.push(context, ComicMenuScene(info));
  }
  static pushComicReader(BuildContext context, ComicDetailInfoEntity info,int index) {
    AppNavigator.push(context, ComicReaderScene(info,select_index: index,));
  }
  static pushComicMenuList(BuildContext context, ComicHomeListDataBook info) {
    AppNavigator.push(context, ComicMenuListScene(info));
  }


  static pushNovelRandList(BuildContext context) {
    AppNavigator.push(context, NovelRankScene());
  }
  static pushNovelBookListScene(BuildContext context) {
    AppNavigator.push(context, NovelBookListScene());
  }
  static pushNovelBookStatistScene(BuildContext context) {
    AppNavigator.push(context, NovelBookStatistScene());
  }
  static pushNovelDetail(BuildContext context, String cId) {
    AppNavigator.push(context, NovelDetailScene(cId));
  }
  static pushNovelMenu(BuildContext context, String cId) {
    AppNavigator.push(context, NovelMenuScene(cId));
  }
  static pushNovelPost(BuildContext context, NovelDetailEntity detail) {
    AppNavigator.push(context, NovelPostScene(detail));
  }
  static pushNovelBookListDetail(BuildContext context, String sId) {
    AppNavigator.push(context, NovelBooklistDetailScene(sId));
  }
  static pushNovelCategoryInfo(BuildContext context, NovelBookStatistics info,String gender) {
    AppNavigator.push(context, NovelBookCategoryInfoScene(info,gender));
  }

  static pushVideoDetail(BuildContext context, String url) {
    AppNavigator.push(context, VideoDetailScene());
  }

  //视频

  static pushVideoHomeList(BuildContext context, ViewoReType type) {
    AppNavigator.push(context, VideoRecommendScene(type));
  }
  static pushVideoDetailInfo(BuildContext context, Video video) {
    AppNavigator.push(context, VideoDetailInfoScene(video));
  }
  static pushVideoPlay(BuildContext context, String path) {
    AppNavigator.push(context, VideoPlayScene(path));
  }

  static pushLogin(BuildContext context) {
    AppNavigator.push(context, LoginScene());
  }

  static pushWeb(BuildContext context, String url, String title) {
    AppNavigator.push(context, WebScene(url: url, title: title));
  }

  static pushReader(BuildContext context, NovelMenuListEntity articleId) {
    AppNavigator.push(context, ReaderScene(menuList: articleId));
  }
}
