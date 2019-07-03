class ComicRankEntity {
	String msg;
	List<ComicRankData> data;
	int status;

	ComicRankEntity({this.msg, this.data, this.status});

	ComicRankEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		if (json['data'] != null) {
			data = new List<ComicRankData>();(json['data'] as List).forEach((v) { data.add(new ComicRankData.fromJson(v)); });
		}
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['status'] = this.status;
		return data;
	}
}

class ComicRankData {
	String name;
	String type;
	List<ComicRankDataList> xList;

	ComicRankData({this.name, this.type, this.xList});

	ComicRankData.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		type = json['type'];
		if (json['list'] != null) {
			xList = new List<ComicRankDataList>();(json['list'] as List).forEach((v) { xList.add(new ComicRankDataList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['type'] = this.type;
		if (this.xList != null) {
      data['list'] =  this.xList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class ComicRankDataList {
	String author;
	int num;
	String name;
	int id;
	List<String> comicType;

	ComicRankDataList({this.author, this.num, this.name, this.id, this.comicType});

	ComicRankDataList.fromJson(Map<String, dynamic> json) {
		author = json['author'];
		num = json['num'];
		name = json['name'];
		id = json['id'];
		comicType = json['comic_type']?.cast<String>();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['author'] = this.author;
		data['num'] = this.num;
		data['name'] = this.name;
		data['id'] = this.id;
		data['comic_type'] = this.comicType;
		return data;
	}
}
