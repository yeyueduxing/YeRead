import 'package:tianyue/module/novel/bean/novel_book.dart';

class NovelRankEntity {
	NovelRankRanking ranking;
	bool ok;

	NovelRankEntity({this.ranking, this.ok});

	NovelRankEntity.fromJson(Map<String, dynamic> json) {
		ranking = json['ranking'] != null ? new NovelRankRanking.fromJson(json['ranking']) : null;
		ok = json['ok'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.ranking != null) {
      data['ranking'] = this.ranking.toJson();
    }
		data['ok'] = this.ok;
		return data;
	}
}

class NovelRankRanking {
	bool xNew;
	String gender;
	String biTag;
	String totalRank;
	String created;
	String icon;
	String monthRank;
	String shortTitle;
	bool isSub;
	String title;
	int priority;
	String cover;
	int total;
	List<NovelBook> books;
	int iV;
	String sId;
	String tag;
	String id;
	String updated;
	bool collapse;

	NovelRankRanking({this.xNew, this.gender, this.biTag, this.totalRank, this.created, this.icon, this.monthRank, this.shortTitle, this.isSub, this.title, this.priority, this.cover, this.total, this.books, this.iV, this.sId, this.tag, this.id, this.updated, this.collapse});

	NovelRankRanking.fromJson(Map<String, dynamic> json) {
		xNew = json['new'];
		gender = json['gender'];
		biTag = json['biTag'];
		totalRank = json['totalRank'];
		created = json['created'];
		icon = json['icon'];
		monthRank = json['monthRank'];
		shortTitle = json['shortTitle'];
		isSub = json['isSub'];
		title = json['title'];
		priority = json['priority'];
		cover = json['cover'];
		total = json['total'];
		if (json['books'] != null) {
			books = new List<NovelBook>();(json['books'] as List).forEach((v) { books.add(new NovelBook.fromJson(v)); });
		}
		iV = json['__v'];
		sId = json['_id'];
		tag = json['tag'];
		id = json['id'];
		updated = json['updated'];
		collapse = json['collapse'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['new'] = this.xNew;
		data['gender'] = this.gender;
		data['biTag'] = this.biTag;
		data['totalRank'] = this.totalRank;
		data['created'] = this.created;
		data['icon'] = this.icon;
		data['monthRank'] = this.monthRank;
		data['shortTitle'] = this.shortTitle;
		data['isSub'] = this.isSub;
		data['title'] = this.title;
		data['priority'] = this.priority;
		data['cover'] = this.cover;
		data['total'] = this.total;
		if (this.books != null) {
      data['books'] =  this.books.map((v) => v.toJson()).toList();
    }
		data['__v'] = this.iV;
		data['_id'] = this.sId;
		data['tag'] = this.tag;
		data['id'] = this.id;
		data['updated'] = this.updated;
		data['collapse'] = this.collapse;
		return data;
	}
}

