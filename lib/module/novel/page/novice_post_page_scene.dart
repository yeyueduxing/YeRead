import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/app/app_navigator.dart';
import 'package:tianyue/app/ty_color.dart';
import 'package:tianyue/module/comic/bean/comic_detail_info_entity.dart';
import 'package:tianyue/module/comic/widget/comic_rank_top_switch.dart';
import 'package:tianyue/module/novel/bean/novel_comment_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_menu.dart';
import 'package:tianyue/module/novel/bean/novel_menu_list_entity.dart';
import 'package:tianyue/module/novel/bean/novel_post_list_entity.dart';
import 'package:tianyue/module/novel/model/novel_model.dart';
import 'package:tianyue/module/novel/widget/novel_comment_cell.dart';
import 'package:tianyue/module/novel/widget/novel_post_cell.dart';
import 'package:tianyue/utility/screen.dart';
import 'package:tianyue/utility/styles.dart';
import 'package:tianyue/widget/loading_indicator.dart';

enum PostType {
  Post,
  Review,
}

/**
 * 小说评论
 */
class NovelPostPageScene extends StatefulWidget {
  /// 详情
  String novelId;
  PostType postType;

  NovelPostPageScene(this.novelId, this.postType);

  @override
  State<StatefulWidget> createState() => NovelPostPageState();
}

class NovelPostPageState extends State<NovelPostPageScene>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  NovelPostListEntity novelPost;
  NovelCommentListEntity novelComments;
  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();
    //初始化界面
    fetchData();
  }

  fetchData() async {
    try {
      if (widget.postType == PostType.Post) {
        //讨论
        novelPost = await NovelModel.getNovelpost(widget.novelId, 0, 20);
      } else {
        //书评
        novelComments = await NovelModel.getNovelComment(widget.novelId, 0, 20);
      }
      setState(() {
        pageState = PageState.Content;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    if (novelPost == null && novelComments == null) {
      return LoadingIndicator(
        pageState,
      );
    }
    //创建界面视图
    return Scaffold(
      backgroundColor: TYColor.white,
      body: Stack(
        children: <Widget>[
          Container(
              color: TYColor.white,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: getListView(),
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
  Widget getListView() {
    List<Widget> chapterChildren = [];
    if (widget.postType == PostType.Post) {
      novelPost.posts.forEach((chapterName) {
        chapterChildren.add(NovelPostCell(chapterName));
      });
    } else {
      novelComments.reviews.forEach((chapterName) {
        chapterChildren.add(NovelCommentCell(chapterName));
      });
    }

    return ListView(
      children: chapterChildren,
    );
  }

  Widget buildChapterWidget(
      BuildContext context, Novelmenu chapterName, int index) {
    return GestureDetector(
        onTap: () {
          //AppNavigator.pushComicReader(context,  widget.comicDetail,index);
        },
        child: Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
            child: Text(chapterName.title,
                style: TextStyle(
                    fontSize: 17,
                    color: TYColor.gray,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none))));
  }

  back() {
    Navigator.pop(context);
  }
}
