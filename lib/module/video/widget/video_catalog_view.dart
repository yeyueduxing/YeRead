import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:tianyue/common/style/ye_style.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/video/bean/video.dart';
import 'package:tianyue/module/video/bean/video_info_entity.dart';
import 'package:tianyue/public.dart';

class VideoCatalogView extends StatelessWidget {
  final VideoInfoEntity info;

  VideoCatalogView(this.info);

  @override
  Widget build(BuildContext context) {
    if (info == null) {
      return Container();
    }
    var width = Screen.width;
    var height = width * 0.55;
    return GestureDetector(
      onTap: () {
        Video video = new Video(sId: info.sid);
        AppNavigator.pushVideoDetailInfo(context, video);
      },
      child: Container(
        width: width,
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            NovelCoverImage(
              info.cover,
              width: width * 0.24,
              height: width * 0.36,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(info.title, style: YeConstant.normalTextBold),
                  Text(
                    info.time.toString(),
                    style: YeConstant.normalTextBold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 20),
                  Text(
                      info.time +
                          "/" +
                          info.writer +
                          "/" +
                          info.status +
                          "/" +
                          info.tags,
                      maxLines: 3,
                      style: YeConstant.minText)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
