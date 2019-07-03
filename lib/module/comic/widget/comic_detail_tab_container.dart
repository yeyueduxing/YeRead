import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/module/comic/widget/comic_detail_desc.dart';
import 'package:tianyue/module/comic/widget/comic_detail_tab_three.dart';
import 'package:tianyue/module/comic/widget/comic_detail_chapter.dart';
import 'package:tianyue/public.dart';

class ComicDetailTabContainer extends StatefulWidget {
  final TabController tabController;

  ComicDetailTabContainer(
      {Key key, @required this.tabController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ComicDetailTabState();
}

class ComicDetailTabState extends State<ComicDetailTabContainer> {
  ComicDetail comicDetail;
  ComicChapter comicChapter;

  /// 详情数据是否准备完毕
  bool _comicDetailReady = false;

  /// 章节数据是否准备完毕
  bool _comicChapterReady = false;

  @override
  void initState() {
    super.initState();
    fetchDetailData();
    fetchChapterData();
  }

  Future<void> fetchDetailData() async {
    try {
      var responseJson = await Request.get(action: 'home_comic_detail');
      comicDetail = ComicDetail.fromJson(responseJson);
      setState(() {
        _comicDetailReady = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchChapterData() async {
    try {
      var responseJson = await Request.get(action: 'home_comic_chapter');
      comicChapter = ComicChapter.fromJson(responseJson);
      setState(() {
        _comicChapterReady = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_comicDetailReady || !_comicChapterReady) {
      return Container();
    }
    return TabBarView(
      children: <Widget>[
        ComicCommentTabThree(),
      ],
      controller: widget.tabController,
    );
  }
}
