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
import 'package:tianyue/utility/collectionsUtil.dart';
import 'package:tianyue/utility/screen.dart';
import 'package:tianyue/widget/loading_indicator.dart';

class DmRankTopSwitchView extends StatefulWidget {
  int _selectIndex = 0;

  /// 无良推荐
  DmRankTopSwitchView(this._selectIndex);

  @override
  State<StatefulWidget> createState() => DmRankTopSwitchState();
}

class DmRankTopSwitchState extends State<DmRankTopSwitchView> {
  List<ComicRankDataList> blockList = [];

  int _selectTopIndex = 0;
  int _selectTypeIndex = 0;

  /// 是否请求数据完毕
  bool isDataReady = false;

  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();
    //初始化界面
    print("界面初始化");
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
      /**
       * 获取JSON数据
       */
      List<String> rankParam = ["all", "month", "week"];
      List<String> typeParam = [
        "renqi",
        "xinzuo",
        "changxiao",
        "wanjie",
        "tuijian",
        "yuepiao",
        "rihuo",
        "shoucang"
      ];
      blockList.clear();
      ComicRankEntity enity = await ComicModel.getRankList(typeParam[_selectTypeIndex], rankParam[_selectTopIndex]);
      enity.data.forEach((data) {
        data.xList.forEach((data2) {
          blockList.add(data2);
        });
      });
      setState(() {
        isDataReady = true;
        pageState = PageState.Content;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print("开始加载");

    print("加载成功");

    //创建视图
    return Scaffold(
        body: Container(
      margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
      child: Column(
        children: <Widget>[
          getTypeRow(),
          getTypesView(),
          Expanded(
            child: getListView(),
          )
        ],
      ),
    ));
  }

  Widget getListView() {
    List<Widget> childs = [];
    blockList.forEach((data) {
      childs.add(DmRankItemView(data, TYColor.white));
    });
    if (isDataReady == false) {
      return LoadingIndicator(
        pageState,
      );
    } else {
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
        SizedBox(width: 20,),
        new Text("排行榜",
            style: new TextStyle(
              fontSize: 30,
              color: Color(0xFF000000),
              fontWeight: FontWeight.bold,
            )),
        Expanded(
          child: Container(),
        ),
        getTopRank(0),
        getTopRank(1),
        getTopRank(2),
        SizedBox(width: 20,),
      ],
    );
  }

  Widget getTypesView() {
    List<String> typeList = [
      "人气榜",
      "新作榜",
      "畅销榜",
      "完结榜",
      "推荐榜",
      "月票榜",
      "日活榜",
      "收藏榜"
    ];
    List<Widget> children = [];
    int addIndex = 0;
    typeList.forEach((title) {
      children.add(getTypes(title, addIndex));
      addIndex++;
    });
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: Wrap(spacing: 1, runSpacing: 1, children: children),
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
          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
          decoration: new BoxDecoration(
            color: isSelect ? TYColor.red : TYColor.blue,
            shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
          ),
          child: new Text(titles[index], style: new TextStyle(color: Colors.white)),)
    );

  }
}
