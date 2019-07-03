import 'package:tianyue/module/novel/bean/novel_booklist.dart';

class NovelBooklistEntity {
	int total;
	List<NovelBooklist> bookLists;
	bool ok;

	NovelBooklistEntity({this.total, this.bookLists, this.ok});

	NovelBooklistEntity.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		if (json['bookLists'] != null) {
			bookLists = new List<NovelBooklist>();(json['bookLists'] as List).forEach((v) { bookLists.add(new NovelBooklist.fromJson(v)); });
		}
		ok = json['ok'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		if (this.bookLists != null) {
      data['bookLists'] =  this.bookLists.map((v) => v.toJson()).toList();
    }
		data['ok'] = this.ok;
		return data;
	}
}
