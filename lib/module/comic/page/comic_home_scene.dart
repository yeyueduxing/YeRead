import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tianyue/module/comic/model/comic/comic_model.dart';
import 'package:tianyue/module/comic/model/states/reducers.dart';
import 'package:tianyue/module/comic/widget/comic_banner.dart';
import 'package:tianyue/module/comic/widget/comic_block_view.dart';
import 'package:tianyue/module/comic/widget/comic_recommend_everyday_view.dart';
import 'package:tianyue/module/comic/widget/comic_update_today_view.dart';
import 'package:tianyue/common/utils/shared_preferences.dart';
import 'package:tianyue/module/comic/bean/comic_home_list_entity.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/utility/app_utils.dart';
import 'package:tianyue/widget/loading_indicator.dart';

class ComicHomeScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ComicHomeState();
}

class ComicHomeState extends State<ComicHomeScene>
    with AutomaticKeepAliveClientMixin {
  Comic comic;

  /// banner
  List<String> banner = [];

  /// 无良推荐
  List<ComicHomeListDataBook> blockList = [];

  double navAlpha = 0;

  /// 是否请求数据完毕
  bool isDataReady = false;
  bool isGirl = false;
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
      ComicHomeListEntity enity = await ComicModel.getHomeData(context);
      banner.clear();
      blockList.clear();
      enity.data.book.forEach((data) {
        blockList.add(data);
      });
      setState(() {
        isDataReady = true;
      });
    } catch (e) {
      print(e.toString());
      Toast.show(e.toString());
    }
  }

  Future<void> switchRole(AppState state) async {
    bool isBoy = state.role.isBoy?false:true;
    StoreProvider.of<AppState>(context).dispatch(new RoleSuccessAction(isBoy:isBoy));
    //更新缓存
    SpUtil sp = await SpUtil.getInstance();
    sp.putBool(Constant.user_role, isBoy);
    fetchData();
  }

  /// 失败重试
  _retry() {
    pageState = PageState.Loading;
    setState(() {});
    fetchData();
  }

  Widget buildActions(Color iconColor) {
    return Row(children: <Widget>[
      Container(
        height: kToolbarHeight,
        width: 44,
        child: Image.asset('img/actionbar_checkin.png', color: iconColor),
      ),
      Container(
        height: kToolbarHeight,
        width: 44,
        child: Image.asset('img/actionbar_search.png', color: iconColor),
      ),
      SizedBox(width: 15)
    ]);
  }

  /**
   * 创建顶部的导航栏
   */
  Widget buildNavigationBar() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          child: Container(
            margin: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
            child: buildActions(TYColor.white),
          ),
        ),
        Opacity(
          //透明度，根据滚动来设置透明度
          opacity: navAlpha,
          child: Container(
            padding: EdgeInsets.fromLTRB(20, Screen.topSafeHeight, 20, 0),
            height: Screen.navigationBarHeight,
            color: TYColor.white,
            child: Row(
              children: <Widget>[
                new StoreConnector<AppState, AppState>(
                    builder: (BuildContext context, AppState state) {
                  //使用全局状态管理，获取用户的状态信息
                  return GestureDetector(
                      onTap: () {
                        switchRole(state);
                        print("切换角色");
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage(state.role.isBoy
                            ? 'img/ic_user_icon.png'
                            : 'img/ic_user_icon_woman.png'),
                      ));
                }, converter: (Store<AppState> store) {
                  return store.state;
                }),
                Expanded(
                  child: Text(
                    '腾讯动漫',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: TYColor.primary),
                    textAlign: TextAlign.center,
                  ),
                ),
                buildActions(TYColor.primary),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildModule(BuildContext context, int index) {
    Widget widget;
    if (index == 0) {
      banner.clear();
      blockList[0].comicInfo.forEach((data) {
        banner.add(AppUtils.joinCover(data.comicId.toString()));
      });
      widget = ComicBanner(banner);
    } else {
      widget = ComicBlockView(blockList[index]);
    }
    return widget;
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
          child: ListView.builder(
            padding: EdgeInsets.only(top: 0),
            itemCount: blockList.length,
            itemBuilder: (BuildContext context, int index) {
              return buildModule(context, index);
            },
          ),
        ),
        //buildNavigationBar(),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
