import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tianyue/public.dart';

import 'package:tianyue/book_home/home_scene.dart';
import 'package:tianyue/module/comic/page/comic_home_scene.dart';
import 'package:tianyue/me/me_scene.dart';
import 'package:tianyue/video/video_scene.dart';
import 'package:tianyue/widget/loading_indicator.dart';

/**
 * 通用的底部切换标签页
 */
class BottomPage extends StatefulWidget {
  final List<Image> tabImages;
  List<Image> tabSelectedImages;
  List<Widget> pageView;

  BottomPage(this.tabImages,this.tabSelectedImages,this.pageView,
      {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => RootSceneState();
}

class RootSceneState extends State<BottomPage> {
  int _tabIndex = 0;
  bool isFinishSetup = false;
  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();
    setupApp();

  }

  @override
  void dispose() {
    super.dispose();
  }

  setupApp() async {
    preferences = await SharedPreferences.getInstance();
    await Future.delayed(Duration(milliseconds: 2000), () {
      pageState = PageState.Content;
    });
    setState(() {
      isFinishSetup = true;
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('提示'),
        content: new Text('客官，确定退出app?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('放弃'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('退出'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    if (!isFinishSetup) {
      return LoadingIndicator(
        pageState,
      );
    }
    return WillPopScope(
      //双机返回和退出
      onWillPop: _onWillPop, // look here!
      child: Scaffold(
        body: IndexedStack(
          children: widget.pageView,
          index: _tabIndex,
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Colors.white,
          activeColor: TYColor.primary,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: getTabIcon(0)),
            BottomNavigationBarItem(icon: getTabIcon(1)),
            BottomNavigationBarItem(icon: getTabIcon(2)),
            BottomNavigationBarItem(icon: getTabIcon(3)),
          ],
          currentIndex: _tabIndex,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ),
      ),
    );
  }

  Image getTabIcon(int index) {
    if (index == _tabIndex) {
      return widget.tabSelectedImages[index];
    } else {
      return widget.tabImages[index];
    }
  }
}
