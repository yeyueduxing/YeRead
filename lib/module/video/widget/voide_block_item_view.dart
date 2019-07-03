import 'package:flutter/material.dart';
import 'package:tianyue/module/comic/bean/comic_home_list_entity.dart';
import 'package:tianyue/module/video/bean/video.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/utility/app_utils.dart';

class VideoBlockItemView extends StatelessWidget {
  final Video comicItem;
  final Color bgColor;

  VideoBlockItemView(this.comicItem, this.bgColor);

  @override
  Widget build(BuildContext context) {
    var width = (Screen.width - 15 * 2 - 15 * 2) / 3;
    return GestureDetector(
      onTap: () {
        AppNavigator.pushVideoDetailInfo(context, comicItem);
      },
      child: Container(
        color: bgColor,
        width: width,
        child: Column(
          children: <Widget>[
            NovelCoverImage(comicItem.cover,
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
                    maxLines: 1,
                  ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
