import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:tianyue/app/ty_color.dart';
import 'package:tianyue/common/widget/gsy_tabbar_widget.dart';
import 'package:tianyue/common/widget/ye_title_bar.dart';
import 'package:tianyue/module/comic/page/comic_book_rack_scene.dart';
import 'package:tianyue/module/comic/page/comic_home_scene.dart';
import 'package:tianyue/module/comic/page/comic_rank_scene.dart';
import 'package:tianyue/module/home/widget/home_drawer.dart';
import 'package:tianyue/module/novel/page/novel_collect_scene.dart';
import 'package:tianyue/module/novel/page/novel_find_scene.dart';
import 'package:tianyue/module/video/page/video_catalog_scene.dart';
import 'package:tianyue/module/video/page/video_collect_scene.dart';
import 'package:tianyue/module/video/page/video_home_scene.dart';
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
  void initState() {}

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
      setState(() {
      });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (isUpdate == true) {
      print("为空界面");
      return LoadingIndicator(PageState.Loading
      );
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
      _renderTab(Icons.four_k, "首页"),
      _renderTab(Icons.four_k, "排行"),
      _renderTab(Icons.four_k, "书架"),
    ];
    List<Widget> childrsn = [
      ComicHomeScene(),
      DmRankScene(),
      ComicBookRackScene(),
    ];
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
        iconData: Icons.four_k,
        needRightLocalIcon: true,
        onPressed: () {},
      ),
    );
  }

  Widget getNovelView() {
    List<Widget> tabs = [
      _renderTab(Icons.four_k, "首页"),
      _renderTab(Icons.four_k, "发现"),
      _renderTab(Icons.four_k, "书架"),
    ];
    List<Widget> childrsn = [
      NovelFindScene(),
      NovelFindScene(),
      NovelCollectScene(),
    ];
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
        iconData: Icons.four_k,
        needRightLocalIcon: true,
        onPressed: () {},
      ),
    );
  }

  Widget getVideoView() {
    List<Widget> tabs = [
      _renderTab(Icons.four_k, "首页"),
      _renderTab(Icons.four_k, "排行"),
      _renderTab(Icons.four_k, "书架"),
    ];
    List<Widget> childrsn = [
      VideoHomeScene(),
      VideoCatalogScene(),
      VideoCollectScene(),
    ];
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
        iconData: Icons.four_k,
        needRightLocalIcon: true,
        onPressed: () {},
      ),
    );
  }
}
