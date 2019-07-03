/**
 * 书单实体类
 */
class NovelBooklist {
  String cover;
  String gender;
  int bookCount;
  String author;
  int collectorCount;
  String sId;
  String title;
  String desc;
  List<String> covers;

  NovelBooklist({this.cover, this.gender, this.bookCount, this.author, this.collectorCount, this.sId, this.title, this.desc, this.covers});

  NovelBooklist.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
    gender = json['gender'];
    bookCount = json['bookCount'];
    author = json['author'];
    collectorCount = json['collectorCount'];
    sId = json['_id'];
    title = json['title'];
    desc = json['desc'];
    covers = json['covers']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cover'] = this.cover;
    data['gender'] = this.gender;
    data['bookCount'] = this.bookCount;
    data['author'] = this.author;
    data['collectorCount'] = this.collectorCount;
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['covers'] = this.covers;
    return data;
  }
}
