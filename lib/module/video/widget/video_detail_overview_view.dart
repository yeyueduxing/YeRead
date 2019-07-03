import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/video/bean/video_info_entity.dart';
import 'package:tianyue/public.dart';

class VideoDetailOverViewView extends StatelessWidget {
  final VideoInfoEntity info;

  VideoDetailOverViewView(this.info);

  @override
  Widget build(BuildContext context) {
    if (info == null) {
      return Container();
    }
    var width = Screen.width;
    var height = width * 0.55;
    return Column(
      children: <Widget>[
        Container(
          width: width,
          height: height,
          child: Stack(
            children: <Widget>[
              NovelCoverImage(
                info.cover,
                width: width,
                height: height,
              ),
              Positioned(
                bottom: 0,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 40),
                    NovelCoverImage(
                      info.cover,
                      width: width * 0.34,
                      height: width * 0.46,
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text(info.title,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none)),
                          SizedBox(width: 5),
                          Container(
                            child: Text(
                              info.originalTitle.toString(),
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.center,
                            ),
                            decoration: BoxDecoration(
                              color: TYColor.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            width: 24,
                            height: 24,
                          )
                        ]),
                        SizedBox(width: 20),
                        Text(info.company,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none)),
                        Text(info.region.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none)),
                        Text("状态：${info.status}",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none)),
                        Text("标签：${info.tags}",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
            child: Text(info.describe,
                style: TextStyle(
                    fontSize: 14,
                    color: TYColor.mediumGray,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.none)),
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20))
      ],
    );
  }
}
