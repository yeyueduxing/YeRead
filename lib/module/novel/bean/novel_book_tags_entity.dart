import 'package:tianyue/module/novel/bean/novel_tags.dart';

class NovelBookTagsEntity {
  List<NovelBookTags> female;
  List<NovelBookTags> press;
  bool ok;
  List<NovelBookTags> male;
  List<NovelBookTags> picture;

  NovelBookTagsEntity(
      {this.female, this.press, this.ok, this.male, this.picture});

  NovelBookTagsEntity.fromJson(Map<String, dynamic> json) {
    if (json['female'] != null) {
      female = new List<NovelBookTags>();
      (json['female'] as List).forEach((v) {
        female.add(new NovelBookTags.fromJson(v));
      });
    }
    if (json['press'] != null) {
      press = new List<NovelBookTags>();
      (json['press'] as List).forEach((v) {
        press.add(new NovelBookTags.fromJson(v));
      });
    }
    ok = json['ok'];
    if (json['male'] != null) {
      male = new List<NovelBookTags>();
      (json['male'] as List).forEach((v) {
        male.add(new NovelBookTags.fromJson(v));
      });
    }
    if (json['picture'] != null) {
      picture = new List<NovelBookTags>();
      (json['picture'] as List).forEach((v) {
        picture.add(new NovelBookTags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.female != null) {
      data['female'] = this.female.map((v) => v.toJson()).toList();
    }
    if (this.press != null) {
      data['press'] = this.press.map((v) => v.toJson()).toList();
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

