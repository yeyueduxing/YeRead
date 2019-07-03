import 'package:flutter/material.dart';
import 'package:tianyue/module/novel/bean/novel_book.dart';
import 'package:tianyue/module/video/bean/video.dart';
import 'package:tianyue/module/video/bean/video_detail_comment.dart';
import 'package:tianyue/module/video/widget/video_comment_cell.dart';
import 'package:tianyue/module/video/widget/voide_block_item_view.dart';

import 'package:tianyue/public.dart';

import 'package:tianyue/book_home/home_novel_cover_view.dart';

class VideoDetailCommentView extends StatelessWidget {
  final List<VideoDetailComment> novels;

  VideoDetailCommentView(this.novels);

  Widget buildItems() {
    if(novels==null || novels.length==0){
      return Container();
    }
    var children = novels.map((novel) => VideoCommentCell(novel)).toList();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Wrap(spacing: 15, runSpacing: 20, children: children),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                Image.asset('img/home_tip.png'),
                SizedBox(width: 13),
                Text('相关评论', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          buildItems(),
        ],
      ),
    );
  }
}
