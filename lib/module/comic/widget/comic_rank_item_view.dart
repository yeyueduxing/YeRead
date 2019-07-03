import 'package:flutter/material.dart';
import 'package:tianyue/module/comic/bean/comic_data.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/module/comic/bean/comic_rank_entity.dart';
import 'package:tianyue/utility/app_utils.dart';
/**
 * 排行榜的视图
 */
class DmRankItemView extends StatelessWidget {
  final ComicRankDataList comicItem;
  final Color bgColor;

  DmRankItemView(this.comicItem, this.bgColor);

  @override
  Widget build(BuildContext context) {
    var width = (Screen.width) / 5;
    return GestureDetector(
      onTap: () {
        AppNavigator.pushComicDetail(context, comicItem.id.toString());
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        width: Screen.width,
        child: Row(
          children: <Widget>[
            NovelCoverImage(AppUtils.joinCover(comicItem.id.toString()),
                width: width, height: width / 0.75),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  comicItem.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                  maxLines: 1,
                ),
                SizedBox(height: 20,),
                Text(
                  AppUtils.showLookNum(comicItem.num),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      color: TYColor.gray,
                      decoration: TextDecoration.none),
                  maxLines: 1,
                ),
                SizedBox(height: 20,),
                Text(
                  comicItem.comicType.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      color: TYColor.gray,
                      decoration: TextDecoration.none),
                  maxLines: 1,
                ),
              ],
            ),
            Expanded(child: Container()),
            Column(
              children: <Widget>[
                Image.asset("img/ic_more_toread.png",width: 25,height: 25,),
                SizedBox(height: 5,),
                Text(
                  "速看",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      color: TYColor.gray,
                      decoration: TextDecoration.none),
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
