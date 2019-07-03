import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tianyue/common/widget/base_list_widget.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/comic/widget/comic_read_image_view.dart';
import 'package:tianyue/module/comic/widget/comic_reader_menu.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/widget/loading_indicator.dart';

/**
 * 漫画阅读页面
 */
class ComicReaderScene extends StatefulWidget {
  final ComicDetailInfoEntity info;
  int select_index = 0;

  ComicReaderScene(this.info, {this.select_index});

  @override
  ComicReaderState createState() => ComicReaderState();
}

class ComicReaderState extends State<ComicReaderScene> with RouteAware {
  ScrollController scrollController = ScrollController();

  //界面加载
  bool isDataReady = false;
  bool isMenuVisiable = false;
  List<String> imageList = [];
  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> _onRefresh() async {
    //下拉刷新，在漫画中，下拉会加载上一章节的数据，而且当前的界面数据应该继续存在
    try {
      if (widget.select_index > 0) {
        widget.select_index = widget.select_index - 1;
      }else{
        setState(() {
          isDataReady = true;
        });
        return;
      }
      List<String> addlist = [];
      for (var i = 1;
          i <= widget.info.comicChapter[widget.select_index].endNum;
          i++) {
        String picUrl = widget.info.comicChapter[widget.select_index].rule;
        picUrl = picUrl.replaceFirst("\$\$", i.toString());
        //数据要添加在顶部
        addlist.add("http://mhpic.jumanhua.com" + picUrl + "-aym.high.webp");
      }
      imageList.addAll(addlist);
      setState(() {
        isDataReady = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  /**
   * 加载更多
   */
  Future<void> _getMoreData() async {
    try {
      setState(() {
        isDataReady = true;
      });
      widget.select_index++;

      for (var i = 1;
          i <= widget.info.comicChapter[widget.select_index].endNum;
          i++) {
        String picUrl = widget.info.comicChapter[widget.select_index].rule;
        picUrl = picUrl.replaceFirst("\$\$", i.toString());
        imageList.add("http://mhpic.jumanhua.com" + picUrl + "-aym.high.webp");
      }
      await Future.delayed(Duration(milliseconds: 2000), () {
        pageState = PageState.Content;
      });
      setState(() {
        isDataReady = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void didPopNext() {
    Screen.updateStatusBarStyle(SystemUiOverlayStyle.dark);
  }

  @override
  void didPush() {
    super.didPush();
    Timer(Duration(milliseconds: 1000), () {
      Screen.updateStatusBarStyle(SystemUiOverlayStyle.dark);
    });
  }

  Future<void> fetchData() async {
    try {
      imageList.clear();
      for (var i = 1;
          i <= widget.info.comicChapter[widget.select_index].endNum;
          i++) {
        String picUrl = widget.info.comicChapter[widget.select_index].rule;
        picUrl = picUrl.replaceFirst("\$\$", i.toString());
        imageList.add("http://mhpic.jumanhua.com" + picUrl + "-aym.high.webp");
      }
      await Future.delayed(Duration(milliseconds: 2000), () {
        pageState = PageState.Content;
      });
      setState(() {
        isDataReady = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  /// 失败重试
  _retry() {
    pageState = PageState.Loading;
    setState(() {});
    fetchData();
  }

  onTap(Offset position) async {
    double xRate = position.dx / Screen.width;
    if (xRate > 0.33 && xRate < 0.66) {
      SystemChrome.setEnabledSystemUIOverlays(
          [SystemUiOverlay.top, SystemUiOverlay.bottom]);
      setState(() {
        isMenuVisiable = true;
      });
    }
  }

  Widget buildWidget(int index) {
    return ComicReadImage(imageList[index], fit: BoxFit.fitWidth);
  }

  @override
  Widget build(BuildContext context) {
    if (!isDataReady) {
      return LoadingIndicator(
        pageState,
        retry: _retry,
      );
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTapUp: (TapUpDetails details) {
              onTap(details.globalPosition);
            },
            child: BaseListWidget(
              getListView(),
              onRefresh: _onRefresh,
              onMore: _getMoreData,
            ),
          ),
          buildMenu(),
        ],
      ),
    );
  }

  List<Widget> getListView() {
    List<Widget> childrens = [];
    int index = 0;
    imageList.forEach((item) {
      childrens.add(buildWidget(index));
      index++;
    });
    return childrens;
  }

  buildMenu() {
    if (!isMenuVisiable) {
      return Container();
    }
    return ComicReaderMenu(
      chapters: widget.info.comicChapter,
      articleIndex: widget.select_index,
      onTap: hideMenu,
      onPreviousArticle: () {
        if(widget.select_index<1){
          Toast.show('已经是第一页了');
        }else{
          widget.select_index--;
          fetchData();
        }
      },
      onNextArticle: () {
        if(widget.select_index>=(widget.info.comicChapter.length-1)){
          Toast.show('已经是最后一页了');
        }else{
          widget.select_index++;
          fetchData();
        }
      },
      onToggleChapter: (ComicDetailInfoComicChapter chapter, int index) {
        //章节跳转
        widget.select_index = index;
        fetchData();
      },
    );
  }

  hideMenu() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    setState(() {
      this.isMenuVisiable = false;
    });
  }
}
