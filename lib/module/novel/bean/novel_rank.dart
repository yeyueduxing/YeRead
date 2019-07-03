class NovelRank {
  String cover;
  String totalRank;
  String monthRank;
  String sId;
  String shortTitle;
  String title;
  bool collapse;

  NovelRank({this.cover, this.totalRank, this.monthRank, this.sId, this.shortTitle, this.title, this.collapse});

  NovelRank.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
    totalRank = json['totalRank'];
    monthRank = json['monthRank'];
    sId = json['_id'];
    shortTitle = json['shortTitle'];
    title = json['title'];
    collapse = json['collapse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cover'] = this.cover;
    data['totalRank'] = this.totalRank;
    data['monthRank'] = this.monthRank;
    data['_id'] = this.sId;
    data['shortTitle'] = this.shortTitle;
    data['title'] = this.title;
    data['collapse'] = this.collapse;
    return data;
  }
}