import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/module/comic/bean/comic_home_list_entity.dart';
import 'package:tianyue/module/video/page/video_recommend_scene.dart';
import 'package:tianyue/public.dart';

/**
 * 底部更多视图
 */
class VideoBlockBottomView extends StatelessWidget {
  ViewoReType viewoReType;

  VideoBlockBottomView(this.viewoReType);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildHeaderView(context),
    );
  }

  Widget buildHeaderView(BuildContext context) {
    return GestureDetector(
        onTap:  () => AppNavigator.pushVideoHomeList(context, viewoReType),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: new BoxDecoration(
            color: Color(0xFFf0e8e8), // 底色
            borderRadius: new BorderRadius.circular((10.0)), // 圆角度
          ),
          height: 40,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("更多", style: TextStyle(fontSize: 18)),
              SizedBox(width: 2),
              new Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFFd9d9d9),
              )
            ],
          ),
        ));
  }
}
