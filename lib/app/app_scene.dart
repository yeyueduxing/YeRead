import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tianyue/app/guide_scene.dart';
import 'package:tianyue/app/home_scene.dart';
import 'package:tianyue/common/utils/shared_preferences.dart';
import 'package:tianyue/public.dart';

class AppScene extends StatelessWidget {
  SpUtil sp;

  AppScene() {
    initView();
  }

  void initView() async {
    sp = await SpUtil.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tianyue',
      //Flutter去除右上角Debug标签
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        dividerColor: Color(0xffeeeeee),
        scaffoldBackgroundColor: TYColor.paper,
        textTheme: TextTheme(body1: TextStyle(color: TYColor.darkGray)),
      ),
      home: getHome(),
    );
  }

  Widget getHome() {
   bool isFirst = sp.getBool("isFirst");
   if(isFirst){
     return GuideScene();
   }else{
     return HomeScene();
   }
  }
}
