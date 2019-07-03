import 'package:flutter/material.dart';
import 'package:tianyue/module/novel/bean/novel_rank_response_entity.dart';
import 'package:tianyue/module/novel/model/novel_model.dart';
import 'package:tianyue/module/novel/page/novel_rank_top_switch.dart';
import 'package:tianyue/module/novel/widget/novel_rank_page_view.dart';

import 'package:tianyue/public.dart';
import 'package:tianyue/widget/loading_indicator.dart';

/**
 * 小说排行榜
 */
class NovelRankScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NovelRankSceneState();
}

class NovelRankSceneState extends State<NovelRankScene>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  NovelRankResponseEntity novelRankResponseEntity;
  /// 是否请求数据完毕
  bool isDataReady = false;
  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 1, length: 4);
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      novelRankResponseEntity = await NovelModel.getAllRank();
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

  List<Widget> getTabs(){
    List<Widget> tabs = [];
    if(novelRankResponseEntity!=null){
      if(novelRankResponseEntity.male!=null){
        tabs.add(Tab(text: '男生'));
      }
      if(novelRankResponseEntity.female!=null){
        tabs.add(Tab(text: '女生'));
      }
      if(novelRankResponseEntity.epub!=null){
        tabs.add(Tab(text: '出版'));
      }
      if(novelRankResponseEntity.picture!=null){
        tabs.add(Tab(text: '漫画'));
      }
    }
    return tabs;
  }
  List<Widget> getTabsChildrens(){
    List<Widget> tabs = [];
    if(novelRankResponseEntity!=null){
      if(novelRankResponseEntity.male!=null){
        tabs.add(NovelRankSwitchView(novelRankResponseEntity.male));
      }
      if(novelRankResponseEntity.female!=null){
        tabs.add(NovelRankSwitchView(novelRankResponseEntity.female));
      }
      if(novelRankResponseEntity.epub!=null){
        tabs.add(NovelRankSwitchView(novelRankResponseEntity.epub));
      }
      if(novelRankResponseEntity.picture!=null){
        tabs.add(NovelRankSwitchView(novelRankResponseEntity.picture));
      }
    }
    return tabs;
  }
  @override
  Widget build(BuildContext context) {
    if(isDataReady==null || isDataReady==false){
      return LoadingIndicator(
        pageState,
      );
    }
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: Container(
              height: 40,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 15),
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
