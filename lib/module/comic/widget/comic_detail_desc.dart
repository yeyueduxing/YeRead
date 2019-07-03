import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/module/comic/widget/comic_block_item_view.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/public.dart';

class ComicDetailDesc extends StatelessWidget {
  final ComicDetailInfoEntity comicDetail;

  ComicDetailDesc(this.comicDetail);

  @override
  Widget build(BuildContext context) {
    if (comicDetail == null ||
        CollectionsUtils.isEmpty(comicDetail.comicChapter)) {
      return Container();
    }
    /// 没有SingleChildScrollView，布局可能越界
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                child: Text(comicDetail.comicDesc,
                    style: TextStyle(
                        fontSize: 14,
                        color: TYColor.mediumGray,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.none)),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 20)),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        /// 处理滑动冲突
        physics: NeverScrollableScrollPhysics());
  }
}
