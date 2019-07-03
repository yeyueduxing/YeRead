import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tianyue/module/video/bean/video_detail_comment.dart';

import 'package:tianyue/public.dart';
import 'package:tianyue/utility/app_utils.dart';

class VideoCommentCell extends StatelessWidget {
  final VideoDetailComment comment;

  VideoCommentCell(this.comment);

  like() {}

  Widget buildButton(
      String image, String title, VoidCallback onPress, bool isSelected) {
    return Row(
      children: <Widget>[
        Image.asset(image),
        SizedBox(width: 5),
        Text(
          title,
          style: TextStyle(
              fontSize: 14,
              color: isSelected ? Color(0xfff5a623) : TYColor.gray),
        )
      ],
    );
  }

  Widget buildContent() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 10),
              Text(comment.title,
                  style: TextStyle(fontSize: 14, color: TYColor.gray)),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(35, 15, 15, 0),
            child: Text(comment.content, style: TextStyle(fontSize: 16)),
          ),
          Row(
            children: <Widget>[
              Text(comment.time,
                  style: TextStyle(fontSize: 14, color: TYColor.gray)),
              Expanded(child: Container()),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildContent(),
        Divider(height: 1, indent: 15),
      ],
    );
  }
}
