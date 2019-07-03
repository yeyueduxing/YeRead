import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/app/app_navigator.dart';
import 'package:tianyue/app/ty_color.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/comic/widget/comic_rank_top_switch.dart';
import 'package:tianyue/module/novel/bean/novel_booklist_detail_entity.dart';
import 'package:tianyue/module/novel/bean/novel_comment_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_menu.dart';
import 'package:tianyue/module/novel/bean/novel_menu_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_post_list_entity.dart';
import 'package:tianyue/module/novel/model/novel_model.dart';
import 'package:tianyue/module/novel/widget/novel_booklist_detail_cell.dart';
import 'package:tianyue/module/novel/widget/novel_comment_cell.dart';
import 'package:tianyue/module/novel/widget/novel_post_cell.dart';
import 'package:tianyue/utility/screen.dart';
import 'package:tianyue/utility/styles.dart';
import 'package:tianyue/widget/loading_indicator.dart';

/**
 * 书单详情
 */
class NovelBooklistDetailScene extends StatefulWidget {
  /// 详情
  String novelId;

  NovelBooklistDetailScene(this.novelId);

  @override
  State<StatefulWidget> createState() => NovelPostPageState();
}

class NovelPostPageState extends State<NovelBooklistDetailScene>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  NovelBooklistDetailEntity novelBooklistDetail;
  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();
    //初始化界面
    fetchData();
  }

  fetchData() async {
    try {
      novelBooklistDetail = await NovelModel.getBooklistDetail(widget.novelId);
      print(novelBooklistDetail);
      setState(() {
        pageState = PageState.Content;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    if (novelBooklistDetail == null) {
      return LoadingIndicator(
        pageState,
      );
    }
    //创建界面视图
    return Scaffold(
      backgroundColor: TYColor.white,
      appBar: AppBar(
        brightness: Brightness.light,
        title: Container(
            height: 40,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("书单")
        ),
        backgroundColor: TYColor.white,
        elevation: 0,
      ),
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
    novelBooklistDetail.bookList.books.forEach((chapterName) {
      chapterChildren.add(NovelBookListDetailCell(chapterName));
    });

    return ListView(
      children: chapterChildren,
    );
  }

  back() {
    Navigator.pop(context);
  }
}
