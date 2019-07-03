import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/app/app_navigator.dart';
import 'package:tianyue/app/ty_color.dart';
import 'package:tianyue/common/widget/base_app_bar_widget.dart';
import 'package:tianyue/common/widget/base_list_widget.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/comic/widget/comic_rank_top_switch.dart';
import 'package:tianyue/utility/screen.dart';
import 'package:tianyue/utility/styles.dart';

/**
 * 目录页码
 */
class ComicMenuScene extends StatefulWidget {
  /// 详情
  ComicDetailInfoEntity comicDetail;
  ComicMenuScene(this.comicDetail);
  @override
  State<StatefulWidget> createState() => ComicMenuState();
}

class ComicMenuState extends State<ComicMenuScene>
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
    return BaseAppBarWidget(
      title:  widget.comicDetail.comicName,
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
    List<Widget> chapterChildren = [];
    int addIndex = 0;
    widget.comicDetail.comicChapter.forEach((chapterName){
      chapterChildren.add(buildChapterWidget(context, chapterName,addIndex));
      addIndex++;
    });
    return chapterChildren;
  }
  Widget buildChapterWidget(BuildContext context, ComicDetailInfoComicChapter chapterName,int index) {
    return GestureDetector(
        onTap: () {
          AppNavigator.pushComicReader(context,  widget.comicDetail,index);
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
            child: Text(chapterName.chapterName,
                style: TextStyle(
                    fontSize: 17,
                    color: TYColor.gray,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none))));
  }
  back() {
    Navigator.pop(context);
  }
}
