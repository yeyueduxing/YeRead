import 'package:tianyue/module/novel/bean/novel_post.dart';

class NovelPostListEntity {
	int total;
	int today;
	bool ok;
	List<NovelPost> posts;

	NovelPostListEntity({this.total, this.today, this.ok, this.posts});

	NovelPostListEntity.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		today = json['today'];
		ok = json['ok'];
		if (json['posts'] != null) {
			posts = new List<NovelPost>();(json['posts'] as List).forEach((v) { posts.add(new NovelPost.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		data['today'] = this.today;
		data['ok'] = this.ok;
		if (this.posts != null) {
      data['posts'] =  this.posts.map((v) => v.toJson()).toList();
    }
		return data;
	}
}
