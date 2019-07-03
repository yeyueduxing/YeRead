import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/module/comic/widget/comic_block_item_view.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/video/bean/video_detail_chapter_entity.dart';
import 'package:tianyue/public.dart';

class VideoDetailChapter extends StatelessWidget {
  final VideoDetailChapterEntity comicChapter;

  VideoDetailChapter(this.comicChapter);

  Widget buildChapterWidget(BuildContext context, VideosL chapterName,int index) {
    return GestureDetector(
        onTap: () {
          AppNavigator.pushVideoPlay(context,"http:"+chapterName.url1[0]);
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              border: Border.all(color: Color(0xffe1e1e1), width: 0.5),
            ),
            alignment: Alignment.center,
            child: Text(chapterName.name,
                style: TextStyle(
                    fontSize: 17,
                    color: TYColor.gray,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none))));
  }

  @override
  Widget build(BuildContext context) {
    if (comicChapter == null ||
        CollectionsUtils.isEmpty(comicChapter.ls)) {
      return Container();
    }
    List<Widget> chapterChildren = [];
    int addIndex = 0;
    comicChapter.ls.forEach((chapterName){
      chapterChildren.add(buildChapterWidget(context, chapterName,addIndex));
      addIndex++;
    });

    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                child: Text(comicChapter.name,
                    style: TextStyle(
                        fontSize: 12,
                        color: TYColor.gray,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.none)),
                padding: EdgeInsets.fromLTRB(15, 10, 10, 0)),
            GridView(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 15,
                    crossAxisCount: 3,
                    childAspectRatio: 2.4),
                children: chapterChildren,
                // 防止在row，column中不显示
                shrinkWrap: true,
                // 处理滑动冲突
                physics: NeverScrollableScrollPhysics()),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        physics: NeverScrollableScrollPhysics());
  }
}
