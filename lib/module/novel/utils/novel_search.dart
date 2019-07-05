import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tianyue/common/search/search_key_bean.dart';
import 'package:tianyue/module/novel/bean/novel_book.dart';
import 'package:tianyue/module/novel/bean/novel_search_hotword_entity.dart';
import 'package:tianyue/module/novel/model/novel_model.dart';
import 'package:tianyue/module/novel/widget/novel_lisy_item_view.dart';

/**
 * 小说搜索
 */
class NovelSearch{

  static Future<SearchKeyBean> getSuggestlist() async {
    SearchKeyBean searchKeyBean = new SearchKeyBean();
    List<SearchKeyNode> nodes = [];
    List<NovelSearchHotwordSearchhotword> list = await NovelModel.getBookSearchHotwords();
    print(list.toString());
    list.forEach((item){
      SearchKeyNode node = new SearchKeyNode();
      node.name = item.word;
      nodes.add(node);
    });
    searchKeyBean.nodes = nodes;
    return searchKeyBean;
  }

  static Widget getSearchWidget(List bean) {
    List<Widget> chapterChildren = [];
    bean.forEach((chapterName) {
      chapterChildren.add(NovelListItemView(chapterName, Colors.transparent));
    });
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView(
        children: chapterChildren,
      ),
    );
  }

  static Future<List<NovelBook>> getSearchData(String key) async {
    List<NovelBook> list = await NovelModel.getBookSearchList(key, 0, 20);
    return list;
  }
}