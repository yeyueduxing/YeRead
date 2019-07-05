import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/app/app_navigator.dart';
import 'package:tianyue/app/ty_color.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/comic/widget/comic_rank_top_switch.dart';
import 'package:tianyue/module/novel/bean/novel_booklist.dart';
import 'package:tianyue/module/novel/bean/novel_comment_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_menu.dart';
import 'package:tianyue/module/novel/bean/novel_menu_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_post_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_tags.dart';
import 'package:tianyue/module/novel/model/novel_model.dart';
import 'package:tianyue/module/novel/widget/novel_book_list_cell.dart';
import 'package:tianyue/module/novel/widget/novel_comment_cell.dart';
import 'package:tianyue/module/novel/widget/novel_post_cell.dart';
import 'package:tianyue/utility/screen.dart';
import 'package:tianyue/utility/styles.dart';
import 'package:tianyue/widget/loading_indicator.dart';

/**
 * 书单列表页
 */
class NovelBookListPageScene extends StatefulWidget {
  /// 详情
  bool isMale;
  List<NovelBookTags> novelBookTags;

  NovelBookListPageScene(this.isMale, this.novelBookTags);

  @override
  State<StatefulWidget> createState() => NovelBookListPageState();
}

class NovelBookListPageState extends State<NovelBookListPageScene>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<NovelBooklist> novelBookLists = [];
  PageState pageState = PageState.Loading;

  //书单类型，最新，最热，收藏最多
  int _selectDuration = 0;
  bool isShowSelect = false;

  //一级的分类
  String _selectTag;

  //二级分类
  String _secondTag;

  @override
  void initState() {
    super.initState();
    //初始化界面
    fetchData();
  }

  fetchData() async {
    try {
      String sort = "last-seven-days&sort=collectorCount";
      if (_selectDuration == 0) {
        sort = "last-seven-days&sort=collectorCount";
      } else if (_selectDuration == 1) {
        sort = "all&sort=created,";
      } else if (_selectDuration == 2) {
        sort = "all&sort=collectorCount";
      }
      String tag = _selectTag;
      if (_secondTag != null) {
        tag = _secondTag;
      }
      novelBookLists =
          await NovelModel.getBookList(widget.isMale, sort, tag, 0, 20);
      setState(() {
        pageState = PageState.Content;
      });
    } catch (e) {}
  }

  showSelect() async {
    setState(() {
      isShowSelect = isShowSelect == true ? false : true;
    });
  }

  Widget getSlectWidget() {
    return Column(
      children: <Widget>[
        Container(
            height: 60,
            color: TYColor.white,
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              children: <Widget>[
                getTypes("最新", 0),
                getTypes("最新", 1),
                getTypes("收藏", 2),
                Expanded(
                  child: Container(),
                ),
                GestureDetector(
                  onTap: () {
                    showSelect();
                  },
                  child: Text("赛选",
                      style: new TextStyle(
                          color: isShowSelect ? Colors.amber : Colors.black26)),
                )
              ],
            )),
        getSelectView(),
      ],
    );
  }

  /**
   * 获取赛选界面
   */
  Widget getSelectView() {
    if (isShowSelect != true) {
      return Container();
    }
    List<Widget> childList = [getTagLabel("全部", false)];
    widget.novelBookTags.forEach((types) {
      childList.add(getTagLabel(types.major, false));
    });
    List<Widget> selectList = [];
    selectList.add(Text(
      "分类",
      style: new TextStyle(fontSize: 18, color: TYColor.darkGray),
    ));
    selectList.add(Wrap(
        spacing: 6.0, // gap between adjacent chips
        runSpacing: 0.0, // gap between lines
        children: childList));
    if (_selectTag != null) {
      widget.novelBookTags.forEach((types) {
        if (_selectTag == types.major && types.mins.length > 0) {
          selectList.add(Text(
            "子分类",
            style: new TextStyle(fontSize: 18, color: TYColor.darkGray),
          ));
          List<Widget> secondChildList = [getTagLabel("全部", true)];
          types.mins.forEach((min) {
            secondChildList.add(getTagLabel(min, true));
          });
          selectList.add(Wrap(
              spacing: 6.0, // gap between adjacent chips
              runSpacing: 0.0, // gap between lines
              children: secondChildList));
        }
      });
    }
    selectList.add(RaisedButton(
        // 文本内容
        color: Colors.red,
        child: Text("确认", semanticsLabel: 'FLAT BUTTON 1'),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular((20.0)),
        ),
        onPressed: () {
          setState(() {
            isShowSelect = false;
            fetchData();
          });
        }));
    return SingleChildScrollView(
      child: Container(
        color: TYColor.white,
        padding: EdgeInsets.fromLTRB(20, 10, 20, 80),
        child: ListBody(
          children: selectList,
        ),
      ),
    );
  }

  Widget getTagLabel(String title, bool isSecond) {
    bool isSelect = false;
    if (isSecond == true) {
      if (_secondTag == null || _secondTag == "") {
        if (title == "全部") {
          isSelect = true;
        }
      } else if (_secondTag == title) {
        isSelect = true;
      }
    } else {
      if (_selectTag == null || _selectTag == "") {
        if (title == "全部") {
          isSelect = true;
        }
      } else if (_selectTag == title) {
        isSelect = true;
      }
    }

    return RaisedButton(
        // 文本内容
        color: isSelect ? Colors.amber : TYColor.paper,
        child: Text(title, semanticsLabel: 'FLAT BUTTON 1'),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular((20.0)),
        ),
        onPressed: () {
          setState(() {
            if (isSecond == true) {
              _secondTag = title;
            } else {
              _secondTag = "";
              _selectTag = title;
            }
          });
        });
  }

  Widget getTypes(String title, int index) {
    var width = (Screen.width - 15 * 2 - 15 * 2) / 8;
    bool isSelect = false;
    if (index == _selectDuration) {
      isSelect = true;
    }
    return new Container(
      child: FlatButton(
        child: new Text(title,
            style:
                new TextStyle(color: isSelect ? Colors.amber : Colors.black26)),
        onPressed: () {
          setState(() {
            _selectDuration = index;
            fetchData();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //创建界面视图
    return Scaffold(
      backgroundColor: TYColor.white,
      body: Stack(
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
              color: TYColor.white,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: getListView(),
                  ),
                ],
              )),
          getSlectWidget()
        ],
      ),
    );
  }

  /**
   * 获取目录列表页
   */
  Widget getListView() {
    if (novelBookLists == null || novelBookLists.length == 0) {
      return LoadingIndicator(
        pageState,
      );
    }
    List<Widget> chapterChildren = [];
    novelBookLists.forEach((chapterName) {
      chapterChildren.add(NovelBookListCell(chapterName));
    });
    return ListView(
      children: chapterChildren,
    );
  }

  Widget buildChapterWidget(
      BuildContext context, Novelmenu chapterName, int index) {
    return GestureDetector(
        onTap: () {
          //AppNavigator.pushComicReader(context,  widget.comicDetail,index);
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
}
