import 'package:flutter/material.dart';
import 'package:tianyue/module/comic/widget/comic_block_bottom_view.dart';
import 'package:tianyue/module/comic/bean/comic_home_list_entity.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/module/comic/widget/comic_block_item_view.dart';
import 'package:tianyue/module/comic/widget/comic_block_header_view.dart';
import 'package:tianyue/utility/app_utils.dart';

/**
 * 无良推荐
 */
class ComicBlockView extends StatelessWidget {
  ComicHomeListDataBook homeBook;

  ComicBlockView(this.homeBook);

  @override
  Widget build(BuildContext context) {
    if (homeBook == null || homeBook.comicInfo == null || homeBook.comicInfo.length==0) {
      return Container();
    }
    List<ComicBlock> blocks = [];
    int recomCount = 0;
    homeBook.comicInfo.forEach((item){
      if(recomCount<9){
        String cover = AppUtils.joinCover(item.comicId.toString());
        blocks.add(new ComicBlock(id:item.comicId.toString(),title: item.comicName,description: item.lastComicChapterName,cover:cover));
        recomCount++;
      }
    });
    var children = blocks
        .map((comicItem) => ComicBlockItemView(comicItem, TYColor.white))
        .toList();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5),
          ComicBlockHeaderView(homeBook.title),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Wrap(spacing: 15, runSpacing: 15, children: children),
          ),
          ComicBlockBottomView(homeBook),
        ],
      ),
    );
  }
}
