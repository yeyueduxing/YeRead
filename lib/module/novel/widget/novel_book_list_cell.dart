import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tianyue/module/novel/bean/novel_booklist.dart';
import 'package:tianyue/module/novel/bean/novel_post.dart';

import 'package:tianyue/public.dart';
import 'package:tianyue/utility/app_utils.dart';

/**
 * 书单
 */
class NovelBookListCell extends StatelessWidget {
  final NovelBooklist book;

  NovelBookListCell(this.book);

  like() {}

  Widget buildContent(BuildContext context) {
    var width = (Screen.width - 15 * 2 - 15 * 2) / 4;
    return GestureDetector(
      onTap: (){
        AppNavigator.pushNovelBookListDetail(context, book.sId);
      },
      child:Container(
          padding: EdgeInsets.all(15),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      book.title,
                      maxLines: 1,
                      style: TextStyle(fontSize: 15, color: TYColor.darkGray),
                    ),
                    Text(
                      book.desc,
                      maxLines: 2,
                      style: TextStyle(fontSize: 14, color: TYColor.gray),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          book.bookCount.toString() +
                              "本 |" +
                              book.collectorCount.toString() +
                              "收藏",
                          maxLines: 1,
                          style: TextStyle(fontSize: 12, color: TYColor.gray),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(width: 5),
              NovelCoverImage(AppUtils.showNovelCover(book.cover),
                  width: width, height: width * 0.75),
            ],
          )) ,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildContent(context),
        Divider(height: 1, indent: 15),
      ],
    );
  }
}
