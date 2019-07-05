import 'package:flutter/material.dart';
import 'package:tianyue/module/comic/bean/comic_home_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_book.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/utility/app_utils.dart';

/**
 * 列表的数据
 */
class NovelListItemView extends StatelessWidget {
  final NovelBook comicItem;
  final Color bgColor;

  NovelListItemView(this.comicItem, this.bgColor);

  @override
  Widget build(BuildContext context) {
    var width = (Screen.width - 15 * 2 - 15 * 2) / 6;
    return GestureDetector(
      onTap: () {
        AppNavigator.pushNovelDetail(context, comicItem.sId.toString());
      },
      child: Container(
        color: bgColor,
        width: width,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            NovelCoverImage(
                "http://statics.zhuishushenqi.com" + comicItem.cover,
                width: width,
                height: width / 0.75),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    comicItem.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                    maxLines: 1,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    comicItem.shortIntro,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        color: TYColor.gray,
                        decoration: TextDecoration.none),
                    maxLines: 2,
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.face,
                        size: 15.0,
                      ),
                      Text(
                        comicItem.author,
                        style: TextStyle(
                            fontSize: 12,
                            color: TYColor.darkGray,
                            decoration: TextDecoration.none),
                        maxLines: 1,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(comicItem.minorCate==null?"无":comicItem.majorCate),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
