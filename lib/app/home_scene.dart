import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tianyue/common/bottom_page.dart';
import 'package:tianyue/module/comic/page/comic_rank_scene.dart';
import 'package:tianyue/module/novel/page/novel_book_list_scene.dart';
import 'package:tianyue/module/novel/page/novel_find_scene.dart';
import 'package:tianyue/module/novel/page/novel_home_scene.dart';
import 'package:tianyue/module/novel/page/novel_rank_scene.dart';
import 'package:tianyue/module/novel/page/novice_book_list_page_scene.dart';
import 'package:tianyue/module/video/page/video_home_scene.dart';

import 'package:tianyue/public.dart';

import 'package:tianyue/book_home/home_scene.dart' as BookHome;
import 'package:tianyue/module/comic/page/comic_home_scene.dart';
import 'package:tianyue/me/me_scene.dart';
import 'package:tianyue/video/video_scene.dart';
import 'package:tianyue/widget/loading_indicator.dart';
/**
 * 主页
 */
class HomeScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Image> _tabImages = [
      Image.asset('img/tab_comic_home_n.png'),
      Image.asset('img/tab_video_home_n.png'),
      Image.asset('img/tab_book_home_n.png'),
      Image.asset('img/tab_mine_n.png'),
    ];
    List<Image> _tabSelectedImages = [
      Image.asset('img/tab_home_comic_p.png'),
      Image.asset('img/tab_video_home_p.png'),
      Image.asset('img/tab_book_home_p.png'),
      Image.asset('img/tab_mine_p.png'),
    ];
    List<Widget> pages = [
      ComicHomeScene(),
      DmRankScene(),
      NovelFindScene(),
      VideoHomeScene(),
    ];
    return BottomPage(_tabImages,_tabSelectedImages,pages);
  }

}

