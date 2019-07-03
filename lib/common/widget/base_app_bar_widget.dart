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
 * 通用的底层界面样式
 */
class BaseAppBarWidget extends StatefulWidget {
  //标题
  String title;

  //顶部视图
  Widget barView;
  TextStyle titleStyle;
  BodyView body;
  List<Widget> actions;

  //数据是否加载已经完成
  bool isDataReady = true;
  PageState pageState = PageState.Loading;
  Retry retry;

  BaseAppBarWidget(
      {this.title,
      this.barView,
      this.titleStyle,
      this.body,
      this.isDataReady,
        this.actions,
      this.retry});

  @override
  State<StatefulWidget> createState() => NovelPostPageState();
}

class NovelPostPageState extends State<BaseAppBarWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //创建界面视图
    Widget barChild = null;
    if (widget.barView != null) {
      //如果有动态配置顶部视图，使用动态配置的
      barChild = widget.barView;
    } else {
      //如果没有配置，直接使用
      barChild = Text(
        widget.title == null ? "标题" : widget.title,
        style: widget.titleStyle ??= new TextStyle(),
      );
    }
    return Scaffold(
      backgroundColor: TYColor.white,
      appBar: AppBar(
        brightness: Brightness.light,
        title: Container(
          height: 40,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: barChild,
        ),
        actions: widget.actions,
        backgroundColor: TYColor.white,
        elevation: 0,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (widget.isDataReady == false) {
      return LoadingIndicator(
        widget.pageState == null ? PageState.Loading : widget.pageState,
        retry: widget.retry,
      );
    }
    return widget.body();
  }
}

//不直接传递组件进来，因为直接传递的时候会加载视图，但很多时候视图是在有数据的时候才加载，会有异常
typedef BodyView = Widget Function();
