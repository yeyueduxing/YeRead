import 'package:flutter/material.dart';
import 'package:tianyue/module/novel/widget/novel_rank_page_view.dart';

import 'package:tianyue/public.dart';

/**
 * 小说首页
 */
class NovelHomeScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NovelHomeSceneState();
}

class NovelHomeSceneState extends State<NovelHomeScene>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 1, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
              child: TabBar(
                  tabs: [
                    Tab(text: '女生'),
                    Tab(text: '漫画'),
                    Tab(text: '男生'),
                  ],
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
          children: [
            NovelPageView("54d42d92321052167dfb75e3"),
            NovelPageView("5a6844aafc84c2b8efaa6b6e"),
            NovelPageView("54d42e72d9de23382e6877fb"),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
