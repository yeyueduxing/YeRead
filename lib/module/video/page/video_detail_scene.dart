import 'package:flutter/material.dart';
import 'package:tianyue/common/dao/video_dao.dart';
import 'package:tianyue/common/widget/base_app_bar_widget.dart';
import 'package:tianyue/module/novel/widget/novel_rank_page_view.dart';
import 'package:tianyue/module/video/bean/video.dart';
import 'package:tianyue/module/video/bean/video_detail_page.dart';
import 'package:tianyue/module/video/bean/video_home_list.dart';
import 'package:tianyue/module/video/model/video_model.dart';
import 'package:tianyue/module/video/page/video_recommend_scene.dart';
import 'package:tianyue/module/video/widget/video_detail_cahpter.dart';
import 'package:tianyue/module/video/widget/video_detail_comment_view.dart';
import 'package:tianyue/module/video/widget/video_detail_overview_view.dart';
import 'package:tianyue/module/video/widget/video_detail_recommend_view.dart';
import 'package:tianyue/module/video/widget/voide_block_view.dart';

import 'package:tianyue/public.dart';
import 'package:tianyue/widget/loading_indicator.dart';

/**
 * 视频详情页
 */

class VideoDetailInfoScene extends StatefulWidget {
  Video video;

  VideoDetailInfoScene(this.video);

  @override
  State<StatefulWidget> createState() => VideoDetailState();
}

class VideoDetailState extends State<VideoDetailInfoScene>
    with AutomaticKeepAliveClientMixin {
  VideoDetailPage videoDetailPage;

  /// 是否请求数据完毕
  bool isDataReady = false;
  PageState pageState = PageState.Loading;
  bool _hasCollected = false;
  var _collectionIcons;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /**
   * 通过异步获取数据，然后动态更新
   */
  Future<void> fetchData() async {
    try {
      setState(() {
        isDataReady = false;
      });
      /**
       * 通过定时器更改网络状态
       */
      await Future.delayed(Duration(milliseconds: 2000), () {
        pageState = PageState.Content;
      });
      videoDetailPage = await VideoModel.getVideoDetail(widget.video.sId);
      _hasCollected = await VideoDao.isCollected(widget.video.sId);
      setState(() {
        isDataReady = true;
      });
    } catch (e) {
      print(e.toString());
      Toast.show(e.toString());
    }
  }

  /// 失败重试
  _retry() {
    pageState = PageState.Loading;
    setState(() {});
    fetchData();
  }

  _collectComic() async {
    if (videoDetailPage == null) {
      return;
    }
    if (_hasCollected) {
      VideoDao.cancelCollecte(widget.video.sId).then((result) {
        setState(() {
          _hasCollected = false;
        });
      });
    } else {
      VideoDao.addCollecte(videoDetailPage.info.title, widget.video.sId,
              videoDetailPage.info.cover)
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
    super.build(context); //必须添加
    //如果数据为空，或者数据不存在，则显示重新加载
    if (isDataReady == false) {
      return LoadingIndicator(
        pageState,
        retry: _retry,
      );
    }
    List<Widget> children = [];
    children.add(VideoDetailOverViewView(videoDetailPage.info));
    if (videoDetailPage.chapters != null &&
        videoDetailPage.chapters.length > 0) {
      videoDetailPage.chapters.forEach((item) {
        children.add(VideoDetailChapter(item));
      });
    }
    children.add(VideoDetailCommentView(videoDetailPage.comments));
    children.add(VideoDetailRecommendView(videoDetailPage.recommends));
    String title = "漫画";
    if (videoDetailPage != null) {
      title = videoDetailPage.info.title;
    }
    if (_hasCollected == true) {
      _collectionIcons = Icons.favorite;
    } else {
      _collectionIcons = Icons.favorite_border;
    }
    return BaseAppBarWidget(
      title: title,
      isDataReady: isDataReady,
      actions: <Widget>[
        new IconButton(
          tooltip: 'collection',
          onPressed: _collectComic,
          icon: Icon(_collectionIcons),
        ),
      ],
      body: () {
        return Scaffold(
          backgroundColor: TYColor.white,
          body: Stack(children: [
            RefreshIndicator(
              onRefresh: fetchData,
              color: TYColor.primary,
              child: ListView(
                children: children,
              ),
            ),
          ]),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
