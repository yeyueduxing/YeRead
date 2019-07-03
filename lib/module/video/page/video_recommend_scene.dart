import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/app/app_navigator.dart';
import 'package:tianyue/app/ty_color.dart';
import 'package:tianyue/common/widget/base_app_bar_widget.dart';
import 'package:tianyue/common/widget/base_list_widget.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/comic/widget/comic_rank_top_switch.dart';
import 'package:tianyue/module/novel/bean/novel_book_statistics_entity.dart';
import 'package:tianyue/module/novel/bean/novel_cate_info_entity.dart';
import 'package:tianyue/module/novel/bean/novel_comment_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_menu.dart';
import 'package:tianyue/module/novel/bean/novel_menu_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_post_list_entity.dart';
import 'package:tianyue/module/novel/model/novel_model.dart';
import 'package:tianyue/module/novel/widget/novel_block_item_view.dart';
import 'package:tianyue/module/novel/widget/novel_comment_cell.dart';
import 'package:tianyue/module/novel/widget/novel_lisy_item_view.dart';
import 'package:tianyue/module/novel/widget/novel_post_cell.dart';
import 'package:tianyue/module/video/bean/video.dart';
import 'package:tianyue/module/video/model/video_model.dart';
import 'package:tianyue/module/video/widget/voide_block_item_view.dart';
import 'package:tianyue/utility/app_utils.dart';
import 'package:tianyue/utility/screen.dart';
import 'package:tianyue/utility/styles.dart';
import 'package:tianyue/widget/loading_indicator.dart';
import 'package:tianyue/common/widget/novel_cover_image.dart';

/**
 * 推荐视频，每日更新
 */
enum ViewoReType { Recommend, Update }

class VideoRecommendScene extends StatefulWidget {
  ViewoReType viewoReType;

  VideoRecommendScene(this.viewoReType);

  @override
  State<StatefulWidget> createState() => NovelBookCategoryInfoState();
}

class NovelBookCategoryInfoState extends State<VideoRecommendScene>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<Video> recommends;
  int page = 1;
  bool isDataReady = false;

  @override
  void initState() {
    super.initState();
    //初始化界面
    fetchData();
  }

  fetchData() async {
    try {
      String type = "update";
      if (widget.viewoReType == ViewoReType.Recommend) {
        type = "recommend";
      }
      if(recommends==null){
        recommends = [];
      }
      if(page==1){
        recommends.clear();
      }
      List<Video> list = await VideoModel.getHomeList(type, page);
      print(list.toString());
      if(list!=null){
        list.forEach((item){
          recommends.add(item);
        });
      }
      setState(() {
        isDataReady = true;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return BaseAppBarWidget(
      title: "每日推荐",
      isDataReady: isDataReady,
      body: () {
        return BaseListWidget(
          getListView(),
          onRefresh: () {
            page = 1;
            fetchData();
          },
          onMore: () {
            page++;
            fetchData();
          },
        );
      },
    );
  }

  /**
   * 获取目录列表页
   */
  List<Widget> getListView() {
    List<Widget> chapterChildren = [];
    recommends.forEach((chapterName) {
      chapterChildren.add(VideoBlockItemView(chapterName, Colors.transparent));
    });
    List<Widget> listChild = [];
    listChild.add(Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Wrap(spacing: 15, runSpacing: 15, children: chapterChildren),
    ));
    return listChild;
  }

  back() {
    Navigator.pop(context);
  }
}
