import 'package:tianyue/module/novel/bean/novel_rank.dart';

/**
 * 获取所有的排行榜数据
 */
class NovelRankResponseEntity {
  List<NovelRank> epub;
  List<NovelRank> female;
  bool ok;
  List<NovelRank> male;
  List<NovelRank> picture;

  NovelRankResponseEntity(
      {this.epub, this.female, this.ok, this.male, this.picture});

  NovelRankResponseEntity.fromJson(Map<String, dynamic> json) {
    if (json['epub'] != null) {
      epub = new List<NovelRank>();
      (json['epub'] as List).forEach((v) {
        epub.add(new NovelRank.fromJson(v));
      });
    }
    if (json['female'] != null) {
      female = new List<NovelRank>();
      (json['female'] as List).forEach((v) {
        female.add(new NovelRank.fromJson(v));
      });
    }
    ok = json['ok'];
    if (json['male'] != null) {
      male = new List<NovelRank>();
      (json['male'] as List).forEach((v) {
        male.add(new NovelRank.fromJson(v));
      });
    }
    if (json['picture'] != null) {
      picture = new List<NovelRank>();
      (json['picture'] as List).forEach((v) {
        picture.add(new NovelRank.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.epub != null) {
      data['epub'] = this.epub.map((v) => v.toJson()).toList();
    }
    if (this.female != null) {
      data['female'] = this.female.map((v) => v.toJson()).toList();
    }
    data['ok'] = this.ok;
    if (this.male != null) {
      data['male'] = this.male.map((v) => v.toJson()).toList();
    }
    if (this.picture != null) {
      data['picture'] = this.picture.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
