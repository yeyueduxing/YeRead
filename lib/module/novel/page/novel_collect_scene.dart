import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tianyue/common/dao/comic_dao.dart';
import 'package:tianyue/common/dao/novel_dao.dart';
import 'package:tianyue/common/dao/video_dao.dart';
import 'package:tianyue/common/event/collect_event.dart';
import 'package:tianyue/common/event/event_bus.dart';
import 'package:tianyue/common/widget/base_app_bar_widget.dart';
import 'package:tianyue/common/widget/base_list_widget.dart';
import 'package:tianyue/module/comic/bean/comic_recommend_entity.dart';
import 'package:tianyue/module/comic/model/comic/comic_model.dart';
import 'package:tianyue/module/comic/model/states/reducers.dart';
import 'package:tianyue/module/comic/widget/comic_banner.dart';
import 'package:tianyue/module/comic/widget/comic_block_item_view.dart';
import 'package:tianyue/module/comic/widget/comic_block_view.dart';
import 'package:tianyue/module/comic/widget/comic_detail_recommend.dart';
import 'package:tianyue/module/comic/widget/comic_recommend_everyday_view.dart';
import 'package:tianyue/module/comic/widget/comic_update_today_view.dart';
import 'package:tianyue/common/utils/shared_preferences.dart';
import 'package:tianyue/module/comic/bean/comic_home_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_book.dart';
import 'package:tianyue/module/novel/widget/novel_block_item_view.dart';
import 'package:tianyue/module/video/bean/video.dart';
import 'package:tianyue/module/video/widget/voide_block_item_view.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/utility/app_utils.dart';
import 'package:tianyue/widget/loading_indicator.dart';

/**
 * 小说书架
 */
class NovelCollectScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NovelCollectState();
}

class NovelCollectState extends State<NovelCollectScene>
    with AutomaticKeepAliveClientMixin {
  List<NovelBook> comicBlocks = [];

  /// 是否请求数据完毕
  bool isDataReady = false;
  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();

    fetchData();
    if(ApplicationEvent.event!=null){
      ApplicationEvent.event.on<CollectEvent>().listen((onData) {
        if(mounted==true){
          print("接收到通知2");
          fetchData();
        }
      });
    }


  }

  @override
  void dispose() {
    super.dispose();
  }

  /**
   * 通过异步获取数据，然后动态更新
   */
  Future<void> fetchData() async {
    try {
      //获取关联漫画
      comicBlocks = await NovelDao.getAllCollect();
      setState(() {
        isDataReady = true;
      });
    } catch (e) {
      print(e.toString());
      Toast.show(e.toString());
    }
  }

  /// 失败重试
  _retry() {
    pageState = PageState.Loading;
    setState(() {});
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //必须添加
    return BaseAppBarWidget(
      title: "书架",
      isDataReady: isDataReady,
      body: () {
        return BaseListWidget(
          getListView(),
        );
      },
    );
  }

  List<Widget> getListView() {
    List<Widget> childrens = [];
    var addChildrens = comicBlocks
        .map((comicItem) => NovelBlockItemView(comicItem, TYColor.white))
        .toList();
    childrens.add(Container(
      padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
      child: Wrap(spacing: 15, runSpacing: 15, children: addChildrens),
    ));
    return childrens;
  }

  @override
  bool get wantKeepAlive => true;
}
