import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tianyue/module/novel/bean/novel_chapter_detail_entity.dart';
import 'package:tianyue/module/novel/bean/novel_menu.dart';
import 'package:tianyue/module/novel/bean/novel_menu_list_entity.dart';
import 'package:tianyue/module/novel/model/novel_model.dart';
import 'dart:async';

import 'package:tianyue/public.dart';
import 'package:tianyue/widget/loading_indicator.dart';

import 'article_provider.dart';
import 'reader_utils.dart';
import 'reader_config.dart';

import 'reader_page_agent.dart';
import 'reader_menu.dart';
import 'reader_view.dart';

enum PageJumpType { stay, firstPage, lastPage }

class ReaderScene extends StatefulWidget {
  final NovelMenuListEntity menuList;

  ReaderScene({this.menuList});

  @override
  ReaderSceneState createState() => ReaderSceneState();
}

class ReaderSceneState extends State<ReaderScene>{
  int pageIndex = 0;
  int selectChapter = 0;
  bool isMenuVisiable = false;
  PageController pageController = PageController(keepPage: false);
  bool isLoading = false;

  double topSafeHeight = 0;

  NovelChapterInfo preArticle;
  NovelChapterInfo currentArticle;
  NovelChapterInfo nextArticle;

  List<Novelmenu> chapters = [];

  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();
    pageController.addListener(onScroll);

    Timer(Duration(milliseconds: 500), () {
      Screen.updateStatusBarStyle(SystemUiOverlayStyle.dark);
    });

    setup();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void setup() async {
    // 不延迟的话，安卓获取到的topSafeHeight是错的。
    topSafeHeight = Screen.topSafeHeight;

    pageState = PageState.Content;

    chapters = widget.menuList.mixToc.chapters;

    await resetContent(chapters[0].link, PageJumpType.stay);
  }

  resetContent(String articleId, PageJumpType jumpType) async {
    currentArticle = await fetchArticle(articleId);
    if (selectChapter > 0) {
      preArticle = await fetchArticle(chapters[selectChapter-1].link);
    } else {
      preArticle = null;
    }
    if (selectChapter < (chapters.length-1)) {
      nextArticle = await fetchArticle(chapters[selectChapter+1].link);
    } else {
      nextArticle = null;
    }
    if (jumpType == PageJumpType.firstPage) {
      selectChapter = 0;
    } else if (jumpType == PageJumpType.lastPage) {
      selectChapter = chapters.length - 1;
    }
    if (jumpType != PageJumpType.stay) {
      pageController.jumpToPage((preArticle != null ? preArticle.pageCount : 0) + pageIndex);
    }

    setState(() {});
  }

  /// 失败重试
  _retry() {
    pageState = PageState.Loading;
    setState(() {});
    setup();
  }

  onScroll() {
    var page = pageController.offset / Screen.width;

    var nextArtilePage = currentArticle.pageCount + (preArticle != null ? preArticle.pageCount : 0);
    if (page >= nextArtilePage) {
      print('到达下个章节了');

      preArticle = currentArticle;
      currentArticle = nextArticle;
      nextArticle = null;
      pageIndex = 0;
      pageController.jumpToPage(preArticle.pageCount);
      fetchNextArticle(chapters[selectChapter].link);
      setState(() {});
    }
    if (preArticle != null && page <= preArticle.pageCount - 1) {
      print('到达上个章节了');

      nextArticle = currentArticle;
      currentArticle = preArticle;
      preArticle = null;
      pageIndex = currentArticle.pageCount - 1;
      pageController.jumpToPage(currentArticle.pageCount - 1);
      fetchPreviousArticle(chapters[selectChapter].link);
      setState(() {});
    }
  }

  fetchPreviousArticle(String articleId) async {
    if (preArticle != null || isLoading || articleId == 0) {
      return;
    }
    isLoading = true;
    preArticle = await fetchArticle(articleId);
    pageController.jumpToPage(preArticle.pageCount + pageIndex);
    isLoading = false;
    setState(() {});
  }

  fetchNextArticle(String articleId) async {
    if (nextArticle != null || isLoading || articleId == 0) {
      return;
    }
    isLoading = true;
    nextArticle = await fetchArticle(articleId);
    isLoading = false;
    setState(() {});
  }

  Future<NovelChapterInfo> fetchArticle(String articleId) async {
    NovelChapterInfo article = await NovelModel.getBookDetailInfo(articleId);
    var contentHeight = Screen.height - topSafeHeight - ReaderUtils.topOffset - Screen.bottomSafeHeight - ReaderUtils.bottomOffset - 20;
    var contentWidth = Screen.width - 15 - 10;
    article.pageOffsets = ReaderPageAgent.getPageOffsets(article.body, contentHeight, contentWidth, ReaderConfig.instance.fontSize);

    return article;
  }

  onTap(Offset position) async {
    double xRate = position.dx / Screen.width;
    if (xRate > 0.33 && xRate < 0.66) {
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
      setState(() {
        isMenuVisiable = true;
      });
    } else if (xRate >= 0.66) {
      nextPage();
    } else {
      previousPage();
    }
  }

  onPageChanged(int index) {
    var page = index - (preArticle != null ? preArticle.pageCount : 0);
    if (page < currentArticle.pageCount && page >= 0) {
      setState(() {
        pageIndex = page;
      });
    }
  }

  previousPage() {
    if (pageIndex == 0 ) {
      Toast.show('已经是第一页了');
      return;
    }
    pageController.previousPage(duration: Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  nextPage() {
    if (pageIndex >= currentArticle.pageCount - 1 ) {
      Toast.show('已经是最后一页了');
      return;
    }
    pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  buildPageView() {
    if (currentArticle == null) {
      return Container();
    }

    int itemCount = (preArticle != null ? preArticle.pageCount : 0) + currentArticle.pageCount + (nextArticle != null ? nextArticle.pageCount : 0);
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      controller: pageController,
      itemCount: itemCount,
      itemBuilder: buildPage,
      onPageChanged: onPageChanged,
    );
  }

  Widget buildPage(BuildContext context, int index) {
    var page = index - (preArticle != null ? preArticle.pageCount : 0);
    var article;
    if (page >= this.currentArticle.pageCount) {
      // 到达下一章了
      article = nextArticle;
      page = 0;
    } else if (page < 0) {
      // 到达上一章了
      article = preArticle;
      page = preArticle.pageCount - 1;
    } else {
      article = this.currentArticle;
    }

    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        onTap(details.globalPosition);
      },
      child: ReaderView(article: article, page: page, topSafeHeight: topSafeHeight),
    );
  }

  buildMenu() {
    if (!isMenuVisiable) {
      return Container();
    }
    return ReaderMenu(
      chapters: chapters,
      articleIndex: 0,
      onTap: hideMenu,
      onPreviousArticle: () {
        resetContent("", PageJumpType.firstPage);
      },
      onNextArticle: () {
        resetContent("", PageJumpType.firstPage);
      },
      onToggleChapter: (Novelmenu chapter) {
        resetContent(chapter.link, PageJumpType.firstPage);
      },
    );
  }

  hideMenu() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    setState(() {
      this.isMenuVisiable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentArticle == null || chapters == null) {
      return LoadingIndicator(
        pageState,
        retry: _retry,
      );
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(left: 0, top: 0, right: 0, bottom: 0, child: Image.asset('img/read_bg.png', fit: BoxFit.cover)),
          buildPageView(),
          buildMenu(),
        ],
      ),
    );
  }
}
