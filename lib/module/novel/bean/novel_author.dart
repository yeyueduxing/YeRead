
class NovelAuthor {
  String gender;
  String activityAvatar;
  String nickname;
  int lv;
  String sId;
  String avatar;
  String type;

  NovelAuthor({this.gender, this.activityAvatar, this.nickname, this.lv, this.sId, this.avatar, this.type});

  NovelAuthor.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    activityAvatar = json['activityAvatar'];
    nickname = json['nickname'];
    lv = json['lv'];
    sId = json['_id'];
    avatar = json['avatar'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['activityAvatar'] = this.activityAvatar;
    data['nickname'] = this.nickname;
    data['lv'] = this.lv;
    data['_id'] = this.sId;
    data['avatar'] = this.avatar;
    data['type'] = this.type;
    return data;
  }
}
