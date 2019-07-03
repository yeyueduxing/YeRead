import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/app/app_navigator.dart';
import 'package:tianyue/app/ty_color.dart';
import 'package:flutter/src/material/refresh_indicator.dart' as Refresh;

/**
 * 通用的列表
 */
class BaseListWidget extends StatefulWidget {
  List<Widget> childrens;
  EdgeInsetsGeometry margin;
  MoreClaaback onRefresh;
  MoreClaaback onMore;

  BaseListWidget(this.childrens, {this.margin, this.onRefresh, this.onMore});

  @override
  State<StatefulWidget> createState() => BaselistState();
}

class BaselistState extends State<BaseListWidget>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = false; //是否正在加载数据
  ScrollController _scrollController = ScrollController(); //listview的控制器

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
  }

  /**
   * 上拉加载更多
   */
  Future _getMore() async {
    //判断是否需要做更多的处理
    if (widget.onMore != null) {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
        await widget.onMore();
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  /**
   * 加载更多时显示的组件,给用户提示
   */
  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...',
              style: TextStyle(fontSize: 16.0),
            ),
            CircularProgressIndicator(
              strokeWidth: 1.0,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }

  Future<void> onloadRefresh() async{
      await widget.onRefresh();
  }

  Widget getListView() {
    if (widget.childrens == null || widget.childrens.length == 0) {
      return Container();
    }
    int itemCount = widget.childrens.length;
    if(widget.onMore!=null){
      itemCount = widget.childrens.length+1;
    }
    if (widget.onRefresh != null) {
      return RefreshIndicator(
        onRefresh: onloadRefresh,
        child: Container(
          margin: widget.margin == null
              ? EdgeInsets.fromLTRB(10, 0, 0, 0)
              : widget.margin,
          child: ListView.builder(
            itemBuilder: _renderRow,
            itemCount: itemCount,
            controller: _scrollController,
          ),
        ),
      );
    } else {
      return Container(
        margin: widget.margin == null
            ? EdgeInsets.fromLTRB(10, 0, 0, 0)
            : widget.margin,
        child: ListView.builder(
          itemBuilder: _renderRow,
          itemCount: itemCount,
          controller: _scrollController,
        ),
      );
    }
  }
  Widget _renderRow(BuildContext context, int index) {
    if (index < widget.childrens.length) {
      return widget.childrens[index];
    }
    return _getMoreWidget();
  }
}
typedef MoreClaaback = Future<void> Function();
