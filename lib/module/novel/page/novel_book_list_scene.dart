import 'package:flutter/material.dart';
import 'package:tianyue/module/novel/bean/novel_book_tags_entity.dart';
import 'package:tianyue/module/novel/bean/novel_detail_entity.dart';
import 'package:tianyue/module/novel/bean/novel_rank_response_entity.dart';
import 'package:tianyue/module/novel/model/novel_model.dart';
import 'package:tianyue/module/novel/page/novel_rank_top_switch.dart';
import 'package:tianyue/module/novel/page/novice_book_list_page_scene.dart';
import 'package:tianyue/module/novel/page/novice_post_page_scene.dart';
import 'package:tianyue/module/novel/widget/novel_detail_header.dart';
import 'package:tianyue/module/novel/widget/novel_rank_page_view.dart';

import 'package:tianyue/public.dart';
import 'package:tianyue/widget/loading_indicator.dart';

/**
 * 书单页面
 */
class NovelBookListScene extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => NovelBookListSceneState();
}

class NovelBookListSceneState extends State<NovelBookListScene>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  NovelBookTagsEntity novelBookTagsEntity;

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
      //获取分类数据
      novelBookTagsEntity = await NovelModel.getBooklistTags();
      setState(() {
        isDataReady = true;
        pageState = PageState.Content;
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
    tabs.add(Tab(text: '男频'));
    tabs.add(Tab(text: '女频'));
    return tabs;
  }

  List<Widget> getTabsChildrens() {
    List<Widget> tabs = [];
    tabs.add(NovelBookListPageScene(true,novelBookTagsEntity.male));
    tabs.add(NovelBookListPageScene(false,novelBookTagsEntity.female));
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    if (this.isDataReady != true) {
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
                child: Column(
                  children: <Widget>[
                    //NovelDetailHeader(novelDetail),
                    Text("书单"),
                  ],
                )),
            backgroundColor: TYColor.white,
            elevation: 0,
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                TabBar(
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
                    indicatorSize: TabBarIndicatorSize.label),
                Expanded(
                  child: TabBarView(
                    children: getTabsChildrens(),
                    controller: _tabController,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
