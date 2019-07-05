class NovelSearchHotwordEntity {
	List<NovelSearchHotwordSearchhotword> searchHotWords;
	bool ok;

	NovelSearchHotwordEntity({this.searchHotWords, this.ok});

	NovelSearchHotwordEntity.fromJson(Map<String, dynamic> json) {
		if (json['searchHotWords'] != null) {
			searchHotWords = new List<NovelSearchHotwordSearchhotword>();(json['searchHotWords'] as List).forEach((v) { searchHotWords.add(new NovelSearchHotwordSearchhotword.fromJson(v)); });
		}
		ok = json['ok'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.searchHotWords != null) {
      data['searchHotWords'] =  this.searchHotWords.map((v) => v.toJson()).toList();
    }
		data['ok'] = this.ok;
		return data;
	}
}

class NovelSearchHotwordSearchhotword {
	int times;
	int soaring;
	int isNew;
	String word;

	NovelSearchHotwordSearchhotword({this.times, this.soaring, this.isNew, this.word});

	NovelSearchHotwordSearchhotword.fromJson(Map<String, dynamic> json) {
		times = json['times'];
		soaring = json['soaring'];
		isNew = json['isNew'];
		word = json['word'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['times'] = this.times;
		data['soaring'] = this.soaring;
		data['isNew'] = this.isNew;
		data['word'] = this.word;
		return data;
	}
}
