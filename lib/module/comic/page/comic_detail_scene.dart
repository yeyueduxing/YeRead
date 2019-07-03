import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tianyue/common/dao/comic_dao.dart';
import 'package:tianyue/common/widget/base_app_bar_widget.dart';
import 'package:tianyue/module/comic/model/comic/comic_model.dart';
import 'package:tianyue/module/comic/widget/comic_detail_overview_view.dart';
import 'package:tianyue/module/comic/widget/comic_detail_tab_container.dart';
import 'package:tianyue/module/comic/widget/comic_detail_desc.dart';
import 'package:tianyue/module/comic/widget/comic_detail_recommend.dart';
import 'package:tianyue/module/comic/widget/comic_detail_tab_three.dart';
import 'package:tianyue/module/comic/widget/comic_detail_chapter.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/comic/bean/comic_recommend_entity.dart';
import 'package:tianyue/public.dart';
import 'dart:math' as math;

import 'package:tianyue/widget/loading_indicator.dart';

/**
 * 漫画详情
 */
class ComicDetailScene extends StatefulWidget {
  final String url;

  ComicDetailScene(this.url);

  @override
  State<StatefulWidget> createState() => ComicDetailState();
}

class ComicDetailState extends State<ComicDetailScene>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();

  bool isOverviewDataReady = false;

  /// 顶部介绍
  ComicOverview comicOverview;

  /// 详情
  ComicDetailInfoEntity comicDetail;

  /// 推荐
  List<ComicRecommendEntity> comicChapter;
  bool _hasCollected = false;
  var _collectionIcons;
  var width = Screen.width;
  double navAlpha = 0;
  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 1000), () {
      Screen.updateStatusBarStyle(SystemUiOverlayStyle.dark);
    });

    _fetchData();
    _scrollController.addListener(() {
      var offset = _scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < 50) {
        setState(() {
          navAlpha = 1 - (50 - offset) / 50;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<void> _fetchData() async {
    try {
      //获取漫画详情
      comicDetail = await ComicModel.getDetial(widget.url);
      //对章节进行反序转换
      if (comicDetail != null &&
          comicDetail.comicChapter != null &&
          comicDetail.comicChapter.length > 0) {
        List<ComicDetailInfoComicChapter> chapters = [];
        for (var i = 0; i < comicDetail.comicChapter.length; i++) {
          chapters.add(comicDetail
              .comicChapter[comicDetail.comicChapter.length - i - 1]);
        }
        comicDetail.comicChapter = chapters;
      }
      //获取关联漫画
      comicChapter = await ComicModel.getRecommentById(widget.url);

      pageState = PageState.Content;

      _hasCollected = await ComicDao.isCollected(widget.url);
      setState(() {
        isOverviewDataReady = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  /// 失败重试
  _retry() {
    pageState = PageState.Loading;
    setState(() {});
    _fetchData();
  }

  Widget _getBottomReader() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              width: 120,
              height: 30,
              child: Image.asset(
                'img/detail_bottom_read.png',
                fit: BoxFit.contain,
              ),
              alignment: Alignment.center,
            ),
          ),
          Container(
            width: width * 0.4,
            height: 40,
            child: RaisedButton(

                /// 水波纹不显示
                splashColor: Colors.transparent,
                disabledTextColor: Color(0xffff0000),
                color: TYColor.primary,
                disabledColor: TYColor.orange,
                onPressed: () =>
                    AppNavigator.pushComicReader(context, comicDetail, 0),
                child: Text(
                  "开始阅读",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: TYColor.white,
                      decoration: TextDecoration.none),
                )),
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: TYColor.primary),
          )
        ],
      ),
      height: 60,
      width: width,
    );
  }

  Widget getListView() {
    return ListView(
      controller: _scrollController,
      children: <Widget>[
        ComicDetailOverViewView(comicDetail),
        ComicDetailDesc(comicDetail),
        ComicDetailChapter(comicDetail),
        ComicDetailRecommend(comicChapter),
      ],
    );
  }

  _collectComic() async {
    if (comicDetail == null) {
      return;
    }
    if (_hasCollected) {
      ComicDao.cancelCollecte(widget.url).then((result) {
        setState(() {
          _hasCollected = false;
        });
      });
    } else {
      ComicDao.addCollecte(
              comicDetail.comicName, widget.url, comicDetail.coverList[0])
          .then((result) {
        setState(() {
          _hasCollected = true;
        });
      });
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = "漫画";
    if (comicDetail != null) {
      title = comicDetail.comicName;
    }
    if (_hasCollected==true) {
      _collectionIcons = Icons.favorite;
    } else {
      _collectionIcons = Icons.favorite_border;
    }
    return BaseAppBarWidget(
      title: title,
      isDataReady: isOverviewDataReady,
      actions: <Widget>[
        new IconButton(
          tooltip: 'collection',
          onPressed: _collectComic,
          icon: Icon(_collectionIcons),
        ),
      ],
      body: () {
        return Stack(children: <Widget>[
          Container(
              color: TYColor.white,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: getListView(),
                  ),
                  Container(
                      width: width, height: 0.7, color: Color(0xffe1e1e1)),
                  _getBottomReader(),
                ],
              )),
        ]);
      },
    );
  }
}
