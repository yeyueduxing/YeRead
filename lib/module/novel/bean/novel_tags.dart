
class NovelBookTags {
  List<String> mins;
  String major;

  NovelBookTags({this.mins, this.major});

  NovelBookTags.fromJson(Map<String, dynamic> json) {
    mins = json['mins']?.cast<String>();
    major = json['major'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mins'] = this.mins;
    data['major'] = this.major;
    return data;
  }
}