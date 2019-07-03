import 'package:tianyue/module/novel/bean/novel_menu.dart';

class NovelMenuListEntity {
	NovelMenuListMixtoc mixToc;
	bool ok;

	NovelMenuListEntity({this.mixToc, this.ok});

	NovelMenuListEntity.fromJson(Map<String, dynamic> json) {
		mixToc = json['mixToc'] != null ? new NovelMenuListMixtoc.fromJson(json['mixToc']) : null;
		ok = json['ok'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.mixToc != null) {
      data['mixToc'] = this.mixToc.toJson();
    }
		data['ok'] = this.ok;
		return data;
	}
}

class NovelMenuListMixtoc {
	List<Novelmenu> chapters;
	int chaptersCount1;
	String book;
	String chaptersUpdated;
	String sId;
	String updated;

	NovelMenuListMixtoc({this.chapters, this.chaptersCount1, this.book, this.chaptersUpdated, this.sId, this.updated});

	NovelMenuListMixtoc.fromJson(Map<String, dynamic> json) {
		if (json['chapters'] != null) {
			chapters = new List<Novelmenu>();(json['chapters'] as List).forEach((v) { chapters.add(new Novelmenu.fromJson(v)); });
		}
		chaptersCount1 = json['chaptersCount1'];
		book = json['book'];
		chaptersUpdated = json['chaptersUpdated'];
		sId = json['_id'];
		updated = json['updated'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.chapters != null) {
      data['chapters'] =  this.chapters.map((v) => v.toJson()).toList();
    }
		data['chaptersCount1'] = this.chaptersCount1;
		data['book'] = this.book;
		data['chaptersUpdated'] = this.chaptersUpdated;
		data['_id'] = this.sId;
		data['updated'] = this.updated;
		return data;
	}
}


