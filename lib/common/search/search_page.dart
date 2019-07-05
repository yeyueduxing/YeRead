import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/common/search/search_key_bean.dart';
import 'package:tianyue/module/novel/bean/novel_book.dart';
import 'package:tianyue/module/novel/model/novel_model.dart';
import 'package:tianyue/module/novel/widget/novel_lisy_item_view.dart';

final String URL_HOT_KEY = 'http://www.wanandroid.com/hotkey/json';
final String URL_SEARCH = 'http://www.wanandroid.com/article/query/0/json';

List<SearchKeyNode> nodes = [];

class searchBarDelegate extends SearchDelegate<String> {
  //获取搜索建议列表
  SearchSuggestClaaback searchSuggestClaaback;

  //获取搜索结果列表
  SearchListClaaback searchListClaaback;

  //获取搜索界面样式
  SearchWidgetClaaback searchWidgetClaaback;

  searchBarDelegate(this.searchSuggestClaaback, this.searchListClaaback,
      this.searchWidgetClaaback);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSearchFutureBuilder(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //如果说已经加载过一次搜索热榜，那么下次就不再重复加载了
    if (nodes == null || nodes.length == 0) {
      return buildDefaultFutureBuilder();
    } else {
      return new SearchDefaultView(
        nodes: nodes,
        callback: (key) {
          query = key;
          showResults(context);
        },
      );
    }
  }

  FutureBuilder<SearchKeyBean> buildDefaultFutureBuilder() {
    return new FutureBuilder<SearchKeyBean>(
      builder: (context, AsyncSnapshot<SearchKeyBean> async) {
        if (async.connectionState == ConnectionState.active ||
            async.connectionState == ConnectionState.waiting) {
          return new Center(
            child: new Text('Waitiing...'),
          );
        }

        if (async.connectionState == ConnectionState.done) {
          debugPrint('done');
          if (async.hasError) {
            return new Center(
              child: new Text('Error:code '),
            );
          } else if (async.hasData) {
            SearchKeyBean bean = async.data;
            nodes = bean.nodes;
            if(nodes==null){
              nodes = [];
            }
            return new SearchDefaultView(
              nodes: nodes,
              callback: (key) {
                query = key;
                showResults(context);
              },
            );
          }
        }
      },
      future: getData(),
    );
  }

  Future<SearchKeyBean> getData() async {
    SearchKeyBean bean = new SearchKeyBean();
    bean = await searchSuggestClaaback();
    nodes = bean.nodes;
    return bean;
  }

  FutureBuilder<List> buildSearchFutureBuilder(String key) {
    //获取搜索结果
    return new FutureBuilder<List>(
      builder: (context, AsyncSnapshot<List> async) {
        if (async.connectionState == ConnectionState.active ||
            async.connectionState == ConnectionState.waiting) {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }
        if (async.connectionState == ConnectionState.done) {
          debugPrint('done');
          if (async.hasError) {
            return new Center(
              child: new Text('Error:code '),
            );
          } else if (async.hasData) {
            return searchWidgetClaaback(async.data);
          }
        }
      },
      future: searchListClaaback(key),
    );
  }
}

class SearchDefaultView extends StatelessWidget {
  final List<SearchKeyNode> nodes;
  final callback;

  SearchDefaultView({this.nodes, this.callback});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        SearchDefaultItemView(
          nodes: nodes,
          callback: callback,
        ),
      ],
    );
  }
}

class SearchDefaultItemView extends StatelessWidget {
  final List<SearchKeyNode> nodes;
  final callback;

  SearchDefaultItemView({this.nodes, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              '大家都在搜',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10.0,
            ),
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: nodes.map((childNode) {
                return GestureDetector(
                  child: new ClipRRect(
                    child: Container(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        childNode.name,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blue,
                    ),
                    borderRadius: new BorderRadius.circular(3.0),
                  ),
                  onTap: () {
                    callback(childNode.name);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

typedef SearchSuggestClaaback = Future<SearchKeyBean> Function();
typedef SearchWidgetClaaback = Widget Function(List data);
typedef SearchListClaaback = Future<List> Function(String key);
