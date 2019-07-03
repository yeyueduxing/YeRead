import 'package:flutter/material.dart';
import 'package:tianyue/module/comic/widget/comic_block_bottom_view.dart';
import 'package:tianyue/module/comic/bean/comic_home_list_entity.dart';
import 'package:tianyue/module/video/bean/video.dart';
import 'package:tianyue/module/video/page/video_recommend_scene.dart';
import 'package:tianyue/module/video/widget/voide_block_bottom_view.dart';
import 'package:tianyue/module/video/widget/voide_block_header_view.dart';
import 'package:tianyue/module/video/widget/voide_block_item_view.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/module/comic/widget/comic_block_item_view.dart';
import 'package:tianyue/module/comic/widget/comic_block_header_view.dart';
import 'package:tianyue/utility/app_utils.dart';

/**
 * 无良推荐
 */
class VoideBlockView extends StatelessWidget {
  List<Video> homeBook;
  String title;
  ViewoReType viewoReType;
  VoideBlockView(this.title,this.homeBook,this.viewoReType);

  @override
  Widget build(BuildContext context) {
    if (homeBook == null ||  homeBook.length==0) {
      return Container();
    }
    List<Widget> blocks = [];
    homeBook.forEach((item){
      blocks.add(VideoBlockItemView(item, TYColor.white));
    });

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5),
          VoideBlockHeaderView(title),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Wrap(spacing: 15, runSpacing: 15, children: blocks),
          ),
          VideoBlockBottomView(viewoReType),
        ],
      ),
    );
  }
}
