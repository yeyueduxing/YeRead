import 'package:flutter/material.dart';
import 'package:tianyue/module/comic/bean/comic_home_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_book.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/utility/app_utils.dart';

/**
 * 小说书籍
 */
class NovelBlockItemView extends StatelessWidget {
  final NovelBook comicItem;
  final Color bgColor;

  NovelBlockItemView(this.comicItem, this.bgColor);

  @override
  Widget build(BuildContext context) {
    var width = (Screen.width - 15 * 2 - 15 * 2) / 4;
    return GestureDetector(
      onTap: () {
        AppNavigator.pushNovelDetail(context, comicItem.sId.toString());
      },
      child: Container(
        color: bgColor,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            NovelCoverImage(
                "http://statics.zhuishushenqi.com" + comicItem.cover,
                width: width, height: width / 0.75),
            Text(
              comicItem.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
              maxLines: 1,
            ),
            comicItem.shortIntro == null
                ? SizedBox(height: 1)
                : Text(
              comicItem.shortIntro,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 12,
                  color: TYColor.gray,
                  decoration: TextDecoration.none),
              maxLines: 2,
            ),

          ],
        ),
      ),
    );
  }
}
