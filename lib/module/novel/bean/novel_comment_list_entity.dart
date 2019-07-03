import 'package:tianyue/module/novel/bean/novel_comment.dart';

class NovelCommentListEntity {
	int total;
	List<NovelComment> reviews;
	int today;
	bool ok;

	NovelCommentListEntity({this.total, this.reviews, this.today, this.ok});

	NovelCommentListEntity.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		if (json['reviews'] != null) {
			reviews = new List<NovelComment>();(json['reviews'] as List).forEach((v) { reviews.add(new NovelComment.fromJson(v)); });
		}
		today = json['today'];
		ok = json['ok'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		if (this.reviews != null) {
      data['reviews'] =  this.reviews.map((v) => v.toJson()).toList();
    }
		data['today'] = this.today;
		data['ok'] = this.ok;
		return data;
	}
}
