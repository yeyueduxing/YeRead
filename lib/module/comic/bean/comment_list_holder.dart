import 'package:tianyue/module/comic/bean/comic_comment.dart';

class CommentListHolder{
  List<ComicComment> commentList;

  CommentListHolder.fromJson(Map data) {
    commentList = data['commentList'];
  }
}