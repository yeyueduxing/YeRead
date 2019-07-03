import 'package:flutter/material.dart';
import 'package:tianyue/common/style/ye_style.dart';
import 'package:tianyue/module/comic/bean/comic_home_list_entity.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/utility/app_utils.dart';

class ComicBlockItemView extends StatelessWidget {
  final ComicBlock comicItem;
  final Color bgColor;

  ComicBlockItemView(this.comicItem, this.bgColor);

  @override
  Widget build(BuildContext context) {
    var width = (Screen.width - 15 * 2 - 15 * 2) / 3;
    return GestureDetector(
      onTap: () {
        AppNavigator.pushComicDetail(context, comicItem.id.toString());
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
              style: YeConstant.middleText,
              maxLines: 1,
            ),
            comicItem.description == null
                ? SizedBox(height: 1)
                : Text(
                    comicItem.description,
                    overflow: TextOverflow.ellipsis,
                    style: YeConstant.smallSubLightText,
                    maxLines: 1,
                  ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
