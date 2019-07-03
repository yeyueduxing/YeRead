import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tianyue/app/app_scene.dart';
import 'package:tianyue/app/guide_scene.dart';
import 'package:tianyue/app/home_scene.dart';
import 'package:tianyue/app/ty_color.dart';
import 'package:tianyue/common/utils/shared_preferences.dart';
import 'package:tianyue/constant.dart';
import 'package:tianyue/module/comic/model/states/reducers.dart';
import 'package:tianyue/module/home/page/home_page.dart';

SpUtil sp;

class AppScene extends StatelessWidget {
  final Store<AppState> store;

  AppScene({this.store});

  @override
  Widget build(BuildContext context) {
    //通过StoreProvider传递给所有的Widget
    return new StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'tianyue',
          //Flutter去除右上角Debug标签
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
            dividerColor: Color(0xffeeeeee),
            scaffoldBackgroundColor: TYColor.paper,
            textTheme: TextTheme(body1: TextStyle(color: TYColor.darkGray)),
          ),
          home: new Scaffold(body: getHome()),
        ));
  }

  Widget getHome() {
    bool isFirst = false;
    if (isFirst == null || isFirst == true) {
      return GuideScene();
    } else {
      return HomePage();
    }
  }
}

void main() async {
  sp = await SpUtil.getInstance();
  bool isBog = sp.getBool(Constant.user_role);
  if(isBog==null){
    isBog = true;
  }
  Store<AppState> store = new Store<AppState>(mainReducer,
      initialState: new AppState(
        role: new RoleState(isBoy: isBog),
      ),
      middleware: [loggingMiddleware]);

  runApp(AppScene(store: store));

  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
