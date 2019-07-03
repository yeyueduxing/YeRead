import 'package:flutter/material.dart';
import 'package:tianyue/module/novel/bean/novel_detail_entity.dart';
import 'package:tianyue/module/novel/bean/novel_rank_response_entity.dart';
import 'package:tianyue/module/novel/model/novel_model.dart';
import 'package:tianyue/module/novel/page/novel_rank_top_switch.dart';
import 'package:tianyue/module/novel/page/novice_post_page_scene.dart';
import 'package:tianyue/module/novel/widget/novel_detail_header.dart';
import 'package:tianyue/module/novel/widget/novel_rank_page_view.dart';

import 'package:tianyue/public.dart';
import 'package:tianyue/widget/loading_indicator.dart';

/**
 * 小说评论页面，短评，讨论，书评
 */
class NovelPostScene extends StatefulWidget {
  NovelDetailEntity novelDetail;
  NovelPostScene(this.novelDetail);
  @override
  State<StatefulWidget> createState() => NovelPostSceneState();
}

class NovelPostSceneState extends State<NovelPostScene>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  NovelRankResponseEntity novelRankResponseEntity;
  NovelDetailEntity novelDetail;
  /// 是否请求数据完毕
  bool isDataReady = false;
  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        isDataReady = true;
      });
    } catch (e) {
      Toast.show(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  List<Widget> getTabs() {
    List<Widget> tabs = [];
    tabs.add(Tab(text: '讨论'));
    tabs.add(Tab(text: '书评'));
    return tabs;
  }

  List<Widget> getTabsChildrens() {
    List<Widget> tabs = [];
    tabs.add(NovelPostPageScene(widget.novelDetail.sId,PostType.Post));
    tabs.add(NovelPostPageScene(widget.novelDetail.sId,PostType.Review));
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: Container(
              height: 40,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  //NovelDetailHeader(novelDetail),
                  Expanded(
                      child: TabBar(
                          tabs: getTabs(),
                          controller: _tabController,
                          labelPadding: EdgeInsets.symmetric(horizontal: 25),
                          isScrollable: true,
                          indicatorColor: TYColor.primary,
                          labelColor: TYColor.primary,
                          labelStyle: TextStyle(
                              fontSize: 22,
                              color: TYColor.primary,
                              fontWeight: FontWeight.w500),
                          unselectedLabelColor: Colors.black,
                          unselectedLabelStyle:
                              TextStyle(fontSize: 16, color: Colors.black),
                          indicatorSize: TabBarIndicatorSize.label)),
                ],
              )),
          backgroundColor: TYColor.white,
          elevation: 0,
        ),
        body: TabBarView(
          children: getTabsChildrens(),
          controller: _tabController,
        ),
      ),
    );
  }
}
