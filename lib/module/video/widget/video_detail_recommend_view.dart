import 'package:flutter/material.dart';
import 'package:tianyue/module/novel/bean/novel_book.dart';
import 'package:tianyue/module/video/bean/video.dart';
import 'package:tianyue/module/video/widget/voide_block_item_view.dart';

import 'package:tianyue/public.dart';

import 'package:tianyue/book_home/home_novel_cover_view.dart';

class VideoDetailRecommendView extends StatelessWidget {
  final List<Video> novels;

  VideoDetailRecommendView(this.novels);

  Widget buildItems() {
    if(novels==null || novels.length==0){
      return Container();
    }
    var children = novels.map((novel) => VideoBlockItemView(novel,TYColor.white)).toList();
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
                Text('相关推荐', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          buildItems(),
        ],
      ),
    );
  }
}
