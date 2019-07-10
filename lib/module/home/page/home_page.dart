import 'dart:async';
import 'dart:io';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

import 'package:tianyue/app/ty_color.dart';
import 'package:tianyue/common/event/event_bus.dart';
import 'package:tianyue/common/search/search_key_bean.dart';
import 'package:tianyue/common/search/search_page.dart';
import 'package:tianyue/common/widget/gsy_tabbar_widget.dart';
import 'package:tianyue/common/widget/ye_title_bar.dart';
import 'package:tianyue/module/comic/page/comic_book_rack_scene.dart';
import 'package:tianyue/module/comic/page/comic_home_scene.dart';
import 'package:tianyue/module/comic/page/comic_rank_scene.dart';
import 'package:tianyue/module/home/widget/home_drawer.dart';
import 'package:tianyue/module/novel/bean/novel_book.dart';
import 'package:tianyue/module/novel/model/novel_model.dart';
import 'package:tianyue/module/novel/page/novel_book_list_scene.dart';
import 'package:tianyue/module/novel/page/novel_collect_scene.dart';
import 'package:tianyue/module/novel/page/novel_find_scene.dart';
import 'package:tianyue/module/novel/page/novel_rank_scene.dart';
import 'package:tianyue/module/novel/page/novice_book_statists_scene.dart';
import 'package:tianyue/module/novel/utils/novel_search.dart';
import 'package:tianyue/module/novel/widget/novel_lisy_item_view.dart';
import 'package:tianyue/module/video/page/video_catalog_scene.dart';
import 'package:tianyue/module/video/page/video_collect_scene.dart';
import 'package:tianyue/module/video/page/video_home_scene.dart';
import 'package:tianyue/utility/toast.dart';
import 'package:tianyue/widget/loading_indicator.dart';

/**
 * 主页
 * Created by guoshuyu
 * Date: 2018-07-16
 */
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String titleName = "应用";
  bool isChange = false;
  bool isUpdate = false;

  //0漫画，1小说，2动画
  int selectIndex = 1;

  @override
  void initState() {
    final eventBus = new EventBus();
    ApplicationEvent.event = eventBus;
  }

  /// 不退出
  Future<bool> _dialogExitApp(BuildContext context) async {
    ///如果是 android 回到桌面
    return Future.value(true);
  }

  _renderTab(icon, text) {
    return new Tab(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[new Icon(icon, size: 16.0), new Text(text)],
      ),
    );
  }

  Future<void> update(int index) async {
    setState(() {
      isUpdate = true;
    });
    await Future.delayed(Duration(milliseconds: 1000), () {
      isUpdate = false;
      selectIndex = index;
    });
    setState(() {});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (isUpdate == true) {
      print("为空界面");
      return LoadingIndicator(PageState.Loading);
    }

    ///增加返回按键监听
    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: getBodyView(),
    );
  }

  Widget getBodyView() {
    switch (selectIndex) {
      case 0:
        return getComicView();
        break;
      case 1:
        return getNovelView();
        break;
      case 2:
        return getVideoView();
        break;
    }
  }

  Widget getComicView() {
    List<Widget> tabs = [
      _renderTab(Icons.home, "首页"),
      _renderTab(Icons.branding_watermark, "排行"),
      _renderTab(Icons.book, "书架"),
    ];
    List<Widget> childrsn = [
      ComicHomeScene(),
      DmRankScene(),
      ComicBookRackScene(),
    ];
    return getTabBarWidgt(tabs, childrsn);
  }

  Widget getNovelView() {
    List<Widget> tabs = [
      _renderTab(Icons.home, "书单"),
      _renderTab(Icons.branding_watermark, "排行"),
      _renderTab(Icons.category, "分类"),
      _renderTab(Icons.book, "书架"),
    ];
    List<Widget> childrsn = [
      NovelBookListScene(),
      NovelRankScene(),
      NovelBookStatistScene(),
      NovelCollectScene(),
    ];
    return getTabBarWidgt(tabs, childrsn);
  }

  Widget getVideoView() {
    List<Widget> tabs = [
      _renderTab(Icons.home, "首页"),
      _renderTab(Icons.branding_watermark, "排行"),
      _renderTab(Icons.book, "书架"),
    ];
    List<Widget> childrsn = [
      VideoHomeScene(),
      VideoCatalogScene(),
      VideoCollectScene(),
    ];
    return getTabBarWidgt(tabs, childrsn);
  }

  Widget getTabBarWidgt(List<Widget> tabs, List<Widget> childrsn) {
    return new GSYTabBarWidget(
      drawer: new HomeDrawer(
        claaback: (index) {
          update(index);
        },
      ),
      type: GSYTabBarWidget.BOTTOM_TAB,
      tabItems: tabs,
      tabViews: childrsn,
      backgroundColor: Color(0xFF24292E),
      indicatorColor: TYColor.white,
      title: YeTitleBar(
        titleName,
        iconData: Icons.search,
        needRightLocalIcon: true,
        onPressed: () {
          showSearch(
              context: context,
              delegate: searchBarDelegate(NovelSearch.getSuggestlist,
                  NovelSearch.getSearchData, NovelSearch.getSearchWidget));
        },
      ),
    );
  }
}
