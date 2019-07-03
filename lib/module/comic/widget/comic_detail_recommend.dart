import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/module/comic/widget/comic_block_item_view.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/comic/bean/comic_recommend_entity.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/utility/app_utils.dart';

class ComicDetailRecommend extends StatelessWidget {
  final List<ComicRecommendEntity> comicDetail;

  ComicDetailRecommend(this.comicDetail);

  @override
  Widget build(BuildContext context) {
    if (comicDetail == null ||
        CollectionsUtils.isEmpty(comicDetail)) {
      return Container();
    }
    //推荐的不要太多了，限制为9个
    List<ComicBlock> blocks = [];
    int recomCount = 0;
    comicDetail.forEach((item){
      if(recomCount<9){
        String cover = AppUtils.joinCover(item.cartoonId.toString());
        blocks.add(new ComicBlock(id:item.cartoonId.toString(),title: item.cartoonName,cover:cover));
        recomCount++;
      }

    });
    var children = blocks
        .map((comicItem) => ComicBlockItemView(comicItem,  TYColor.white))
        .toList();
    /// 没有SingleChildScrollView，布局可能越界
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Text("骚年们都在看",
                  style: TextStyle(
                      fontSize: 15,
                      color: TYColor.gray,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.none)),
              padding: EdgeInsets.only(left: 10),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
              child: Wrap(spacing: 15, runSpacing: 15, children: children),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        /// 处理滑动冲突
        physics: NeverScrollableScrollPhysics());
  }
}
