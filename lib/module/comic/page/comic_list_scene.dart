import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/app/app_navigator.dart';
import 'package:tianyue/app/ty_color.dart';
import 'package:tianyue/common/widget/base_app_bar_widget.dart';
import 'package:tianyue/common/widget/base_list_widget.dart';
import 'package:tianyue/module/comic/bean/comic_block.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/comic/bean/comic_home_list_entity.dart';
import 'package:tianyue/module/comic/bean/comic_rank_entity.dart';
import 'package:tianyue/module/comic/widget/comic_block_item_view.dart';
import 'package:tianyue/module/comic/widget/comic_rank_item_view.dart';
import 'package:tianyue/module/comic/widget/comic_rank_top_switch.dart';
import 'package:tianyue/utility/app_utils.dart';
import 'package:tianyue/utility/screen.dart';
import 'package:tianyue/utility/styles.dart';

/**
 * 首页更多页面
 */
class ComicMenuListScene extends StatefulWidget {
  /// 详情
  ComicHomeListDataBook bookInfo;
  ComicMenuListScene(this.bookInfo);
  @override
  State<StatefulWidget> createState() => ComicMenuListState();
}

class ComicMenuListState extends State<ComicMenuListScene>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    //初始化界面
  }

  @override
  Widget build(BuildContext context) {
    //创建界面视图
    return BaseAppBarWidget(
      title:  widget.bookInfo.title,
      isDataReady: true,
      body: () {
        return BaseListWidget(
          getListView(),
        );
      },
    );
  }

  /**
   * 获取目录列表页
   */
  List<Widget> getListView() {
    List<ComicRankDataList> blocks = [];
    widget.bookInfo.comicInfo.forEach((item){
      blocks.add(new ComicRankDataList(id:item.comicId,name: item.comicName,comicType: item.comicType,num: item.ordernum));
    });
    var children = blocks
        .map((comicItem) => DmRankItemView(comicItem, TYColor.white))
        .toList();
    return children;
  }
    back() {
    Navigator.pop(context);
  }

}
