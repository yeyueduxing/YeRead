
import 'package:tianyue/module/novel/bean/novel_author.dart';

class NovelComment {
  NovelAuthor author;
  String created;
  int rating;
  int likeCount;
  String sId;
  NovelCommentListReviewsHelpful helpful;
  String state;
  String title;
  String updated;
  String content;
  int commentCount;

  NovelComment({this.author, this.created, this.rating, this.likeCount, this.sId, this.helpful, this.state, this.title, this.updated, this.content, this.commentCount});

  NovelComment.fromJson(Map<String, dynamic> json) {
    author = json['author'] != null ? new NovelAuthor.fromJson(json['author']) : null;
    created = json['created'];
    rating = json['rating'];
    likeCount = json['likeCount'];
    sId = json['_id'];
    helpful = json['helpful'] != null ? new NovelCommentListReviewsHelpful.fromJson(json['helpful']) : null;
    state = json['state'];
    title = json['title'];
    updated = json['updated'];
    content = json['content'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['created'] = this.created;
    data['rating'] = this.rating;
    data['likeCount'] = this.likeCount;
    data['_id'] = this.sId;
    if (this.helpful != null) {
      data['helpful'] = this.helpful.toJson();
    }
    data['state'] = this.state;
    data['title'] = this.title;
    data['updated'] = this.updated;
    data['content'] = this.content;
    data['commentCount'] = this.commentCount;
    return data;
  }
}

class NovelCommentListReviewsHelpful {
  int no;
  int total;
  int yes;

  NovelCommentListReviewsHelpful({this.no, this.total, this.yes});

  NovelCommentListReviewsHelpful.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    total = json['total'];
    yes = json['yes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['total'] = this.total;
    data['yes'] = this.yes;
    return data;
  }
}
