import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tianyue/module/novel/bean/novel_post.dart';

import 'package:tianyue/public.dart';
import 'package:tianyue/utility/app_utils.dart';

/**
 * 小说讨论
 */
class NovelPostCell extends StatelessWidget {
  final NovelPost comment;

  NovelPostCell(this.comment);

  like() {}

  Widget buildButton(String image, String title, VoidCallback onPress, bool isSelected) {
    return Row(
      children: <Widget>[
        Image.asset(image),
        SizedBox(width: 5),
        Text(
          title,
          style: TextStyle(fontSize: 14, color: isSelected ? Color(0xfff5a623) : TYColor.gray),
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
              CircleAvatar(
                radius: 13,
                backgroundImage: CachedNetworkImageProvider(AppUtils.showNovelCover(comment.author.avatar)),
              ),
              SizedBox(width: 10),
              Text(comment.author.nickname, style: TextStyle(fontSize: 14, color: TYColor.gray)),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(35, 15, 15, 0),
            child: Text(comment.content==null?comment.title:comment.content, style: TextStyle(fontSize: 16)),
          ),
          Row(
            children: <Widget>[
              Text(comment.updated,
                  style: TextStyle(fontSize: 14, color: TYColor.gray)),
              Expanded(child: Container()),
              Icon(Icons.accessible_forward),
              Text(comment.likeCount.toString(),
                  style: TextStyle(fontSize: 14, color: TYColor.gray)),
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
