import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/app/app_navigator.dart';
import 'package:tianyue/app/ty_color.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/comic/widget/comic_rank_top_switch.dart';
import 'package:tianyue/module/novel/bean/novel_menu.dart';
import 'package:tianyue/module/novel/bean/novel_menu_list_entity.dart';
import 'package:tianyue/module/novel/model/novel_model.dart';
import 'package:tianyue/utility/screen.dart';
import 'package:tianyue/utility/styles.dart';
import 'package:tianyue/widget/loading_indicator.dart';

/**
 * 目录页码
 */
class NovelMenuScene extends StatefulWidget {
  /// 详情
  String novelId;
  NovelMenuScene(this.novelId);
  @override
  State<StatefulWidget> createState() => NovelMenuState();
}

class NovelMenuState extends State<NovelMenuScene>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  NovelMenuListEntity novelMenuList;
  int _selectTop=0;
  PageState pageState = PageState.Loading;
  @override
  void initState() {
    super.initState();
    //初始化界面
    fetchData();
  }
 fetchData() async{
   try {

     novelMenuList = await NovelModel.getNovelChapter(widget.novelId);
     setState(() {
       pageState = PageState.Content;
     });
   } catch (e) {}
  }
  @override
  Widget build(BuildContext context) {
    if(novelMenuList==null || novelMenuList.mixToc==null){
      return LoadingIndicator(
        pageState,
      );
    }
    //创建界面视图
    return Scaffold(
      backgroundColor: TYColor.white,
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              color: TYColor.white,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: getListView(),
                  ),
                ],
              )),
          buildNavigationBar()
        ],
      ),
    );
  }

  /**
   * 获取目录列表页
   */
  Widget getListView() {
    List<Widget> chapterChildren = [];
    int addIndex = 0;
    novelMenuList.mixToc.chapters.forEach((chapterName){
      chapterChildren.add(buildChapterWidget(context, chapterName,addIndex));
      addIndex++;
    });
    return ListView(
      children: chapterChildren,
    );
  }
  Widget buildChapterWidget(BuildContext context, Novelmenu chapterName,int index) {
    return GestureDetector(
        onTap: () {
          print(widget.novelId+"-"+chapterName.toJson().toString());
          AppNavigator.pushReader(context, novelMenuList);
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
            child: Text(chapterName.title,
                style: TextStyle(
                    fontSize: 17,
                    color: TYColor.gray,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none))));
  }
  back() {
    Navigator.pop(context);
  }
  Widget buildNavigationBar() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 1,
          child: Container(
            decoration: BoxDecoration(
                color: TYColor.white, boxShadow: Styles.borderShadow),
            padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
            height: Screen.navigationBarHeight,
            child: Row(
              children: <Widget>[
                Container(
                  width: 44,
                  child: GestureDetector(
                      onTap: back, child: Image.asset('img/pub_back_gray.png')),
                ),
                Expanded(
                  child: Text(
                    "目录",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(width: 44),
              ],
            ),
          ),
        )
      ],
    );
  }
}
