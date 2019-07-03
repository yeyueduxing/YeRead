import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/app/app_navigator.dart';
import 'package:tianyue/app/ty_color.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/comic/widget/comic_rank_top_switch.dart';
import 'package:tianyue/module/novel/bean/novel_book_statistics_entity.dart';
import 'package:tianyue/module/novel/bean/novel_comment_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_menu.dart';
import 'package:tianyue/module/novel/bean/novel_menu_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_post_list_entity.dart';
import 'package:tianyue/module/novel/model/novel_model.dart';
import 'package:tianyue/module/novel/widget/novel_comment_cell.dart';
import 'package:tianyue/module/novel/widget/novel_post_cell.dart';
import 'package:tianyue/utility/app_utils.dart';
import 'package:tianyue/utility/screen.dart';
import 'package:tianyue/utility/styles.dart';
import 'package:tianyue/widget/loading_indicator.dart';
import 'package:tianyue/common/widget/novel_cover_image.dart';

/**
 * 分类页面
 */
class NovelBookStatistScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NovelBookStatistsState();
}

class NovelBookStatistsState extends State<NovelBookStatistScene>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  NovelBookStatisticsEntity novelBookStatisticsEntity;
  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();
    //初始化界面
    fetchData();
  }

  fetchData() async {
    try {
      novelBookStatisticsEntity = await NovelModel.getBookStatistics();
      setState(() {
        pageState = PageState.Content;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    if (novelBookStatisticsEntity == null) {
      return LoadingIndicator(
        pageState,
      );
    }
    //创建界面视图
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Container(
            height: 40,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("分类")),
        backgroundColor: TYColor.white,
        elevation: 0,
      ),
      backgroundColor: TYColor.white,
      body: Stack(
        children: <Widget>[
          Container(
              color: TYColor.white,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: getListView(context),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  /**
   * 获取目录列表页
   */
  Widget getListView(BuildContext context) {
    return Container(
        child: ListView(
      children: <Widget>[
        getTagView("男生","male", novelBookStatisticsEntity.male),
        getTagView("女生", "female",novelBookStatisticsEntity.female),
        getTagView("出版", "press",novelBookStatisticsEntity.press),
        getTagView("漫画", "picture",novelBookStatisticsEntity.picture),
      ],
    ));
  }

  Widget getTagView(String title,String gender, List<NovelBookStatistics> data) {
    List<Widget> chapterChildren = [];
    data.forEach((chapterName) {
      chapterChildren.add(getCateItem(context,chapterName,gender));
    });
    return Column(
      children: <Widget>[
        Text(title),
        SizedBox(height: 10,),
        Wrap(
            spacing: 15.0, // gap between adjacent chips
            runSpacing: 2.0, // gap between lines
            children: chapterChildren),
      ],
    );
  }

  Widget getCateItem(BuildContext context,NovelBookStatistics item,String gender) {
    double width = (Screen.width / 4);
    return GestureDetector(
      onTap: (){AppNavigator.pushNovelCategoryInfo(context,item,gender);},
      child: Container(
        color: TYColor.paper,
        width: width,
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.name,
                  style: new TextStyle(fontSize: 14, color: TYColor.darkGray),
                ),
                Text(
                  item.bookCount.toString() + "本",
                  style: new TextStyle(fontSize: 10, color: TYColor.golden),
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            NovelCoverImage(AppUtils.showNovelCover(item.bookCover[0]),
                width: width / 3, height: width / 2),
          ],
        ),
      ),
    );
  }

  back() {
    Navigator.pop(context);
  }
}
