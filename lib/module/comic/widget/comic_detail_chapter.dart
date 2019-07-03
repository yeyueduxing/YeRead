import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/module/comic/widget/comic_block_item_view.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/public.dart';

class ComicDetailChapter extends StatelessWidget {
  final ComicDetailInfoEntity comicChapter;

  ComicDetailChapter(this.comicChapter);

  Widget buildChapterWidget(BuildContext context, ComicDetailInfoComicChapter chapterName,int index) {
    return GestureDetector(
        onTap: () {
          AppNavigator.pushComicReader(context, comicChapter,index);
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              border: Border.all(color: Color(0xffe1e1e1), width: 0.5),
            ),
            alignment: Alignment.center,
            child: Text(chapterName.chapterName,
                style: TextStyle(
                    fontSize: 17,
                    color: TYColor.gray,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none))));
  }

  @override
  Widget build(BuildContext context) {
    if (comicChapter == null ||
        CollectionsUtils.isEmpty(comicChapter.comicChapter)) {
      return Container();
    }
    List<Widget> chapterChildren = [];
    int addIndex = comicChapter.comicChapter.length-1;
    for(var i=0;i<comicChapter.comicChapter.length;i++){
      if(chapterChildren.length<18){
        chapterChildren.add(buildChapterWidget(context, comicChapter.comicChapter[addIndex],addIndex));
        addIndex--;
      }
    }
    comicChapter.comicChapter.forEach((chapterName){

    });

    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                child: Text("章节目录：",
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
            GestureDetector(
              onTap: () => AppNavigator.pushComicMenu(context, comicChapter),
              child: Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: Color(0xffe1e1e1), width: 0.5),
                  ),
                  alignment: Alignment.center,
                  child: Text("全部章节",
                      style: TextStyle(
                          fontSize: 17,
                          color: TYColor.mediumGray,
                          fontWeight: FontWeight.w300,
                          decoration: TextDecoration.none))),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        physics: NeverScrollableScrollPhysics());
  }
}
