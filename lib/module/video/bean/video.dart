/**
 * 视频类型
 */
class Video {
  String author;
  String superscript;
  bool allowMonthly;
  int latelyFollower;
  String title;
  String lastChapter;
  String shortIntro;
  List<String> tags;
  String cover;
  int sizetype;
  String majorCate;
  String site;
  String minorCate;
  double retentionRatio;
  String sId;
  int banned;
  String contentType;

  Video({this.author, this.superscript, this.allowMonthly, this.latelyFollower, this.title, this.lastChapter, this.shortIntro, this.tags, this.cover, this.sizetype, this.majorCate, this.site, this.minorCate, this.retentionRatio, this.sId, this.banned, this.contentType});

  Video.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    superscript = json['superscript'];
    allowMonthly = json['allowMonthly'];
    latelyFollower = json['latelyFollower'];
    title = json['title'];
    lastChapter = json['lastChapter'];
    shortIntro = json['shortIntro'];
    tags = json['tags']?.cast<String>();
    cover = json['cover'];
    sizetype = json['sizetype'];
    majorCate = json['majorCate'];
    site = json['site'];
    minorCate = json['minorCate'];
    sId = json['_id'];
    banned = json['banned'];
    contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['superscript'] = this.superscript;
    data['allowMonthly'] = this.allowMonthly;
    data['latelyFollower'] = this.latelyFollower;
    data['title'] = this.title;
    data['lastChapter'] = this.lastChapter;
    data['shortIntro'] = this.shortIntro;
    data['tags'] = this.tags;
    data['cover'] = this.cover;
    data['sizetype'] = this.sizetype;
    data['majorCate'] = this.majorCate;
    data['site'] = this.site;
    data['minorCate'] = this.minorCate;
    data['retentionRatio'] = this.retentionRatio;
    data['_id'] = this.sId;
    data['banned'] = this.banned;
    data['contentType'] = this.contentType;
    return data;
  }
}