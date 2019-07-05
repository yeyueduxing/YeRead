class NovelChapterDetail {
	NovelChapterInfo chapter;
	bool ok;

	NovelChapterDetail({this.chapter, this.ok});

	NovelChapterDetail.fromJson(Map<String, dynamic> json) {
		chapter = json['chapter'] != null ? new NovelChapterInfo.fromJson(json['chapter']) : null;
		ok = json['ok'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.chapter != null) {
      data['chapter'] = this.chapter.toJson();
    }
		data['ok'] = this.ok;
		return data;
	}
}

class NovelChapterInfo {
	String title;
	String body;
	List<Map<String, int>> pageOffsets;
	NovelChapterInfo({this.title, this.body});

	NovelChapterInfo.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		body = json['body'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['title'] = this.title;
		data['body'] = this.body;
		return data;
	}
	int get pageCount {
		return pageOffsets.length;
	}
	String stringAtPageIndex(int index) {
		var offset = pageOffsets[index];
		return this.body.substring(offset['start'], offset['end']);
	}
}
