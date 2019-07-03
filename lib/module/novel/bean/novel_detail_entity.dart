/**
 * 小说详情
 */
class NovelDetailEntity {
	bool isForbidForFreeApp;
	String copyright;
	String superscript;
	NovelDetailRating rating;
	bool allowMonthly;
	dynamic discount;
	String lastChapter;
	String cover;
	bool isSerial;
	String copyrightDesc;
	String minorCate;
	bool limit;
	bool bLe;
	int postCount;
	bool donate;
	String contentType;
	bool allowBeanVoucher;
	int wordCount;
	String author;
	List<Null> tags;
	String minorCateV2;
	int sizetype;
	String majorCate;
	int serializeWordCount;
	String creater;
	String longIntro;
	String sId;
	bool isAllowNetSearch;
	String updated;
	bool hasCp;
	List<String> gender;
	bool hasCopyright;
	String authorDesc;
	int chaptersCount;
	List<Null> anchors;
	bool advertRead;
	String title;
	bool isFineBook;
	String originalAuthor;
	String majorCateV2;
	int safelevel;
	String cat;
	String retentionRatio;
	int currency;
	bool allowVoucher;
	int banned;
	bool isMakeMoneyLimit;
	int followerCount;
	int buytype;
	int latelyFollower;
	bool allowFree;
	bool bGg;

	NovelDetailEntity({this.isForbidForFreeApp, this.copyright, this.superscript, this.rating, this.allowMonthly, this.discount, this.lastChapter, this.cover, this.isSerial, this.copyrightDesc, this.minorCate, this.limit, this.bLe, this.postCount, this.donate, this.contentType, this.allowBeanVoucher, this.wordCount, this.author, this.tags, this.minorCateV2, this.sizetype, this.majorCate, this.serializeWordCount, this.creater, this.longIntro, this.sId, this.isAllowNetSearch, this.updated, this.hasCp, this.gender, this.hasCopyright, this.authorDesc, this.chaptersCount, this.anchors, this.advertRead, this.title, this.isFineBook, this.originalAuthor, this.majorCateV2, this.safelevel, this.cat, this.retentionRatio, this.currency, this.allowVoucher, this.banned, this.isMakeMoneyLimit, this.followerCount, this.buytype, this.latelyFollower, this.allowFree, this.bGg});

	NovelDetailEntity.fromJson(Map<String, dynamic> json) {
		isForbidForFreeApp = json['isForbidForFreeApp'];
		copyright = json['copyright'];
		superscript = json['superscript'];
		rating = json['rating'] != null ? new NovelDetailRating.fromJson(json['rating']) : null;
		allowMonthly = json['allowMonthly'];
		discount = json['discount'];
		lastChapter = json['lastChapter'];
		cover = json['cover'];
		isSerial = json['isSerial'];
		copyrightDesc = json['copyrightDesc'];
		minorCate = json['minorCate'];
		limit = json['limit'];
		bLe = json['_le'];
		postCount = json['postCount'];
		donate = json['donate'];
		contentType = json['contentType'];
		allowBeanVoucher = json['allowBeanVoucher'];
		wordCount = json['wordCount'];
		author = json['author'];
		if (json['tags'] != null) {
			tags = new List<Null>();
		}
		minorCateV2 = json['minorCateV2'];
		sizetype = json['sizetype'];
		majorCate = json['majorCate'];
		serializeWordCount = json['serializeWordCount'];
		creater = json['creater'];
		longIntro = json['longIntro'];
		sId = json['_id'];
		isAllowNetSearch = json['isAllowNetSearch'];
		updated = json['updated'];
		hasCp = json['hasCp'];
		gender = json['gender']?.cast<String>();
		hasCopyright = json['hasCopyright'];
		authorDesc = json['authorDesc'];
		chaptersCount = json['chaptersCount'];
		if (json['anchors'] != null) {
			anchors = new List<Null>();
		}
		advertRead = json['advertRead'];
		title = json['title'];
		isFineBook = json['isFineBook'];
		originalAuthor = json['originalAuthor'];
		majorCateV2 = json['majorCateV2'];
		safelevel = json['safelevel'];
		cat = json['cat'];
		retentionRatio = json['retentionRatio'];
		currency = json['currency'];
		allowVoucher = json['allowVoucher'];
		banned = json['banned'];
		isMakeMoneyLimit = json['isMakeMoneyLimit'];
		followerCount = json['followerCount'];
		buytype = json['buytype'];
		latelyFollower = json['latelyFollower'];
		allowFree = json['allowFree'];
		bGg = json['_gg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['isForbidForFreeApp'] = this.isForbidForFreeApp;
		data['copyright'] = this.copyright;
		data['superscript'] = this.superscript;
		if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
		data['allowMonthly'] = this.allowMonthly;
		data['discount'] = this.discount;
		data['lastChapter'] = this.lastChapter;
		data['cover'] = this.cover;
		data['isSerial'] = this.isSerial;
		data['copyrightDesc'] = this.copyrightDesc;
		data['minorCate'] = this.minorCate;
		data['limit'] = this.limit;
		data['_le'] = this.bLe;
		data['postCount'] = this.postCount;
		data['donate'] = this.donate;
		data['contentType'] = this.contentType;
		data['allowBeanVoucher'] = this.allowBeanVoucher;
		data['wordCount'] = this.wordCount;
		data['author'] = this.author;
		if (this.tags != null) {
      data['tags'] =  [];
    }
		data['minorCateV2'] = this.minorCateV2;
		data['sizetype'] = this.sizetype;
		data['majorCate'] = this.majorCate;
		data['serializeWordCount'] = this.serializeWordCount;
		data['creater'] = this.creater;
		data['longIntro'] = this.longIntro;
		data['_id'] = this.sId;
		data['isAllowNetSearch'] = this.isAllowNetSearch;
		data['updated'] = this.updated;
		data['hasCp'] = this.hasCp;
		data['gender'] = this.gender;
		data['hasCopyright'] = this.hasCopyright;
		data['authorDesc'] = this.authorDesc;
		data['chaptersCount'] = this.chaptersCount;
		if (this.anchors != null) {
      data['anchors'] =  [];
    }
		data['advertRead'] = this.advertRead;
		data['title'] = this.title;
		data['isFineBook'] = this.isFineBook;
		data['originalAuthor'] = this.originalAuthor;
		data['majorCateV2'] = this.majorCateV2;
		data['safelevel'] = this.safelevel;
		data['cat'] = this.cat;
		data['retentionRatio'] = this.retentionRatio;
		data['currency'] = this.currency;
		data['allowVoucher'] = this.allowVoucher;
		data['banned'] = this.banned;
		data['isMakeMoneyLimit'] = this.isMakeMoneyLimit;
		data['followerCount'] = this.followerCount;
		data['buytype'] = this.buytype;
		data['latelyFollower'] = this.latelyFollower;
		data['allowFree'] = this.allowFree;
		data['_gg'] = this.bGg;
		return data;
	}
}

class NovelDetailRating {
	double score;
	int count;
	bool isEffect;
	String tip;

	NovelDetailRating({this.score, this.count, this.isEffect, this.tip});

	NovelDetailRating.fromJson(Map<String, dynamic> json) {
		score = json['score'];
		count = json['count'];
		isEffect = json['isEffect'];
		tip = json['tip'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['score'] = this.score;
		data['count'] = this.count;
		data['isEffect'] = this.isEffect;
		data['tip'] = this.tip;
		return data;
	}
}
