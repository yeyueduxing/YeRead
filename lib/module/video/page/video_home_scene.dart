import 'package:flutter/material.dart';
import 'package:tianyue/module/novel/widget/novel_rank_page_view.dart';
import 'package:tianyue/module/video/bean/video_home_list.dart';
import 'package:tianyue/module/video/model/video_model.dart';
import 'package:tianyue/module/video/page/video_recommend_scene.dart';
import 'package:tianyue/module/video/widget/voide_block_view.dart';

import 'package:tianyue/public.dart';
import 'package:tianyue/widget/loading_indicator.dart';

/**
 * 视频首页
 */

class VideoHomeScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VideoHomeState();
}

class VideoHomeState extends State<VideoHomeScene>
    with AutomaticKeepAliveClientMixin {
  VideoHomeListEntity videoHomeListEntity;

  /// 是否请求数据完毕
  bool isDataReady = false;
  PageState pageState = PageState.Loading;

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
      videoHomeListEntity = await VideoModel.getHome();
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




  @override
  Widget build(BuildContext context) {
    super.build(context); //必须添加
    //如果数据为空，或者数据不存在，则显示重新加载
    if (isDataReady==false) {
      return LoadingIndicator(
        pageState,
        retry: _retry,
      );
    }
    return Scaffold(
      backgroundColor: TYColor.white,
      body: Stack(children: [
        RefreshIndicator(
          onRefresh: fetchData,
          color: TYColor.primary,
          child: ListView(
            children: <Widget>[
              VoideBlockView("每日推荐",videoHomeListEntity.recommends,ViewoReType.Recommend),
              VoideBlockView("每日更新",videoHomeListEntity.updates,ViewoReType.Update),
            ],
          ),
        ),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
