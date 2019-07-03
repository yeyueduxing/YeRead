
import 'package:tianyue/module/novel/bean/novel_author.dart';

class NovelPost {
  NovelAuthor author;
  String created;
  NovelPostListPostsBook book;
  int likeCount;
  String type;
  String title;
  String content;
  int commentCount;
  String block;
  String sId;
  String state;
  int voteCount;
  bool haveImage;
  String updated;

  NovelPost({this.author, this.created, this.book, this.likeCount, this.type, this.title, this.content, this.commentCount, this.block, this.sId, this.state, this.voteCount, this.haveImage, this.updated});

  NovelPost.fromJson(Map<String, dynamic> json) {
    author = json['author'] != null ? new NovelAuthor.fromJson(json['author']) : null;
    created = json['created'];
    book = json['book'] != null ? new NovelPostListPostsBook.fromJson(json['book']) : null;
    likeCount = json['likeCount'];
    type = json['type'];
    title = json['title'];
    content = json['content'];
    commentCount = json['commentCount'];
    block = json['block'];
    sId = json['_id'];
    state = json['state'];
    voteCount = json['voteCount'];
    haveImage = json['haveImage'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['created'] = this.created;
    if (this.book != null) {
      data['book'] = this.book.toJson();
    }
    data['likeCount'] = this.likeCount;
    data['type'] = this.type;
    data['title'] = this.title;
    data['content'] = this.content;
    data['commentCount'] = this.commentCount;
    data['block'] = this.block;
    data['_id'] = this.sId;
    data['state'] = this.state;
    data['voteCount'] = this.voteCount;
    data['haveImage'] = this.haveImage;
    data['updated'] = this.updated;
    return data;
  }
}

class NovelPostListPostsBook {
  String cover;
  dynamic retentionRatio;
  dynamic latelyFollower;
  String sId;
  String title;

  NovelPostListPostsBook({this.cover, this.retentionRatio, this.latelyFollower, this.sId, this.title});

  NovelPostListPostsBook.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
    retentionRatio = json['retentionRatio'];
    latelyFollower = json['latelyFollower'];
    sId = json['_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cover'] = this.cover;
    data['retentionRatio'] = this.retentionRatio;
    data['latelyFollower'] = this.latelyFollower;
    data['_id'] = this.sId;
    data['title'] = this.title;
    return data;
  }
}
