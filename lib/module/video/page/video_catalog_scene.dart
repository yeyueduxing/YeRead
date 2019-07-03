import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/app/app_navigator.dart';
import 'package:tianyue/app/ty_color.dart';
import 'package:tianyue/common/style/ye_style.dart';
import 'package:tianyue/common/widget/base_app_bar_widget.dart';
import 'package:tianyue/common/widget/base_list_widget.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/comic/model/comic/comic_model.dart';
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
import 'package:tianyue/module/video/bean/video_catalog.dart';
import 'package:tianyue/module/video/bean/video_catalog_page.dart';
import 'package:tianyue/module/video/bean/video_info_entity.dart';
import 'package:tianyue/module/video/model/video_model.dart';
import 'package:tianyue/module/video/widget/video_catalog_view.dart';
import 'package:tianyue/module/video/widget/video_detail_overview_view.dart';
import 'package:tianyue/module/video/widget/voide_block_item_view.dart';
import 'package:tianyue/utility/app_utils.dart';
import 'package:tianyue/utility/screen.dart';
import 'package:tianyue/utility/styles.dart';
import 'package:tianyue/utility/toast.dart';
import 'package:tianyue/widget/loading_indicator.dart';
import 'package:tianyue/common/widget/novel_cover_image.dart';

/**
 * 视频目录
 */
class VideoCatalogScene extends StatefulWidget {
  VideoCatalogScene();

  @override
  State<StatefulWidget> createState() => NovelBookCategoryInfoState();
}

class NovelBookCategoryInfoState extends State<VideoCatalogScene>
    with AutomaticKeepAliveClientMixin {
  List<VideoInfoEntity> comicBlocks;
  List<VideoCatalog> catalogs;

  /// 是否请求数据完毕
  bool isDataReady = false;
  PageState pageState = PageState.Loading;
  String selectText = "all-all-all-all-all-all";
  int page = 1;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /**
   * 通过异步获取数据，然后动态更新
   */
  Future<void> initData() async {
    try {
      //获取关联漫画
      VideoCatalogPage pages =
          await VideoModel.getCatalogList(selectText, page);
      catalogs = pages.catalogs;
      comicBlocks = pages.items;
      setState(() {
        isDataReady = true;
      });
    } catch (e) {
      print(e.toString());
      Toast.show(e.toString());
    }
  }

  /**
   * 通过异步获取数据，然后动态更新
   */
  Future<void> fetchData() async {
    try {
      if (page == 1) {
        comicBlocks.clear();
      }
      //获取关联漫画
      VideoCatalogPage pages =
          await VideoModel.getCatalogList(selectText, page);
      comicBlocks.addAll(pages.items);
      setState(() {
        isDataReady = true;
      });
    } catch (e) {
      print(e.toString());
      Toast.show(e.toString());
    }
  }

  Future<void> _onRefresh() async {
    page = 1;
    fetchData();
  }

  Future<void> _onMoreData() async {
    page++;
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //必须添加
    return BaseAppBarWidget(
      title: "排行",
      isDataReady: isDataReady,
      body: () {
        return Stack(
          children: <Widget>[
            BaseListWidget(
              getListView(),
              onRefresh: _onRefresh,
              onMore: _onMoreData,
            ),
          ],
        );
      },
    );
  }

  List<Widget> getListView() {
    List<Widget> childrens = [];
    //获取目录
    catalogs.forEach((item) {
      childrens.add(getSelectView(item));
    });
    //获取页面
    comicBlocks.forEach((item) {
      childrens.add(VideoCatalogView(item));
    });
    return childrens;
  }

  @override
  bool get wantKeepAlive => true;

  /**
   * 获取赛选界面
   */
  Widget getSelectView(VideoCatalog catalog) {
    List<Widget> childList = [];
    catalog.items.forEach((types) {
      childList.add(getTagLabel(types));
    });
    return Container(
      height: 40,
      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        children: <Widget>[
          Text(
            catalog.title,
            style: new TextStyle(fontSize: 18, color: TYColor.darkGray),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: childList,
            ),
          )
        ],
      ),
    );
  }

  Widget getTagLabel(VideoCatalogItem item) {
    bool isSelect = false;
    if (selectText == item.param) {
      isSelect = true;
    }
    String showTitle = item.title.replaceAll("\n", "");
    showTitle = showTitle.replaceAll("\r", "");
    showTitle = showTitle.replaceAll(" ", "");
    return GestureDetector(
        onTap: () {
          setState(() {
            selectText = item.param;
            _onRefresh();
          });
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          margin: EdgeInsets.only(right: 10),
          decoration: new BoxDecoration(
            color: isSelect ? Colors.amber : TYColor.paper, // 底色
            borderRadius: new BorderRadius.circular((10.0)), // 圆角度
          ),
          height: 30,
          alignment: Alignment.center,
          child: Text(showTitle, style: YeConstant.smallText),
        ));
  }
}
