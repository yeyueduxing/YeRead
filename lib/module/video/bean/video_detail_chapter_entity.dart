class VideoDetailChapterEntity {
	List<VideosEprange> epranges;
	List<VideosL> ls;
	String name;
	int idx;

	VideoDetailChapterEntity({this.epranges, this.ls, this.name, this.idx});

	VideoDetailChapterEntity.fromJson(Map<String, dynamic> json) {
		if (json['epranges'] != null) {
			epranges = new List<VideosEprange>();(json['epranges'] as List).forEach((v) { epranges.add(new VideosEprange.fromJson(v)); });
		}
		if (json['ls'] != null) {
			ls = new List<VideosL>();(json['ls'] as List).forEach((v) { ls.add(new VideosL.fromJson(v)); });
		}
		name = json['name'];
		idx = json['idx'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.epranges != null) {
			data['epranges'] =  this.epranges.map((v) => v.toJson()).toList();
		}
		if (this.ls != null) {
			data['ls'] =  this.ls.map((v) => v.toJson()).toList();
		}
		data['name'] = this.name;
		data['idx'] = this.idx;
		return data;
	}
}

class VideosEprange {
	int b;
	int e;
	String name;

	VideosEprange({this.b, this.e, this.name});

	VideosEprange.fromJson(Map<String, dynamic> json) {
		b = json['b'];
		e = json['e'];
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['b'] = this.b;
		data['e'] = this.e;
		data['name'] = this.name;
		return data;
	}
}

class VideosL {
	List<String> url1;
	String name;
	String playcfgname1;
	int page;
	String name1;
	int episodeidx;

	VideosL({this.url1, this.name, this.playcfgname1, this.page, this.name1, this.episodeidx});

	VideosL.fromJson(Map<String, dynamic> json) {
		url1 = json['url1']?.cast<String>();
		name = json['name'];
		playcfgname1 = json['playcfgname1'];
		page = json['page'];
		name1 = json['name1'];
		episodeidx = json['episodeidx'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['url1'] = this.url1;
		data['name'] = this.name;
		data['playcfgname1'] = this.playcfgname1;
		data['page'] = this.page;
		data['name1'] = this.name1;
		data['episodeidx'] = this.episodeidx;
		return data;
	}
}
