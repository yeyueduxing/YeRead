import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tianyue/app/ty_color.dart';
import 'package:tianyue/module/comic/model/states/reducers.dart';

/**
 * 主页drawer
 * Created by guoshuyu
 * Date: 2018-07-18
 */
class HomeDrawer extends StatelessWidget {
  DrawerSelectClaaback claaback;
  HomeDrawer({this.claaback});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: new StoreBuilder<AppState>(
        builder: (context, store) {
          return new Drawer(
            ///侧边栏按钮Drawer
            child: new Container(
              ///默认背景
              child: new SingleChildScrollView(
                ///item 背景
                child: Container(
                  constraints: new BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                  child: new Material(
                    color: TYColor.white,
                    child: new Column(
                      children: <Widget>[
                        new UserAccountsDrawerHeader(
                          //Material内置控件
                          accountName: new Text("夜月"),
                          //用户名
                          //用户邮箱
                          currentAccountPicture: new GestureDetector(
                            //用户头像
                            onTap: () {},
                            child: new CircleAvatar(
                              //圆形图标控件
                              backgroundImage: new NetworkImage("https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2595508360,28762262&fm=27&gp=0.jpg"),
                            ),
                          ),
                          decoration: new BoxDecoration(
                            //用一个BoxDecoration装饰器提供背景图片
                          ),
                        ),
                        new ListTile(
                            title: new Text("漫画"),
                            onTap: () {
                              claaback(0);
                            }),
                        new ListTile(
                            title: new Text("小说"
                            ),
                            onTap: () {
                              claaback(1);
                            }),
                        new ListTile(
                            title: new Text("动画"
                            ),
                            onTap: () {
                              claaback(2);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
typedef DrawerSelectClaaback = Future<void> Function(int index);