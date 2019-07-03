import 'package:flutter/material.dart';
import 'package:tianyue/module/novel/bean/novel_booklist_detail_entity.dart';

import 'package:tianyue/public.dart';
import 'package:tianyue/utility/app_utils.dart';

/**
 * 书单详情页，书单列表
 */
class NovelBookListDetailCell extends StatelessWidget {
  final NovelBooklistDetailBooklistBook info;

  NovelBookListDetailCell(this.info);

  @override
  Widget build(BuildContext context) {
    var width = Screen.width;
    return Container(
      width: width,
      child: Stack(
        children: <Widget>[buildContent(context)],
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    var width = Screen.width;
    return Container(
      width: width,
      padding: EdgeInsets.fromLTRB(15, 10 + Screen.topSafeHeight, 10, 0),
      color: TYColor.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          NovelCoverImage(AppUtils.showNovelCover(info.book.cover), width: 100, height: 133),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(info.book.title,
                    style: TextStyle(
                        fontSize: fixedFontSize(18),
                        color: TYColor.darkGray,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(info.book.author,
                    style: TextStyle(
                        fontSize: fixedFontSize(14), color: TYColor.darkGray)),
                SizedBox(height: 10),
                SizedBox(height: 10),
                SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }

}
