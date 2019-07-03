class NovelBookStatisticsEntity {
	List<NovelBookStatistics> female;
	List<NovelBookStatistics> press;
	bool ok;
	List<NovelBookStatistics> male;
	List<NovelBookStatistics> picture;

	NovelBookStatisticsEntity({this.female, this.press, this.ok, this.male, this.picture});

	NovelBookStatisticsEntity.fromJson(Map<String, dynamic> json) {
		if (json['female'] != null) {
			female = new List<NovelBookStatistics>();(json['female'] as List).forEach((v) { female.add(new NovelBookStatistics.fromJson(v)); });
		}
		if (json['press'] != null) {
			press = new List<NovelBookStatistics>();(json['press'] as List).forEach((v) { press.add(new NovelBookStatistics.fromJson(v)); });
		}
		ok = json['ok'];
		if (json['male'] != null) {
			male = new List<NovelBookStatistics>();(json['male'] as List).forEach((v) { male.add(new NovelBookStatistics.fromJson(v)); });
		}
		if (json['picture'] != null) {
			picture = new List<NovelBookStatistics>();(json['picture'] as List).forEach((v) { picture.add(new NovelBookStatistics.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.female != null) {
      data['female'] =  this.female.map((v) => v.toJson()).toList();
    }
		if (this.press != null) {
      data['press'] =  this.press.map((v) => v.toJson()).toList();
    }
		data['ok'] = this.ok;
		if (this.male != null) {
      data['male'] =  this.male.map((v) => v.toJson()).toList();
    }
		if (this.picture != null) {
      data['picture'] =  this.picture.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class NovelBookStatistics {
	int bookCount;
	int monthlyCount;
	String name;
	String icon;
	List<String> bookCover;

	NovelBookStatistics({this.bookCount, this.monthlyCount, this.name, this.icon, this.bookCover});

	NovelBookStatistics.fromJson(Map<String, dynamic> json) {
		bookCount = json['bookCount'];
		monthlyCount = json['monthlyCount'];
		name = json['name'];
		icon = json['icon'];
		bookCover = json['bookCover']?.cast<String>();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['bookCount'] = this.bookCount;
		data['monthlyCount'] = this.monthlyCount;
		data['name'] = this.name;
		data['icon'] = this.icon;
		data['bookCover'] = this.bookCover;
		return data;
	}
}

