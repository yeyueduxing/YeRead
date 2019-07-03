import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/app/app_navigator.dart';
import 'package:tianyue/app/ty_color.dart';
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
import 'package:tianyue/utility/app_utils.dart';
import 'package:tianyue/utility/screen.dart';
import 'package:tianyue/utility/styles.dart';
import 'package:tianyue/widget/loading_indicator.dart';
import 'package:tianyue/common/widget/novel_cover_image.dart';

/**
 * 分类详情书籍列表页面
 */
class NovelBookCategoryInfoScene extends StatefulWidget {
  NovelBookStatistics info;
  String gender;

  NovelBookCategoryInfoScene(this.info, this.gender);

  @override
  State<StatefulWidget> createState() => NovelBookCategoryInfoState();
}

class NovelBookCategoryInfoState extends State<NovelBookCategoryInfoScene>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  NovelCateInfoEntity novelCateInfoEntity;
  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();
    //初始化界面
    fetchData();
  }

  fetchData() async {
    try {
      novelCateInfoEntity = await NovelModel.getBookCategoriesInfo(
          widget.gender, widget.info.name, "", 0, 20);
      if (novelCateInfoEntity == null) {
        print("为空");
      }
      setState(() {
        pageState = PageState.Content;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    if (novelCateInfoEntity == null) {
      return LoadingIndicator(
        pageState,
      );
    }
    print("不为空");
    //创建界面视图
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Container(
            height: 40,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(widget.info.name)),
        backgroundColor: TYColor.white,
        elevation: 0,
      ),
      backgroundColor: TYColor.white,
      body: Stack(
        children: <Widget>[
          Container(
              color: TYColor.white,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: getListView(),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  /**
   * 获取目录列表页
   */
  Widget getListView() {
    List<Widget> chapterChildren = [];
    novelCateInfoEntity.books.forEach((chapterName) {
      chapterChildren.add(NovelListItemView(chapterName, Colors.transparent));
    });
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child:ListView(
        children: chapterChildren,
      ) ,
    );
  }

  back() {
    Navigator.pop(context);
  }
}
