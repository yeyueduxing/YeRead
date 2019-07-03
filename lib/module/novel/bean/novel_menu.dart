class Novelmenu {
  bool unreadble;
  String link;
  String title;

  Novelmenu({this.unreadble, this.link, this.title});

  Novelmenu.fromJson(Map<String, dynamic> json) {
    unreadble = json['unreadble'];
    link = json['link'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unreadble'] = this.unreadble;
    data['link'] = this.link;
    data['title'] = this.title;
    return data;
  }
}