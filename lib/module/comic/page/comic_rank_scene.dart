import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/app/ty_color.dart';
import 'package:tianyue/module/comic/widget/comic_rank_top_switch.dart';

/**
 * 动漫排行榜
 */
class DmRankScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DmRankState();
}

class DmRankState extends State<DmRankScene>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _selectTop=0;
  @override
  void initState() {
    super.initState();
    //初始化界面
  }

  @override
  Widget build(BuildContext context) {
    //创建界面视图
    return Scaffold(
      backgroundColor: TYColor.white,
      body: Stack(
        children: <Widget>[
          DmRankTopSwitchView(_selectTop)
        ],
      ),
    );
  }
}
