import 'package:flutter/material.dart';
import 'package:tianyue/module/novel/widget/novel_find_cell.dart';
import 'package:tianyue/module/novel/widget/novel_rank_page_view.dart';

import 'package:tianyue/public.dart';

/**
 * 小说发现页面
 */
class NovelFindScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NovelFindSceneState();
}

class NovelFindSceneState extends State<NovelFindScene>
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
              child: Text("发现")
          ),
          backgroundColor: TYColor.white,
          elevation: 0,
        ),
        body: getHomeView(context),
      ),
    );
  }

  Widget getHomeView(BuildContext context){
    return Container(
      color: TYColor.white,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton.icon(
                // 文本内容
                  icon: Image.asset("img/discover_icon_classify.png",width: 40,height: 40,),
                  label: Text('分类', semanticsLabel: 'FLAT BUTTON 2'),
                  onPressed: () {
                    AppNavigator.pushNovelBookStatistScene(context);
                  }),
              FlatButton.icon(
                // 文本内容
                  icon: Image.asset("img/discover_icon_booklist.png",width: 40,height: 40,),
                  label: Text('书单', semanticsLabel: 'FLAT BUTTON 2'),
                  onPressed: () {
                    AppNavigator.pushNovelBookListScene(context);
                  }),
              FlatButton.icon(
                // 文本内容
                  icon: Image.asset("img/discover_icon_ranking.png",width: 40,height: 40,),
                  label: Text('排行', semanticsLabel: 'FLAT BUTTON 2'),
                  onPressed: () {
                    AppNavigator.pushNovelRandList(context);
                  }),
            ],
          ),
          SizedBox(height: 20,),
          Column(
            children: <Widget>[
              NovelFindCell(title:"书荒互助",iconName: "img/homefind_shuhuang.png",),
              NovelFindCell(title:"有声小说",iconName: "img/home_find_listen.png",),
              NovelFindCell(title:"随机看书",iconName: "img/home_find_lucky_game.png",),
              NovelFindCell(title:"漫画专区",iconName: "img/home_find_oneyuan.png",),
              NovelFindCell(title:"专属推荐",iconName: "img/home_find_migu.png",),
              NovelFindCell(title:"游戏中心",iconName: "img/home_find_game_center.png",),

            ],
          )
        ],
      ),
    );
  }

  Widget getColumnItem(String title){
    return Row(
      children: <Widget>[
        SizedBox(width: 20,),
        Image.asset('img/ic_more_toread.png'),
        SizedBox(width: 10,),
        Text(title),
        Expanded(child: Container(),),
        Image.asset('img/arrow_right.png'),
        SizedBox(width: 20,),
      ],
    );
  }
}
