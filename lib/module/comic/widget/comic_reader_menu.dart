import 'package:flutter/material.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'dart:async';

import 'package:tianyue/public.dart';

/**
 * 漫画阅读菜单界面
 */
class ComicReaderMenu extends StatefulWidget {
  final List<ComicDetailInfoComicChapter> chapters;
  final int articleIndex;

  final VoidCallback onTap;
  final VoidCallback onPreviousArticle;
  final VoidCallback onNextArticle;
  final void Function(ComicDetailInfoComicChapter chapter, int index)
      onToggleChapter;

  ComicReaderMenu(
      {this.chapters,
      this.articleIndex,
      this.onTap,
      this.onPreviousArticle,
      this.onNextArticle,
      this.onToggleChapter});

  @override
  _ComicReaderMenuState createState() => _ComicReaderMenuState();
}

class _ComicReaderMenuState extends State<ComicReaderMenu>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  //AnimationController menuAnimationController;
 // Animation<double> menuAanimation;

  double progressValue;
  bool isTipVisible = false;

  @override
  initState() {
    super.initState();

    progressValue =
        this.widget.articleIndex / (this.widget.chapters.length - 1);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animation.addListener(() {
      setState(() {});
    });

//    menuAnimationController = AnimationController(
//        duration: const Duration(milliseconds: 200), vsync: this);
//    menuAanimation = Tween(begin: 0.0, end: 1.0).animate(menuAnimationController);
//    menuAanimation.addListener(() {
//      setState(() {});
//    });
    animationController.forward();
  }

  @override
  void didUpdateWidget(ComicReaderMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    progressValue =
        this.widget.articleIndex / (this.widget.chapters.length - 1);
  }

  @override
  void dispose() {
    animationController.dispose();
   // menuAnimationController.dispose();
    super.dispose();
  }

  hide() {
    animationController.reverse();
    Timer(Duration(milliseconds: 200), () {
      this.widget.onTap();
    });
    setState(() {
      isTipVisible = false;
    });
  }

  buildTopView(BuildContext context) {
    return Positioned(
      top: -Screen.navigationBarHeight * (1 - animation.value),
      left: 0,
      right: 0,
      child: Container(
        decoration:
            BoxDecoration(color: TYColor.paper, boxShadow: Styles.borderShadow),
        height: Screen.navigationBarHeight,
        padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 5, 0),
        child: Row(
          children: <Widget>[
            Container(
              width: 44,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('img/pub_back_gray.png'),
              ),
            ),
            Expanded(child: Container()),
            Container(
              width: 44,
              child: Image.asset('img/read_icon_voice.png'),
            ),
            Container(
              width: 44,
              child: Image.asset('img/read_icon_more.png'),
            ),
          ],
        ),
      ),
    );
  }

  //左侧的菜单界面
  buildLeftMenuView(BuildContext context) {
    return Positioned(
      top: 0,
      left: -Screen.width * (1 - animation.value),
      right: 0,
      child: Container(
        decoration:
            BoxDecoration(color: TYColor.paper, boxShadow: Styles.borderShadow),
        width: Screen.width/2,
        padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 5, 0),
        child: Column(
          children: <Widget>[
            Text("目录"),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.chapters.length,
                  itemBuilder: (context, index) {
                    return buildChapterWidget(
                        context, widget.chapters[index], index);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget buildChapterWidget(BuildContext context,
      ComicDetailInfoComicChapter chapterName, int index) {
    return GestureDetector(
        onTap: () {},
        child: Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
            child: Text(chapterName.chapterName,
                style: TextStyle(
                    fontSize: 17,
                    color: TYColor.gray,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none))));
  }

  int currentArticleIndex() {
    return ((this.widget.chapters.length - 1) * progressValue).toInt();
  }

  buildProgressTipView() {
    if (!isTipVisible) {
      return Container();
    }
    ComicDetailInfoComicChapter chapter =
        this.widget.chapters[currentArticleIndex()];
    double percentage =
        widget.articleIndex / (this.widget.chapters.length - 1) * 100;
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff00C88D), borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(chapter.chapterName,
              style: TextStyle(color: Colors.white, fontSize: 16)),
          Text('${percentage.toStringAsFixed(1)}%',
              style: TextStyle(color: TYColor.lightGray, fontSize: 12)),
        ],
      ),
    );
  }

  previousArticle() {
    if (this.widget.articleIndex == 0) {
      Toast.show('已经是第一章了');
      return;
    }
    this.widget.onPreviousArticle();
    setState(() {
      isTipVisible = true;
    });
  }

  nextArticle() {
    if (this.widget.articleIndex == this.widget.chapters.length - 1) {
      Toast.show('已经是最后一章了');
      return;
    }
    this.widget.onNextArticle();
    setState(() {
      isTipVisible = true;
    });
  }

  buildProgressView() {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: previousArticle,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Image.asset('img/read_icon_chapter_previous.png'),
            ),
          ),
          Expanded(
            child: Slider(
              value: progressValue,
              onChanged: (double value) {
                setState(() {
                  isTipVisible = true;
                  progressValue = value;
                });
              },
              onChangeEnd: (double value) {
                ComicDetailInfoComicChapter chapter =
                    this.widget.chapters[currentArticleIndex()];
                this.widget.onToggleChapter(chapter, currentArticleIndex());
              },
              activeColor: TYColor.primary,
              inactiveColor: TYColor.gray,
            ),
          ),
          GestureDetector(
            onTap: nextArticle,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Image.asset('img/read_icon_chapter_next.png'),
            ),
          )
        ],
      ),
    );
  }

  buildBottomView() {
    return Positioned(
      bottom: -(Screen.bottomSafeHeight + 110) * (1 - animation.value),
      left: 0,
      right: 0,
      child: Column(
        children: <Widget>[
          buildProgressTipView(),
          Container(
            decoration: BoxDecoration(
                color: TYColor.paper, boxShadow: Styles.borderShadow),
            padding: EdgeInsets.only(bottom: Screen.bottomSafeHeight),
            child: Column(
              children: <Widget>[
                buildProgressView(),
                buildBottomMenus(),
              ],
            ),
          )
        ],
      ),
    );
  }

  buildBottomMenus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        buildBottomItem('目录', 'img/read_icon_catalog.png'),
        buildBottomItem('亮度', 'img/read_icon_brightness.png'),
        buildBottomItem('字体', 'img/read_icon_font.png'),
        buildBottomItem('设置', 'img/read_icon_setting.png'),
      ],
    );
  }

  buildBottomItem(String title, String icon) {
    return GestureDetector(
      onTap: (){
        //menuAnimationController.forward();
      },
      child:  Container(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: Column(
            children: <Widget>[
              Image.asset(icon),
              SizedBox(height: 5),
              Text(title,
                  style: TextStyle(
                      fontSize: fixedFontSize(12), color: TYColor.darkGray)),
            ],
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTapDown: (_) {
              hide();
            },
            child: Container(color: Colors.transparent),
          ),
          buildTopView(context),
          buildBottomView(),
          //buildLeftMenuView(context),
        ],
      ),
    );
  }
}
