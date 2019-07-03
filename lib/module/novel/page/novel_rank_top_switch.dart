import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tianyue/app/request.dart';
import 'package:tianyue/app/ty_color.dart';
import 'package:tianyue/module/comic/model/comic/comic_model.dart';
import 'package:tianyue/module/comic/widget/comic_block_item_view.dart';
import 'package:tianyue/module/comic/bean/comic_rank_entity.dart';
import 'package:tianyue/module/comic/bean/comic_data.dart';
import 'package:tianyue/module/comic/widget/comic_rank_item_view.dart';
import 'package:tianyue/module/novel/bean/novel_book.dart';
import 'package:tianyue/module/novel/bean/novel_rank.dart';
import 'package:tianyue/module/novel/model/novel_model.dart';
import 'package:tianyue/module/novel/widget/novel_block_item_view.dart';
import 'package:tianyue/utility/collectionsUtil.dart';
import 'package:tianyue/utility/screen.dart';
import 'package:tianyue/widget/loading_indicator.dart';

/**
 * 小说排行榜页面
 */
class NovelRankSwitchView extends StatefulWidget {
  List<NovelRank> novelRanks = [];

  /// 无良推荐
  NovelRankSwitchView(this.novelRanks);

  @override
  State<StatefulWidget> createState() => NovelRankSwitchState();
}

class NovelRankSwitchState extends State<NovelRankSwitchView> {
  List<NovelBook> blockList = [];

  int _selectTopIndex = 0;
  int _selectTypeIndex = 0;

  /// 是否请求数据完毕
  bool isDataReady = false;

  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();
    //初始化界面
    fetchData();
  }

  /**
   * 通过异步获取数据，然后动态更新
   */
  Future<void> fetchData() async {
    try {
      setState(() {
        isDataReady = false;
        pageState = PageState.Loading;
      });
      blockList.clear();
      String paarm = "";
      if (_selectTopIndex == 0) {
        //总榜
        paarm = widget.novelRanks[_selectTypeIndex].totalRank;
      } else if (_selectTopIndex == 1) {
        //月榜
        paarm = widget.novelRanks[_selectTypeIndex].monthRank;
      } else {
        //周榜
        paarm = widget.novelRanks[_selectTypeIndex].sId;
      }
      if(paarm!=null){
        blockList = await NovelModel.getRank(paarm);
      }

      setState(() {
        pageState = PageState.Content;
        if(blockList==null || blockList.length==0){
          pageState = PageState.Empty;
        }else{
          isDataReady = true;
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    //创建视图
    return Scaffold(
        body: Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: <Widget>[
          getTypeRow(),
          Expanded(
              child: Row(
            children: <Widget>[
              getTypesView(),
              Expanded(
                child: getListView(),
              ),
            ],
          ))
        ],
      ),
    ));
  }

  Widget getListView() {
    print("当前状态-"+isDataReady.toString()+"-"+pageState.toString());
    if (isDataReady == false) {
      return LoadingIndicator(
        pageState,
      );
    } else {
      List<Widget> childs = [];
      blockList.forEach((data) {
        childs.add(NovelBlockItemView(data, Colors.transparent));
      });
      return ListView(
        children: childs,
      );
    }
  }

  Widget getTypes(String title, int index) {
    var width = (Screen.width - 15 * 2 - 15 * 2) / 4;
    bool isSelect = false;
    if (index == _selectTypeIndex) {
      isSelect = true;
    }
    return new Container(
      width: width,
      child: FlatButton(
        child: new Text(title,
            style:
                new TextStyle(color: isSelect ? Colors.amber : Colors.black26)),
        onPressed: () {
          setState(() {
            _selectTypeIndex = index;
            fetchData();
          });
        },
      ),
    );
  }

  Widget getTypeRow() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        getTopRank(0),
        getTopRank(1),
        getTopRank(2),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }

  Widget getTypesView() {
    var width = (Screen.width - 15 * 2 - 15 * 2) / 3;
    List<Widget> children = [];
    int addIndex = 0;
    widget.novelRanks.forEach((ranks) {
      children.add(getTypes(ranks.shortTitle, addIndex));
      addIndex++;
    });
    return Container(
      width: width,
      child:ListView(
        children: children,
      ),
    );
  }

  ontopSlect() {}

  Widget getTopRank(int index) {
    List<String> titles = ["总", "月", "周"];
    bool isSelect = false;
    if (index == _selectTopIndex) {
      isSelect = true;
    }
    return GestureDetector(
        onTap: () {
          setState(() {
            _selectTopIndex = index;
            fetchData();
          });
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: new BoxDecoration(
            color: isSelect ? TYColor.red : TYColor.blue,
            shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
          ),
          child: new Text(titles[index],
              style: new TextStyle(color: Colors.white)),
        ));
  }
}
